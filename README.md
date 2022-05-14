# CUCU-Compiler

Firstly, to compile the Program run the following command,

bison -d cucu.y
flex cucu.l
gcc cucu.tab.c lex.yy.c -lfl -o cucu
./cucu Sample1.cu

My compiler does the basic works like Function Declaration , Function Definition, Variable Declaration.

It check if and while statements and the condition must have a relational Operator like (a>b) , (a!=b) etc.

I am assuming that there will only if or if with else and not else if.



we can assign and declare variables in int and char *.

I am assuming that the value of char * would be alphanumeric and _ only.

lexer.txt prints all the tokens present in the code.

parser.txt prints the parsed data and on receiving wrong syntax it prints the error message and stops.

Sample1.cu has correct code without error.
Sample2.cu has an incorrect code.
