defmodule Train do
  def take(_,0) do [] end
  def take([h|t],n) when n>0 do
    [h|take(t,n-1)]
  end
  #drop
  def drop([],_) do [] end
  def drop([h|t],n) do
    if n>0 do
      drop(t,n-1)
     else
      [h|t]
      end
    end
    def append([], ys) do ys end
    def append([h|t], ys) do [h|append(t,ys)] end

  def member([],_) do
    false
  end
  def member([h|t],y) do
    if h==y do
      true
    else
      member(t,y)
    end
  end

  def position([h|_],h) do 1 end
  def position([_|t],y) do
     position(t,y) +1

  end

  def split([y|t], y) do  {[], t}  end
  def split([h|t], y) do
    {t, drop} = split(t, y)
    {[h|t], drop}
  end

  def main([], n) do {n, [], []} end
  def main([h|t], n) do
    IO.inspect(h)
    IO.inspect(t)
    IO.inspect(main(t,n), label: "funct")
    IO.inspect(t)
      case main(t, n) do

	{0, drop, take} ->
	  {0, [h|drop], take} |> IO.inspect(label: "n=0")


	{n, drop, take} ->
	  {n-1, drop, [h|take]} |> IO.inspect(label: "n>0")

      end

  end



end
