defmodule Ex do

  @type literal() :: {:num, number()}
  | {:var, atom()}
  | {:q,number(),number()}

@type expr() :: {:add, expr(), expr()}
| {:sub, expr(), expr()}
| {:mul, expr(), expr()}
| {:div, expr(), expr()}
|literal()



  def test() do
   env = Map.put(%{}, :x, 4)
   env= Map.put(env,:y, 2)
  # (2x + y) + (1/4)
    expr =   {:add, {:add, {:mul, {:num, 2}, {:var, :x}}, {:var, :y}}, {:q, 1, 4}}
    eval(expr, env)
  end
  def test2() do
    env = Map.put(%{}, :x, 3)

    # 2x *(3/4)
    expr = {:mul,{:mul,{:num,2}, {:var, :x}}, {:q, 3,4}}
    eval(expr, env)
  end




  def eval({:num, n}, _) do {:num,n} end

  def eval({:var, v}, env) do {:num,Map.get(env,v)}  end

  def eval({:add, e1, e2},env) do
    add(eval(e1,env), eval(e2,env))
  end

  def eval({:sub, e1, e2},env) do
    sub(eval(e1,env), eval(e2,env))
  end
  def eval({:mul, e1, e2}, env) do
    mul(eval(e1,env),eval(e2,env))
  end
  def eval({:q, e1, e2}, _) do
    {:q,e1,e2}
  end

  def eval({:div, e1, e2}, env) do
    divide(eval(e1,env),eval(e2,env))
  end

  def add({:num,0},e2) do e2 end
  def add(e1,{:num,0}) do e1 end
  def add({:var, v}, {:var, v}) do {:mul, {:num, 2}, {:var, v}} end
  def add({:num,a1},{:num,a2}) do {:num,a1+a2} end
  def add({:num,a1},{:q,a2,a3}) do
     {:q,(a1*a3)+a2,a3}

  end
  def add(e1,e2) do {:add,e1,e2}
  end

  def sub({:num,0},e2) do e2 end
  def sub(e1,{:num,0}) do e1 end
  def sub({:var, v}, {:var, v}) do  {:num, 0} end
  def sub({:num,a1},{:num,a2}) do {:num,a1-a2} end


  def mul({:num,0},_) do {:num,0} end
  def mul(_,{:num,0}) do {:num,0} end
  def mul({:var, v}, {:var, v}) do  {:exp,{:var,v},{:num,2}} end
  def mul({:num,a1},{:num,a2}) do {:num,a1*a2} end

  def mul({:num,a1},{:q,m,n}) do
    divide({:num,a1*m},{:num,n})
  end

  def divide({:num,0},_) do {:num,0} end
  def divide(_,{:num,0}) do nil end

  def divide({:num, n1}, {:num, n2}) do
    # checking for remainder
    if rem(n1, n2) == 0 do
      {:num, trunc(n1 / n2)}
    else
      {:q, trunc(n1/Integer.gcd(n1,n2)), trunc(n2/Integer.gcd(n1,n2))}
    end
  end













end
