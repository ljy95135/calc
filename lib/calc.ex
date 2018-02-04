defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  main

  ## Examples

      mix run -e Calc.main
      start the loop
  """
  def main() do
    eval(IO.gets(""))
    main()
  end

  @doc """
  eval
  caculate the result and puts at screen.
  """
  def eval(str) do
    charList = String.graphemes(str)
    IO.inspect(charList)
    calcList = strToList(charList, [])
    IO.inspect(calcList)
    listToResult(calcList,[],[])
  end

  @doc """
  listToResult
  From infix list to result
  """
  def listToResult(calc, numStack, opStack) do
    cond do

    end
  end

  @doc """
  strToList
  From string to number-operator List
  """
  def strToList(chars, result) do
    cond do
      # return condition
      List.first(chars) == "\n" ->
        result

      # operator
      List.first(chars) == "+" or List.first(chars) == "-"
      or List.first(chars) == "*" or List.first(chars) == "/"
      or List.first(chars) == "(" or List.first(chars) == ")" ->
        strToList(getTail(chars), result ++ [List.first(chars)])

      # space
      List.first(chars) == " " ->
        strToList(getTail(chars), result)

      # number, if not, will raise a error.
      true -> getNumber(chars, result)
    end
  end

  @doc """
  getNumber
  Use Integer.parse to get the number
  """
  def getNumber(l, result) do
    tup = Integer.parse(Enum.join(l))
    chars = String.graphemes(elem(tup, 1))
    strToList(chars, result ++ [elem(tup, 0)])
  end

  @doc """
  getTail
  Get the tail of a List.
  """
  def getTail(l) do
    [_ | tail] = l
    tail
  end
end
