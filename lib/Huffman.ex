defmodule Huffman do





    def tree(sample) do
    # To implement...
    freq = freq(sample)
    huffman(freq)
    end


    def freq(sample) do
      freq(sample,[])
    end
    def freq([], freq) do
      freq
    end
    def freq([char | rest], freq) do
      freq(rest, update(char,freq))
    end

    def update(char, []) do
      [{char,1}]
    end
    def update(char,[{char,n} | t]) do
      [{char,n + 1} | t]
    end
    def update(char, [h | t]) do
      [h | update(char, t)]
    end
    def huffman(freq) do
      sorted = Enum.sort(freq, fn({_, x}, {_, y}) -> x < y end)
      huffman_tree(sorted)
    end

  def huffman_tree([{tree, _}]) do tree end
  def huffman_tree([{a1, af}, {b1, bf} | rest]) do
    huffman_tree(insert({{a1, b1}, af + bf}, rest))
  end

  def insert({a1, af}, []), do: [{a1, af}]

  #changed
  def insert({a1, af}, [{b1, bf} | rest]) do
    if af < bf do
      [{a1, af}, {b1, bf} | rest]
    else
      [{b1, bf} | insert({a1, af}, rest)]
    end
  end

  def encode_table(tree) do
    find_path(tree, [])
  end

  def find_path({left, right}, path) do
    left_path = find_path(left, path ++ [0])
    right_path = find_path(right, path ++ [1])

    left_path ++  right_path
  end
  def find_path(tree, path) do
    [{tree, path}]
  end

  def decode_table(tree) do
    encode_table(tree)
  end

  def encode(text, table) do
    get_bits(text, table)
  end

  def get_bits([], _) do [] end
  def get_bits([char | rest], tree) do
    get_path(char, tree) ++ get_bits(rest, tree)
  end

  def get_path(char, [{tree_char, path} | rest]) do
    if char == tree_char do
      path
    else
      get_path(char, rest)
    end
  end

  def decode([], _) do [] end
  def decode(seq, tree) do
    {char, rest} = decode_char(seq, 1, tree)
    [char | decode(rest, tree)]
  end

  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {char, _} ->
        {char, rest};
      nil ->
        decode_char(seq, n + 1, table)
    end
  end

  def read1(file) do
    {:ok, file} = File.open(file,[:read, :utf8])
    binary = IO.read(file,:all)
    File.close(file)
    case :unicode.characters_to_list(binary, :utf8) do
    {:incomplete, list, _} ->
      list
      list ->
           list
          end
     end
     def read(file, n) do
      {:ok, fd} = File.open(file, [:read, :utf8])
       binary = IO.read(fd, n)
       File.close(fd)

       length = byte_size(binary)
       case :unicode.characters_to_list(binary, :utf8) do
         {:incomplete, chars, rest} ->
           {chars, length - byte_size(rest)}
         chars ->
           {chars, length}
       end
     end


     def bench(file,n) do
      {text, b} = read(file,n)
      c = length(text)
      {tree, t2} = time(fn -> tree(text) end)
      {encode, t3} = time(fn -> encode_table(tree) end)
      s = length(encode)
      {decode, _} = time(fn -> decode_table(tree) end)
      {encoded, t5} = time(fn -> encode(text, encode) end)
      e = div(length(encoded), 8)
      r = Float.round(e / b, 3)
      {_, t6} = time(fn -> decode(encoded, decode) end)

      IO.puts("text of #{c} characters")
      IO.puts("tree built in #{t2} ms")
      IO.puts("table of size #{s} in #{t3} ms")
      IO.puts("encoded in #{t5} ms")
      IO.puts("decoded in #{t6} ms")
      IO.puts("source #{b} bytes, encoded #{e} bytes, compression #{r}")
    end
    def test do
      n= 30000
      t= 60000
      s= 120000
      y= 240000
      z= 480000
      i= 700000
      IO.puts(" 1:")
        bench("lib/h.txt", n)

        IO.puts("\n")
        IO.puts(" 2:")
        bench("lib/h.txt", t)

        IO.puts("\n")
        IO.puts(" 3:")
        bench("lib/h.txt", s)
        IO.puts("\n")
        IO.puts(" 4:")

        bench("lib/h.txt", y)
        IO.puts("\n")
        IO.puts(" 5:")

        bench("lib/h.txt", z)
        IO.puts("\n")
        IO.puts(" 6:")

        bench("lib/h.txt", i)


    end



    # Measure the execution time of a function.
    def time(func) do
      initial = Time.utc_now()
      result = func.()
      final = Time.utc_now()
      {result, Time.diff(final, initial, :microsecond) / 1000}
    end





    end
