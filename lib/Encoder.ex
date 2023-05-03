defmodule Encoder do


  def encode(string) do
    encode(string,encoding_table(),[])
  end
  def encode([],_, coded) do Enum.reverse(coded) end
  def encode([char|string],table, sofar) do
  encode(string,table, encode_lookup(char, table) ++[32] ++ sofar)
  end



  def codes(:nil, _) do [] end


  def codes({:node,char, long,short},code) do
    case {:node,char, long,short} do
      {:node,:na, long,short}->
        codes(long,[?-|code]) ++ codes(short,[?.|code])
        {:node,char,long,short}->
          [{char,code}]++ codes(long,[?-|code]) ++ codes(short,[?.|code])
    end
  end

  def encode_lookup(char,[{char, code} | _]) do code  end
  def encode_lookup(char,[_ | rest]) do encode_lookup(char,rest) end
  def encode_lookup(char, map) do Map.get(map, char) end

  def encoding_table() do
    codes = codes(Morse.morse(),[])
    Enum.reduce(codes, %{},fn({char,code },acc) -> Map.put(acc,char,code)end)
  end



end
