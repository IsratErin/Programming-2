defmodule Expression do
  @type literal() :: {:num, number()}
  | {:var, atom()}
  | {:q,number(),number()}

@type expr() :: {:add, expr(), expr()}
| {:sub, expr(), expr()}
| {:mul, expr(), expr()}
| {:div, expr(), expr()}
|literal()



def testexp1() do
  te =   {:add, {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 3}}, {:q, 1,2}}
  e = eval(te,Env)

  IO.write("expression: #{pprint(te)}\n")
  IO.write("evaluated: #{pprint(e)}\n")
end
def testexp() do
  te =   {:mul, {:num,5},{:num,5}}
  eval(te,Env)
end

def eval({:num, n }, Env) do {:num, n } end
def eval({:var, v }, Env) do  {:var, v } end
def eval({:add, e1 , e2}, Env) do
add(e1 , e2)
end

def eval({:sub, e1 , e2}, Env) do
  sub(e1 , e2)
end
def eval({:mul, e1 , e2}, Env) do
  mul(e1 , e2)
end

def eval({:div, e1 , e2}, Env) do
  divi(e1 , e2)
end


def add({:num,0},e2) do e2 end
def add(e1,{:num,0}) do e1 end
def add({:var, v}, {:var, v}) do {:mul, {:num, 2}, {:var, v}} end
def add({:num,a1},{:num,a2}) do {:num,a1+a2} end
def add(e1,e2) do {:add,e1,e2} end

def sub({:num,0},e2) do e2 end
def sub(e1,{:num,0}) do e1 end
def sub({:var, v}, {:var, v}) do  {:num,0} end
def sub({:num,a1},{:num,a2}) do {:num,a1-a2} end
def sub(e1,e2) do {:sub,e1,e2} end

def mul({:num,0},_) do {:num,0} end
def mul(_,{:num,0}) do {:num,0} end
def mul({:var, v}, {:var, v}) do  {:exp,{:var,v},{:num,2}} end
def mul({:num,a1},{:num,a2}) do {:num,a1*a2} end
def mul(e1,e2) do {:mul,e1,e2} end


def divi({:num,0},_) do {:num,0} end
def divi(_,{:num,0}) do nil end
def divi({:var, v}, {:var, v}) do  {:num, 1} end
def divi({:num,a1},{:num,a2}) do {:q,a1,a2} end
def divi(e1,e2) do {:div,e1,e2} end

def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1, e2}) do
    "#{pprint(e1)} + #{pprint(e2)}"
  end
  def pprint({:sub, e1, e2}) do
    "#{pprint(e1)} - #{pprint(e2)}"
  end
  def pprint({:mul, e1, e2}) do
    "( #{pprint(e1)} * #{pprint(e2)} )"
  end

end
