defmodule Derivative do
  @type literal() :: {:num, number()}
| {:var, atom()}
@type expr() :: {:add, expr(), expr()}
| {:mul, expr(), expr()}
| {:exp, expr(), literal()}
| {:frac, literal(), literal()}
| literal()


def test do
  test =  {:add, {:mul, {:num, 4}, {:exp, {:var, :x}, {:num, 2}}},
  {:add, {:mul, {:num, 3}, {:var, :x}}, {:num, 42}}}

  der= deriv(test, :x)
  simpl = simplify(der)

  IO.write("expression: #{pprint(test)}\n")
  IO.write("derivative: #{pprint(der)}\n")
  IO.write("simplified: #{pprint(simpl)}\n")

end
def test1 do
  expr = {:sin,{:mul,{:num,2},{:var,:x}}}
  h= deriv(expr,:x)
  IO.write("expression: #{pprint(expr)}\n")
   IO.write("derivative: #{pprint(h)}\n")
   d = simplify(h)
   IO.write("simplified: #{pprint(d)}\n")

end


def deriv({:num, _}, _) do {:num, 0} end
def deriv({:var, v}, v) do {:num, 1} end
def deriv({:var, _}, _) do {:num, 0} end
def deriv({:mul, e1, e2}, v) do
  {:add,
  {:mul,deriv(e1,v),e2},
  {:mul,deriv(e2,v),e1}}
end
def deriv({:add, e1, e2}, v) do
  {:add, deriv(e1,v), deriv(e2,v)}
end
def deriv({:exp, e1,{:num, n}},v) do
  {:mul,
{:mul,{:num,n},{:exp, e1,{:num, n-1}}}, deriv(e1,v)}
end


def deriv({:ln, e}, v) do {:frac,deriv(e,v),e} end

def deriv({:frac,e1,e2},v) do
  {:frac,{:sub,{:mul,e2,deriv(e1,v)},{:mul,e1,deriv(e2,v)}},{:mul,e2,e2}}
end
def deriv({:sqrt,e1},v) do
  {:frac,deriv(e1,v),{:mul,{:const,2},{:sqrt,e1}}}
end
def deriv({:sin,e1},v) do
  {:mul,{:cos,e1},deriv(e1,v)}
end



def simplify({:num,n}) do {:num, n} end

def simplify({:var,v}) do {:var, v} end

def simplify ({:add, e1, e2}) do
  simplify_add(simplify(e1),simplify(e2))
end
def simplify ({:sub, e1, e2}) do
  simplify_sub(simplify(e1),simplify(e2))
end
def simplify({:mul, e1, e2}) do
  simplify_mul(simplify(e1),simplify(e2))
end
def simplify({:exp, e1,e2}) do
    simplify_exp(simplify(e1),simplify(e2))
end
def simplify({:ln,e1}) do
  simplify_ln(simplify(e1))
end
def simplify({:frac,e1,e2}) do
  simplify_frac(simplify(e1),simplify(e2))
end
def simplify({:sqrt,e1}) do
  simplify_sqrt(simplify(e1))
end
def simplify({:sin,e1}) do
  simplify_sin(simplify(e1))
end
def simplify({:cos,e1}) do
  simplify_cos(simplify(e1))
end




def simplify_add({:num,0},e2) do e2 end

def simplify_add(e1,{:num,0}) do e1 end

def simplify_add({:var, v}, {:var, v}) do {:mul, {:num, 2}, {:var, v}} end
def simplify_add({:num,a1},{:num,a2}) do {:num,a1+a2} end
def simplify_add(e1,e2) do {:add,e1,e2} end



def simplify_sub(e1,{:num,0}) do e1 end


def simplify_sub({:var, v}, {:var, v}) do {:num, 0} end
def simplify_sub({:num,a1},{:num,a2}) do {:num,a1-a2} end
def simplify_sub(e1,e2) do {:sub,e1,e2} end


def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul(_, {:num, 0}) do {:num, 0} end
  def simplify_mul({:num, 1}, e2) do e2 end
  def simplify_mul(e1, {:num, 1}) do e1 end

  def simplify_mul({:var, v}, {:var, v}) do {:exp, {:var, v}, {:num, 2}} end
  def simplify_mul({:var, v}, {:exp, {:var, v}, {:num, n}}) do {:exp, {:var, v}, {:num, n+1}} end
  def simplify_mul({:exp, {:var, v}, {:num, n}}, {:var, v}) do {:exp, {:var, v}, {:num, n+1}} end

  def simplify_mul({:num, n1}, {:mul, {:num, n2}, e2}) do
    {:mul, {:num, n1*n2}, e2}
  end
  def simplify_mul({:num, n1}, {:mul, e2, {:num, n2}}) do
    {:mul, {:num, n1*n2}, e2}
  end
  def simplify_mul({:mul, {:num, n1}, e1}, {:num, n2}) do
    {:mul, {:num, n1*n2}, e1}
  end
  def simplify_mul({:mul, e1, {:num, n1}}, {:num, n2}) do
    {:mul, {:num, n1*n2}, e1}
  end


  def simplify_mul(e1, e2) do {:mul, e1, e2} end

   def simplify_frac(e1,{:num,1}) do e1 end
   def simplify_frac({:num,1},e2) do {:frac,{:num,1},e2} end

   def simplify_frac({:num,0},_) do {:num,0} end
   def simplify_frac(_,{:num,0}) do {:const, 1} end
   def simplify_frac(e1,e2) do {:frac,e1,e2} end


def simplify_exp(_,{:num,0}) do {:num,1} end
def simplify_exp(e1,{:num,1}) do e1 end
def simplify_exp({:num,0},_) do  {:num,0}end
def simplify_exp({:num,1},_) do  {:num,1}end
def simplify_exp({:num,n1},{:num,n2}) do {:num, :math.pow(n1,n2)} end
def simplify_exp(e1,e2) do {:exp,e1,e2} end



 def simplify_ln({:num, 1}) do {:num, 0} end
 def simplify_ln({:num, 0}) do :nil end
 def simplify_ln(e) do {:ln, e} end

 def simplify_sqrt({:num,1}) do {:num,1} end
 def simplify_sqrt({:num,0}) do {:num,0} end
 def simplify_sqrt(e1) do {:sqrt,e1} end

 def simplify_sin({:num,0}) do {:num,0} end
 def simplify_sin(e1) do {:sin,e1} end


 def simplify_cos({:num,0}) do {:num,1} end
 def simplify_cos(e1) do {:cos,e1} end


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
  def pprint({:exp, e1, e2}) do
    "#{pprint(e1)}^#{pprint(e2)}"
  end
  def pprint({:ln,e1}) do
    " ln #{pprint(e1)}"
  end
  def pprint({:frac, e1, e2}) do
    "( #{pprint(e1)} / #{pprint(e2)} )"
  end
  def pprint({:sqrt,e1}) do
    " sqrt#{pprint(e1)}"
  end
  def pprint({:sin,e1}) do
    " sin#{pprint(e1)}"
  end
  def pprint({:cos,e1}) do
    " cos#{pprint(e1)}"
  end




end
