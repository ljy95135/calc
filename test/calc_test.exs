defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "expression" do
    # all string will end in \n because IO.gets will get the \n
    # at the end of string.
    assert Calc.eval("1\n") == 1
    assert Calc.eval(" 1 \n") == 1
    assert Calc.eval("(1)\n") == 1
    assert Calc.eval("  ((  1 ))  \n") == 1
    assert Calc.eval("1+2+3\n") == 6
    assert Calc.eval("1 + 2 + 3\n") == 6
    assert Calc.eval("1   +2+3\n") == 6
    assert Calc.eval("20/4\n") == 5
    assert Calc.eval("20 / 12\n") == 1
    assert Calc.eval("24 / 6 + (5 - 4)\n") == 5
    assert Calc.eval("24 / 6 + (4*(1+2))\n") == 16
  end
end
