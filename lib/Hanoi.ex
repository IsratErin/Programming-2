
  defmodule Hanoi do

    def test() do
      #IO.puts("[")
      hanoi(3,:a,:b,:c)
     # IO.puts("]")
    end


  def hanoi(n,from,aux,to) when n > 0 do

    hanoi(n-1,from,to,aux)

    IO.puts("{:move, :#{from}, :#{to}}")

    hanoi(n-1,aux,from,to)

   end
   def hanoi(0, _, _, _) do nil end
  end
