defmodule EnvList do
  def new() do [] end
  def add([], key, value) do
     [{key,value}]
  end
  def add([{key,_}|map], key, value) do
    [{key,value}|map]
  end
  def add([h|map], key, value) do
    [h|add(map,key,value)]
  end


  def lookup([],_) do  nil end

  def lookup([{key1,value}|map],key) do
    if key1 == key do
      {key,value}
    else
      lookup(map,key)
    end

  end

  def remove([], _key) do  []  end
  def remove([{key,_}|map], key) do map end
  def remove([kv|map], key) do [kv|remove(map, key)] end





end
