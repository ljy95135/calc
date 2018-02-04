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
    calcList = strToList(charList, [])
    result = listToResult(calcList, [], [])
    IO.puts(result)
  end

  # From infix list to result
  defp listToResult(calc, numStack, opStack) do
    {tmp, calc} = List.pop_at(calc, 0)

    case tmp do
      # nil, then compute until get a answer or error
      nil ->
        getAnswer(numStack, opStack)

      # operator
      "+" ->
        addOrMinus(calc, tmp, numStack, opStack)

      "-" ->
        addOrMinus(calc, tmp, numStack, opStack)

      "*" ->
        multiOrDiv(calc, tmp, numStack, opStack)

      "/" ->
        multiOrDiv(calc, tmp, numStack, opStack)

      "(" ->
        opStack = [tmp | opStack]
        listToResult(calc, numStack, opStack)

      ")" ->
        listToResultUntilLeftParen(calc, numStack, opStack)

      # else number
      _ ->
        numStack = [tmp | numStack]
        listToResult(calc, numStack, opStack)
    end
  end

  # The list is empty and try to get the result.
  defp getAnswer(numStack, opStack) do
    if length(opStack) == 0 do
      # should get only 1 number which is the result
      if length(numStack) == 1 do
        List.first(numStack)
      else
        raise("invalid input")
      end
    else
      # continue to compute
      {x2, numStack} = List.pop_at(numStack, 0)
      {x1, numStack} = List.pop_at(numStack, 0)
      {op, opStack} = List.pop_at(opStack, 0)
      res = compute(x1, x2, op)
      numStack = [res | numStack]
      getAnswer(numStack, opStack)
    end
  end

  # For add/minus operator
  defp addOrMinus(calc, op, numStack, opStack) do
    op0 = List.first(opStack)
    # will compute + - * /
    if op0 == "(" or op0 == nil do
      opStack = [op | opStack]
      listToResult(calc, numStack, opStack)
    else
      {_, opStack} = List.pop_at(opStack, 0)
      {x2, numStack} = List.pop_at(numStack, 0)
      {x1, numStack} = List.pop_at(numStack, 0)
      res = compute(x1, x2, op0)
      numStack = [res | numStack]
      opStack = [op | opStack]
      listToResult(calc, numStack, opStack)
    end
  end

  # For multiplication/division operator
  defp multiOrDiv(calc, op, numStack, opStack) do
    op0 = List.first(opStack)
    # will compute * /
    if op0 == "(" or op0 == "+" or op0 == "-" or op0 == nil do
      opStack = [op | opStack]
      listToResult(calc, numStack, opStack)
    else
      {_, opStack} = List.pop_at(opStack, 0)
      {x2, numStack} = List.pop_at(numStack, 0)
      {x1, numStack} = List.pop_at(numStack, 0)
      res = compute(x1, x2, op0)
      numStack = [res | numStack]
      opStack = [op | opStack]
      listToResult(calc, numStack, opStack)
    end
  end

  # compute until meet left parenthesis
  defp listToResultUntilLeftParen(calc, numStack, opStack) do
    {op, opStack} = List.pop_at(opStack, 0)

    case op do
      nil ->
        raise("invalid input")

      "(" ->
        listToResult(calc, numStack, opStack)

      _ ->
        {x2, numStack} = List.pop_at(numStack, 0)
        {x1, numStack} = List.pop_at(numStack, 0)
        res = compute(x1, x2, op)
        numStack = [res | numStack]
        listToResultUntilLeftParen(calc, numStack, opStack)
    end
  end

  # compute 1 time for 2 numbers and 1 operator
  # will raise a error if stack do not have such thing.
  defp compute(x1, x2, op) do
    if x1 == nil or x2 == nil or op == nil do
      raise("invalid input")
    end

    case op do
      "+" -> x1 + x2
      "-" -> x1 - x2
      "*" -> x1 * x2
      "/" -> x1 / x2
      _ -> raise("invalid input")
    end
  end

  # From string to number-operator List
  defp strToList(chars, result) do
    cond do
      # return condition
      List.first(chars) == "\n" ->
        result

      # operator
      List.first(chars) == "+" or List.first(chars) == "-" or List.first(chars) == "*" or
        List.first(chars) == "/" or List.first(chars) == "(" or List.first(chars) == ")" ->
        strToList(getTail(chars), result ++ [List.first(chars)])

      # space
      List.first(chars) == " " ->
        strToList(getTail(chars), result)

      # number, if not, will raise a error.
      true ->
        getNumber(chars, result)
    end
  end

  # Use Integer.parse to get the number
  defp getNumber(l, result) do
    tup = Integer.parse(Enum.join(l))
    chars = String.graphemes(elem(tup, 1))
    strToList(chars, result ++ [elem(tup, 0)])
  end

  # Get the tail of a List.
  defp getTail(l) do
    [_ | tail] = l
    tail
  end
end
