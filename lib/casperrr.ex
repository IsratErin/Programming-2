defmodule Casperrr do
  def build_map({:node, :na, left, right}, map, path) do
    map = build_map(left, map, path <> "-")
    build_map(right, map, path <> ".")
  end

  def build_map({:node, char, left,right }, map, path) do
    case {:node, char, left, right} do
      {:node, char, :nil, :nil} ->
         Map.put(map, [char], path)
         {:node, char, left, :nil}-> map = build_map(left, map, path <> "-")
         Map.put(map, [char], path)
         {:node, char, :nil, right}-> map = build_map(right, map, path <> ".")
         Map.put(map, [char], path)
         {:node, char, left, right}-> map = build_map(left, map, path <> "-")
         map = build_map(right, map, path <> ".")
         Map.put(map, [char], path)
    end
  end
  def build_map(_, map, _) do map end


  def map() do
    tree = Morse.morse()
    build_map(tree, %{}, "")
  end
  def encode(charlist) do

     map = map()
     encoder(map, charlist, "")
   end
  def encoder(_, [], encoded) do encoded end
  def encoder(map, [h | t], encoded) do
     case Map.get(map, [h]) do
       nil ->
         encoder(map, t, encoded)
       char ->
         encoder(map, t, encoded <> " " <> char)
     end
  end


end
