/*
Autores:
Mariana Trevizani Nocelli  - 201535033
Seany Caroliny Oliveira Silva - 201665566C
*/
grammar lang;

@parser::header
{
	package lang.parser;
}

@lexer::header
{
	package lang.parser;
}

/*Regras da gramática */

prog:	(data)* (func)* ;
data:	DATA TYPENAME OPENKEY decl* CLOSEKEY ;
decl:	ID DOUBLECOLON type SEMI ;
func:	ID OPENPAREN (params)? CLOSEPAREN (COLON type (COMMA type)* )? OPENKEY (cmd)* CLOSEKEY ;
params:	ID DOUBLECOLON type (COMMA ID DOUBLECOLON type)* ;
type:	type OPENBRACKET CLOSEBRACKET
	|	btype
    ;
btype:	INTEIRO
	|	CHARACTER
	|	BOOLEAN
	|	FLUTUANTE
	|	ID
	|   TYPENAME
	;
cmd:	OPENKEY (cmd)* CLOSEKEY
	|	IF OPENPAREN exp CLOSEPAREN cmd
	|	IF OPENPAREN exp CLOSEPAREN cmd ELSE cmd
	|	ITERATE OPENPAREN exp CLOSEPAREN cmd
	|	READ lvalue SEMI
	|	PRINT exp SEMI
	|	RETURN exp (COMMA exp)* SEMI
	|	lvalue EQ exp SEMI
	|	ID OPENPAREN (exps)? CLOSEPAREN (RELACIONAL lvalue (COMMA lvalue)* BIGGER)? SEMI
	;
exp:	exp AND exp
	|	rexp
	;
rexp:	aexp RELACIONAL aexp
	|	rexp EQEQ aexp
	|	rexp DIFF aexp
	|	aexp
	;
aexp:	aexp PLUS mexp
	|	aexp MINUS mexp
	|	mexp
	;
mexp:	mexp TIMES sexp
	|	mexp DIV sexp
	|	mexp MOD sexp
	|	sexp
	;
sexp:	NOT sexp
	|	MINUS sexp
	|	TRUE
	|	FALSE
	|	NULL
	|	INT
	|	FLOAT
	|	CHAR
	|	pexp
	;
pexp:	lvalue
	|	OPENPAREN exp CLOSEPAREN
	|	NEW type (OPENBRACKET exp CLOSEBRACKET)?
	|	ID OPENPAREN (exps)? CLOSEPAREN OPENBRACKET exp CLOSEBRACKET ;

lvalue:	ID
	|	lvalue OPENBRACKET exp CLOSEBRACKET
	|	lvalue DOT ID
	;
exps:	exp (COMMA exp)* ;

 /* Regras léxicas */

/*Palavras reservadas */
IF:     'if' ;
ELSE:   'else' ; 
ITERATE:'iterate' ;
READ:   'read' ; 
PRINT:  'print' ; 
RETURN: 'return' ;
TRUE:   'true' ; 
FALSE:  'false' ; 
NULL:   'null' ; 
DATA:   'data' ; 
NEW:    'new' ;
INTEIRO:    'Int' ;
CHARACTER:   'Char' ; 
BOOLEAN:   'Bool' ;
FLUTUANTE:  'Float' ; 

FIMDELINHA: ('\r' | '\n' | '\r\n') -> skip;
BRANCOS: (' ' | '\t' | '\f' | FIMDELINHA ) -> skip;
INT: [0-9] [0-9]* ;
ID: [a-z] ([0-9] | [a-zA-Z] | '_')* ;
FLOAT: [0-9]+ '.' [0-9]* | [0-9]* '.' [0-9]+  ;
TYPENAME: [A-Z]([0-9] | [a-zA-Z])* ;
CHAR: '\''([a-z]|[A-Z]|[0-9])'\'' | '\''(~['"\\] | '\\' ( 'r' | 'n' | 't' | 'b' | '\'' | '"' | '\\' )) '\'' ;
COMENTARIOMULT1:  '{-' ;
COMENTARIOMULT2:  '-}' ;
COMENTARIOLINHA:  '--' ~('\r' | '\n')* FIMDELINHA -> skip;

/* Tokens */
EQ:     '=' ;
SEMI:   ';' ; 
TIMES:  '*' ;
PLUS:   '+' ; 
DIV:    '/' ; 
MINUS:  '-' ; 
MOD:   '%' ; 
EQEQ:   '==' ;  
DIFF:   '!=' ; 
AND:    '&&' ;
NOT:    '!' ;
RELACIONAL:   '<' ;
BIGGER: '>' ;
DOT:  '.' ; 
COMMA:  ',' ; 
OPENPAREN: '(' ; 
CLOSEPAREN:')' ; 
OPENKEY: '{' ;
CLOSEKEY:'}' ; 
OPENBRACKET: '[' ;
CLOSEBRACKET:']' ;   
DOUBLECOLON: '::' ; 
COLON:  ':' ; 

 
IGNORA: '_' -> skip;

COMENTARIO: ((COMENTARIOMULT1 .*?  COMENTARIOMULT2) | COMENTARIOLINHA) -> skip;