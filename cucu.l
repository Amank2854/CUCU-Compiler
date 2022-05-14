%{
    #include<stdio.h>
    #include "cucu.tab.h"
    extern YYSTYPE yylval;
    FILE* lex_out;
%}

%%
"int" {
        fprintf(lex_out, "TYPE : %s\n",yytext);
        yylval.str=strdup(yytext);
        return NUMBTYPE;
    }
"char *" {
         fprintf(lex_out, "TYPE : char *\n");
         yylval.str=strdup(yytext);
         return CHARTYPE;
    }
"if" {
        fprintf(lex_out, "CONDITIONAL : if\n");
        return IFCND;
}
"else" {
        fprintf(lex_out, "CONDITIONAL : else\n");
        return ELSECND;
}
"while" {
        fprintf(lex_out, "LOOP : while\n");
        return WHILECND;
}
"return" {
        fprintf(lex_out, "RETURN : return\n");
        return RETURN;
}
\"[a-zA-Z0-9_]*\" {
        int i;
        fprintf(lex_out, "STR : ");
        for(i = 1 ; i<=yyleng-2;i++)
        {
                fprintf(lex_out, "%c",yytext[i]);
        }
        fprintf(lex_out, "\n");
        yylval.str=strdup(yytext);
        return STR;
}
[a-zA-Z_][a-zA-Z0-9_]* {
            fprintf(lex_out, "ID : %s\n",yytext);
            yylval.str=strdup(yytext);
            return VARNME;
        }    
[0-9]+ {
            fprintf(lex_out, "NUM : %s\n",yytext);
            yylval.num=atoi(yytext);
            return INTNO;
    }
"("   {
            fprintf(lex_out, "PARENTHESIS : (\n");
            return OPENPAREN;
    }       
")"   {
            fprintf(lex_out, "PARENTHESIS : )\n");
            return CLOSEPAREN;
    }             
"{"   {
            fprintf(lex_out, "PARENTHESIS : {\n");
            return CURLYOPEN;
    }                 
"}"   {
            fprintf(lex_out, "PARENTHESIS : }\n");
            return CURLYCLOSE;
    }              
"=="  {
            fprintf(lex_out, "RELATION : ==\n");
            yylval.str=strdup(yytext);
            return RELEQUAL;
    } 
"!="  {
            fprintf(lex_out, "RELATION : !=\n");
            yylval.str=strdup(yytext);
            return NOTEQUAL;
    }
"<"   {
            fprintf(lex_out, "RELATION : <\n");
            yylval.str=strdup(yytext);
            return LESSTHN;
    }                  
"<="  {
            fprintf(lex_out, "RELATION : <=\n");
            yylval.str=strdup(yytext);
            return LESSEQL;
    }                 
">"   {
            fprintf(lex_out, "RELATION : >\n");
            yylval.str=strdup(yytext);
            return GRTRTHN;
    } 
">="  {
            fprintf(lex_out, "RELATION : >=\n");
            yylval.str=strdup(yytext);
            return GRTREQL;
    }            
","   {
             fprintf(lex_out, "COMMA : ,\n");
             return COMMA;
    }                
"+"   {
            fprintf(lex_out, "PLUS : +\n");
            yylval.str=strdup(yytext);
            return PLUS;
    }                  
"-"   {
            fprintf(lex_out, "MINUS : -\n");
            yylval.str=strdup(yytext);
            return MINUS;
    }                
"*"   {
            fprintf(lex_out, "PRODUCT : *\n");
            yylval.str=strdup(yytext);
            return PROD;
    }                  
"/"   {
            fprintf(lex_out, "DIVIDE : /\n");
            yylval.str=strdup(yytext);
            return DIVIDE;
    }
"=" {
        fprintf(lex_out, "ASSIGN : =\n");
        return EQUAL;
    }
";" {
        fprintf(lex_out, "SEMI : ;\n");
        return SEMI;
}
\/\*[^*]*[*]+([^\/][^*]*[*]+)*\/ {}
\/\/(.*) {}
[ \t\n] {}
.     {}                  

%%

int yywrap()
{
    return 1;
}