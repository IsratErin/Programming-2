defmodule Decoder do

  def decode(s) do
    t = table()
    decode(s, t, [])
  end
  def table() do
    Morse.morse()
  end
  def decode([], _, d) do Enum.reverse(d) end

    def decode(s, table , d) do
      {char, rest} = decode_char(s,table)
      decode(rest, table,[char|d])
    end


    def decode_char(s) do
      table = table()
      decode_char(s,table)
    end
    def decode_char([],{:node, char, _, _}) do {char,[]} end

    def decode_char([?-|s], {:node, _, long, _}) do
      decode_char(s, long)
    end
    def decode_char([?.| s], {:node, _,_, short}) do
      decode_char(s,short)
    end

    def decode_char([?\s|s], {:node,:na , _, _ }) do
    {?*,s}
    end
    def decode_char([?\s|s], {:node,char , _, _ }) do
      {char,s}
    end


end
