%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
	/*
	@author Ross Kuiper
	@date 3/15/2020 
	This bison file takes the tokens in the stream
	and checks to see if they form sentences in this 
	language. It gives INT and FLOAT their proper types
	and handles any invalid number inputs. If a syntax
	error occurs where the program is looking for a 
	different token than what is given, the program
	will report the error and then close.
	*/
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

statementList:		statement 
	|		statement statementList 
;

statement:			line END_STATEMENT
	|			point END_STATEMENT
	|			circle END_STATEMENT
	|			rectangle END_STATEMENT
	|			setColor END_STATEMENT
;

line:				LINE INT INT INT INT
				{
					line($2, $3, $4, $5);
				}
;

point:				POINT INT INT
				{ 
					point($2, $3);
				}
;

circle:				CIRCLE INT INT INT
				{
					if($4 > 0){
						circle($2, $3, $4);
					} else {
						printf("Sorry that is an invalid circle radius\n");
					}
				}
;

rectangle:			RECTANGLE INT INT INT INT
				{
					if($4 > 0 && $5 > 0){
						rectangle($2, $3, $4, $5);
					} else {
						printf("Invalid width or height of rectangle\n");
					}
				}
;

setColor:			SET_COLOR INT INT INT
				{
					if($2 < 256 && $3 < 256 && $4 < 256){
	 					set_color($2, $3, $4);
					} else {
						printf("Sorry those are invalid RGB numbers\n");
					}
				}
;

%%

int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
	return 0;
}

void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
	printf("Sorry, due to the error this program will close.\n");
	finish();
}

