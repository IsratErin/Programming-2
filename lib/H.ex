defmodule H do
  def test() do
    hanoi(4,:a,:b,:c)
  end
  def test1() do
    hanoi(1,:a,:b,:c)
  end
  def hanoi(0, _from, _aux, _to), do: []
  def hanoi(n, from, aux, to) do
    hanoi(n - 1, from, to, aux) ++
    [{:move,from, to}] ++
    hanoi(n - 1, aux, from, to)
  end

end
