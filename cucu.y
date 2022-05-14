%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex();
    int yyerror(char *text);
    FILE* lex_out,* yyout,* yyin;
%}

%token IFCND WHILECND CLOSEPAREN OPENPAREN CURLYOPEN CURLYCLOSE COMMA EQUAL SEMI RETURN ELSECND
%union{
    int num;
    char *str;
}
%token <str> NUMBTYPE VARNME CHARTYPE PLUS MINUS PROD DIVIDE STR RELEQUAL NOTEQUAL LESSTHN LESSEQL GRTRTHN GRTREQL
%token <num> INTNO

%left '+' '-'
%left '*' '/'
%left '(' ')'

%%

PROGRAM : PROG_BDY ;

PROG_BDY : FUNCS | VAR ;

FUNCS : NUMBTYPE VARNME OPENPAREN PARAMS CLOSEPAREN SEMI {
        fprintf(yyout,"Function : %s\n",$2);
    }FUNCS | 
    NUMBTYPE VARNME OPENPAREN PARAMS CLOSEPAREN {
        fprintf(yyout,"Function Body : \n");
    } CURLYOPEN BOMDY CURLYCLOSE BOMDY | 
    CHARTYPE VARNME OPENPAREN PARAMS CLOSEPAREN SEMI {
        fprintf(yyout,"Function : %s\n",$2);
    } | 
    CHARTYPE VARNME OPENPAREN PARAMS CLOSEPAREN CURLYOPEN BOMDY CURLYCLOSE {
        fprintf(yyout,"Function Body : \n");
    } ;

PARAMS : NUMBTYPE VARNME PARAMS {
    fprintf(yyout,"Function Parameter : \n");
    fprintf(yyout,"TYPE : %s\n", $1);
    fprintf(yyout,"ID : %s\n\n", $2);
} | 
    COMMA PARAMS | 
    CHARTYPE VARNME PARAMS {
        fprintf(yyout,"Function Parameter : \n");
        fprintf(yyout,"TYPE : %s\n", $1);
        fprintf(yyout,"ID : %s\n\n", $2);
    } |;

BOMDY : VAR BOMDY | 
    IFCND OPENPAREN CONDITION CLOSEPAREN BOMDY ELSE {
        fprintf(yyout,"IF Condition :\n\n");
    }BOMDY |
    IFCND OPENPAREN CONDITION CLOSEPAREN CURLYOPEN BOMDY CURLYCLOSE ELSE {
        fprintf(yyout,"IF Condition :\n\n");
    }BOMDY |
    WHILECND OPENPAREN CONDITION CLOSEPAREN BOMDY {
        fprintf(yyout,"While Condition :\n\n");
    } | 
    WHILECND OPENPAREN CONDITION CLOSEPAREN CURLYOPEN BOMDY CURLYCLOSE {
        fprintf(yyout,"While Condition :\n\n");
    }BOMDY |  
    RETURN INTNO SEMI {
        fprintf(yyout,"Return : %d\n\n",$2);
    } | 
    RETURN STR SEMI {
        fprintf(yyout,"Return : %s\n\n",$2);
    } |
    ;

ELSE : ELSECND {
    fprintf(yyout,"Else Condition : \n");
} BOMDY | 
    ELSECND {
        fprintf(yyout,"Else Condition : \n");
    } CURLYOPEN BOMDY CURLYCLOSE BOMDY | ;

CONDITION : INTNO RELATION INTNO {
    fprintf(yyout,"Constant : %d\n\n",$1);
    fprintf(yyout,"Constant : %d\n\n",$3);
} | 
    VARNME RELATION INTNO {
        fprintf(yyout,"Variable : %s\n\n",$1);
        fprintf(yyout,"Constant : %d\n\n",$3);
    } | 
    INTNO RELATION VARNME {
        fprintf(yyout,"Constant : %d\n\n",$1);
        fprintf(yyout,"Variable : %s\n\n",$3);
    } | 
    VARNME RELATION VARNME {
        fprintf(yyout,"Variable : %s\n\n",$1);
        fprintf(yyout,"Variable : %s\n\n",$3);
    }
    ;

RELATION : RELEQUAL {
        fprintf(yyout,"Relational : %s\n\n",$1);
    } | 
    LESSEQL {
        fprintf(yyout,"Relational : %s\n\n",$1);
    } | 
    LESSTHN {
        fprintf(yyout,"Relational : %s\n\n",$1);
    } | 
    NOTEQUAL {
        fprintf(yyout,"Relational : %s\n\n",$1);
    } | 
    GRTRTHN {
        fprintf(yyout,"Relational : %s\n\n",$1);
    } | 
    GRTREQL {
        fprintf(yyout,"Relational : %s\n\n",$1);
    } 
    ;

VAR : NUMBTYPE VARNME SEMI {
    fprintf(yyout,"Variable : \n");
    fprintf(yyout,"TYPE : %s\n", $1);
    fprintf(yyout,"ID : %s\n\n", $2);
} | 
NUMBTYPE VARNME EQUAL ARITH SEMI {
    fprintf(yyout,"Variable : \n");
    fprintf(yyout,"TYPE : %s\n", $1);
    fprintf(yyout,"ID : %s\n\n", $2);
} | 
CHARTYPE VARNME SEMI {
    fprintf(yyout,"Variable : \n");
    fprintf(yyout,"TYPE : %s\n", $1);
    fprintf(yyout,"ID : %s\n\n", $2);
} | 
CHARTYPE VARNME EQUAL STR SEMI {
    fprintf(yyout,"Variable : \n");
    fprintf(yyout,"TYPE : %s\n", $1);
    fprintf(yyout,"ID : %s\n", $2);
    fprintf(yyout,"Value : %s\n\n",$4);
} |
VARNME EQUAL ARITH SEMI {
    fprintf(yyout,"Variable : \n");
    fprintf(yyout,"ID : %s\n\n", $1);
} |
VARNME EQUAL STR SEMI {
    fprintf(yyout,"Variable : \n");
    fprintf(yyout,"ID : %s\n", $1);
    fprintf(yyout,"Value : %s\n\n",$3);
} |
VARNME EQUAL VARNME OPENPAREN VARI CLOSEPAREN SEMI {
    fprintf(yyout,"Variable Name : %s\n",$1);
    fprintf(yyout,"Function : %s\n\n",$3);
} |
CHARTYPE VARNME EQUAL VARNME OPENPAREN VARI CLOSEPAREN SEMI {
    fprintf(yyout,"Variable : \n");
    fprintf(yyout,"ID : %s\n", $1);
    fprintf(yyout,"Function : %s\n\n",$4);
} |
NUMBTYPE VARNME EQUAL VARNME OPENPAREN VARI CLOSEPAREN SEMI {
    fprintf(yyout,"Variable : \n");
    fprintf(yyout,"ID : %s\n", $1);
    fprintf(yyout,"Function : %s\n\n",$4);
}
;

VARI : INTNO COMMA VARI {
    fprintf(yyout,"Constant : %d\n",$1);
} |
    STR COMMA VARI {
        fprintf(yyout,"Variable : %s\n",$1);
    } |
    INTNO {
        fprintf(yyout,"Constant : %d\n",$1);
    } | 
    STR {
        fprintf(yyout,"Variable : %s\n",$1);
    } |
    VARNME COMMA VARI {
        fprintf(yyout,"Variable : \n");
        fprintf(yyout,"ID : %s\n", $1);
    } |
    VARNME {
        fprintf(yyout,"Variable : \n");
        fprintf(yyout,"ID : %s\n", $1);
    } |
    ;

ARITH : INTNO ARITH {
    fprintf(yyout,"Constant : %d\n\n",$1);
} | 
    OPR ARITH |
    OPENPAREN ARITH CLOSEPAREN |
    VARNME ARITH {
        fprintf(yyout,"Vavvriable : %s\n\n",$1);
    } |
    ;

OPR : PLUS {
    fprintf(yyout,"Operator : %s\n\n",$1);
} | 
    MINUS {
        fprintf(yyout,"Operator : %s\n\n",$1);
    } | 
    PROD {
        fprintf(yyout,"Operator : %s\n\n",$1);
    } | 
    DIVIDE {
        fprintf(yyout,"Operator : %s\n\n",$1);
    } ;

%%

int yyerror(char *text)
    {
        fprintf(yyout, "The given Code is Invalid\n");
    }

int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    lex_out = fopen("lexer.txt","w");
    yyout = fopen("parser.txt","w");
    yyparse();
    return 0;
}