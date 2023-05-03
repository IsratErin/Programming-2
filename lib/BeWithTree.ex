defmodule BeWithTree do

  def bench(n) do
    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

    :io.format("# benchmark with ~w operations in List, time per operation in us\n", [n])
    :io.format("~6.s~12.s~12.s~12.s\n", ["n", "add", "lookup", "remove"])
    Enum.each(ls, fn (i) ->
    {i, tla, tll, tlr} = bench(i, n)
    :io.format("~6.w~12.3f~12.3f~12.3f\n", [i, tla/n, tll/n, tlr/n])
    end)

    ## For the tree
    :io.format("# benchmark with ~w operations in Tree , time per operation in us\n", [n])
    :io.format("~6.s~12.s~12.s~12.s\n", ["n", "add", "lookup", "remove"])
    Enum.each(ls, fn (i) ->
    {i, tta, ttl, ttr} = bench1(i, n)
    :io.format("~6.w~12.3f~12.3f~12.3f\n", [i, tta/n, ttl/n, ttr/n])
    end)
    ## For the map
    :io.format("# benchmark with ~w operations in Map , time per operation in us\n", [n])
    :io.format("~6.s~12.s~12.s~12.s\n", ["n", "add", "lookup", "remove"])
    Enum.each(ls, fn (i) ->
    {i, tma, tml, tmr} = bench2(i, n)
    :io.format("~6.w~12.3f~12.3f~12.3f\n", [i, tma/n, tml/n, tmr/n])
    end)


    end

  def bench(i, n) do
    seq = Enum.map(1..i, fn(_) -> :rand.uniform(i) end)
    list = Enum.reduce(seq, EnvList.new(), fn(e, list) ->
    EnvList.add(list, e, :foo)
    end)
    seq = Enum.map(1..n, fn(_) -> :rand.uniform(i) end)
    {add, _} = :timer.tc(fn() ->
    Enum.each(seq, fn(e) ->
    EnvList.add(list, e, :foo)
  end)
end)
{lookup, _} = :timer.tc(fn() ->
  Enum.each(seq, fn(e) ->
  EnvList.lookup(list, e)
  end)
  end)
  {remove, _} = :timer.tc(fn() ->
  Enum.each(seq, fn(e) ->
  EnvList.remove(list, e)
  end)
  end)
  {i, add, lookup, remove}
  end

  def bench1(i, n) do
    seq = Enum.map(1..i, fn(_) -> :rand.uniform(i) end)
    list = Enum.reduce(seq, EnvTree.new(), fn(e, list) ->
    EnvTree.add(list, e, :foo)
    end)

    seq = Enum.map(1..n, fn(_) -> :rand.uniform(i) end)
    {add, _} = :timer.tc(fn() ->
    Enum.each(seq, fn(e) ->
    EnvTree.add(list, e, :foo)
  end)
end)
{lookup, _} = :timer.tc(fn() ->
  Enum.each(seq, fn(e) ->
  EnvTree.lookup(list, e)
  end)
  end)
  {remove, _} = :timer.tc(fn() ->
  Enum.each(seq, fn(e) ->
  EnvTree.remove(list, e)
  end)
  end)
  {i, add, lookup, remove}
  end

  def bench2(i, n) do
    seq = Enum.map(1..i, fn(_) -> :rand.uniform(i) end)
    list = Enum.reduce(seq, Map.new(), fn(e, list) ->
    Map.put(list, e, :foo)
    end)

    seq = Enum.map(1..n, fn(_) -> :rand.uniform(i) end)
    {add, _} = :timer.tc(fn() ->
    Enum.each(seq, fn(e) ->
    Map.put(list, e, :foo)
  end)
end)
{lookup, _} = :timer.tc(fn() ->
  Enum.each(seq, fn(e) ->
  Map.get(list, e)
  end)
  end)
  {remove, _} = :timer.tc(fn() ->
  Enum.each(seq, fn(e) ->
  Map.delete(list, e)
  end)
  end)
  {i, add, lookup, remove}
  end


end
