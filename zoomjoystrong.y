%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose
%start statementList

%union { int i; float f; }

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT

%%

statementList:		statementList statement END
	|				statement END
;

statement:			line END_STATEMENT
	|				point END_STATEMENT
	|				circle END_STATEMENT
	|				rectangle END_STATEMENT
	|				setColor END_STATEMENT
;

line:				LINE INT INT INT INT
					{ line($2, $3, $4, $5); }
;

point:				POINT INT INT
					{ point($2, $3); }
;

circle:				CIRCLE INT INT INT
					{ circle($2, $3, $4); }
;

rectangle:			RECTANGLE INT INT INT INT
					{ rectangle($2, $3, $4, $5); }
;

setColor:			SET_COLOR INT INT INT
					{ set_color($2, $3, $4); }
;
%%

int main(int argc, char** argv){
	yyparse();
	return 0;
}

void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}

