%{
	#include <stdio.h>
	#include "zoomjoystrong.tab.h"
	/*	
	@author Ross Kuiper
	@date 3/15/2020
	This lex file reads in from the stream and 
	determines if a sequence of characters
	matches a given token. It then returns the
	token to the parser, noting it's value if
	necessary. It also checks for negative numbers
	and anything which does not match a token.
	*/
%}

%option noyywrap

%%

\$end					{ return END; }
;					{ return END_STATEMENT; }
point					{ return POINT; }
line					{ return LINE; }
circle					{ return CIRCLE; }
rectangle				{ return RECTANGLE; }
set_color				{ return SET_COLOR; }
-[0-9]+					{ printf("Sorry no negative numbers\n"); }
-[0-9]+\.[0-9]+				{ printf("Sorry no negative numbers\n"); }
[0-9]+					{ yylval.i = atoi(yytext); return INT; }
[0-9]+\.[0-9]+				{ yylval.f = atof(yytext); return FLOAT; }
[ \t\r\n]				;
.					{
						printf("Sorry, invalid syntax. Please check for an");
					  	printf(" incorrect spelling of a command\n");
					}

%%
