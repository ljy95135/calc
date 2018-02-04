# calc
This is a elixir project for Web development course.  
This caculator only works for integer's + - * /(integer division) and (), so unary operator is not valid.  

I not only implement all feature professor required.  
Like 
>\> 2 + 3  
5  
\> 5 * 1  
5  
\> 20 / 4  
5  
\> 24 / 6 + (5 - 4)  
5  
\> 1 + 3 * 3 + 1  
11  

but also handle any valid space you want to put or not.  
so you can write something like:  
&nbsp;(&nbsp;&nbsp;&nbsp;(1+&nbsp;&nbsp;2)&nbsp;&nbsp;&nbsp;)*5  
and get the right answer.  
  
Of course, space between numbers is invalid, like 12 34 will be treated as 12 and 34, and raise the error.  
  
Besides common invalid input like 1++/2(, expression must get some number, so expression like:  
&nbsp;&nbsp;(just space or just hit Enter)  
()(()) (only parentheses without number) will also raise the exception.  
  
Handwriting way like 2(1+3) is invalid.  
  
It may be RuntimeError I raise or ArithmeticError I want (Let it crash), but the program not analyze the details of why this input is invalid.  
  
You may also see test/calc_test.exs to see the test cases which ensure any valid expression with arbitrary space can get right answer.  
  
Jiangyi Lin