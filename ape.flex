/* 2.1 */

/* excluding the returns */
SPACE_AND_FORMAT_EFFECTORS 	([ \t\f\013])
RETURN_FORMAT_EFFECTORS 	([\n\r])
WHITESPACE 			({SPACE_AND_FORMAT_EFFECTORS})
WHITESPACE_RETURNS 		({RETURN_FORMAT_EFFECTORS})
DIGIT 	 			([0-9])
LETTER 	 			([a-z])

/* 2.3 */

LETTER_OR_DIGIT 	 	({LETTER}|{DIGIT})
IDENTIFIER 	 		({LETTER}(_?{LETTER_OR_DIGIT})*)

/* 2.4.1 */

INTEGER 	 		({DIGIT}(_?{DIGIT})*)
EXPONENT 	 		(e[-+]?{INTEGER})
DECIMAL_LITERAL 	 	({INTEGER}([.]{INTEGER})?({EXPONENT})?)

/* 2.4.2 */

EXTENDED_DIGIT 	 		([0-9a-f])
BASED_INTEGER 	 		({EXTENDED_DIGIT}(_?{EXTENDED_DIGIT})*)
BASE 	 			({INTEGER})
BASED_LITERAL_POUND_1		({BASE}#{BASED_INTEGER}([.]{BASED_INTEGER})?#)
BASED_LITERAL_POUND 	 	({BASED_LITERAL_POUND_1}({EXPONENT})?)
BASED_LITERAL_COLON_1		({BASE}:{BASED_INTEGER}([.]{BASED_INTEGER})?:)
BASED_LITERAL_COLON 	 	({BASED_LITERAL_COLON_1}({EXPONENT})?)
BASED_LITERAL 	 		({BASED_LITERAL_POUND}|{BASED_LITERAL_COLON})

/* 2.4 */

NUMERIC_LITERAL 	 	({DECIMAL_LITERAL}|{BASED_LITERAL})

/* 2.5 */

CHARACTER_LITERAL 	 	(\'.\')

/* 2.6 */

NO_QUOTE 	 		([^"\n])
NO_QUOTE_OR_PERCENT 	 	([^"%\n])
DOUBLE_PERCENT 	 		([%][%])
DOUBLE_QUOTE 	 		(\"\")
STRING_LITERAL_1                (\"({NO_QUOTE}*({DOUBLE_QUOTE})*)*\")
STRING_LITERAL_2		(%({NO_QUOTE_OR_PERCENT}*({DOUBLE_PERCENT})*)*%)
STRING_LITERAL 	 		({STRING_LITERAL_1}|{STRING_LITERAL_2})

/* 2.7 */

COMMENT 	 		("--".*)
HELP_COMMENT 	 		("--?".*)



%{
void fix( int c)
{
  int i = 0;
  int leng = strlen(yytext);
  if (c)
     printf("\\AdaComment{");
  while (i != leng) {
     if (yytext[i] == '#')
        printf("\\#");
     else if (yytext[i] == '%')
        printf("\\%%");
     else if (yytext[i] == '&')
        printf("\\&");
     else if (yytext[i] == '{')
        printf("\\{");
     else if (yytext[i] == '}')
        printf("\\}");
     else if (yytext[i] == '$')
        printf("\\$");
     else if (yytext[i] == '^')
        printf("\\^");
     else
        printf("%c", yytext[i]);
     i++;
  };
  if (c)
     printf("}");

}
%}

%START WEBDOC  IDENT Z Z1  

/* 2.9 and 2.2 */

%%
"@file"		    	    {BEGIN(WEBDOC); ECHO;}
"@begin code".*			{BEGIN(Z); ECHO;}
"@end code".*			{BEGIN(WEBDOC); ECHO;}
"@begin docs".*			{BEGIN(WEBDOC); ECHO;}
"@use"					{ECHO;}
<WEBDOC>"@text".*       {BEGIN(WEBDOC); ECHO;}
<WEBDOC>"@nl".*		    {BEGIN(WEBDOC); ECHO;}
<WEBDOC>"@begin".*	    {BEGIN(WEBDOC); ECHO;}
<WEBDOC>"@end".*	    {BEGIN(WEBDOC); ECHO;}


abort           {BEGIN(Z); printf("\\AdaAbort ");}
abs             {BEGIN(Z); printf("\\AdaAbs ");}
accept          {BEGIN(Z); printf("\\AdaAccept ");}
access          {BEGIN(Z); printf("\\AdaAccess ");}
all             {BEGIN(IDENT); printf("\\AdaAll ");}
and             {BEGIN(Z); printf("\\AdaAnd ");}
array           {BEGIN(Z); printf("\\AdaArray ");}
at              {BEGIN(Z); printf("\\AdaAt ");}
begin           {BEGIN(Z); printf("\\AdaBegin ");}
body            {BEGIN(Z); printf("\\AdaBody ");}
case            {BEGIN(Z); printf("\\AdaCase ");}
constant        {BEGIN(Z); printf("\\AdaConstant ");}
declare         {BEGIN(Z); printf("\\AdaDeclare ");}
delay           {BEGIN(Z); printf("\\AdaDelay ");}
<Z,IDENT>delta           {BEGIN(Z); printf("\\AdaDelta ");}
<Z,IDENT>digits          {BEGIN(Z); printf("\\AdaDigits ");}
do              {BEGIN(Z); printf("\\AdaDo ");}
else            {BEGIN(Z); printf("\\AdaElse ");}
elsif           {BEGIN(Z); printf("\\AdaElsif ");}
end             {BEGIN(Z); printf("\\AdaEnd ");}
entry           {BEGIN(Z); printf("\\AdaEntry ");}
exception       {BEGIN(Z); printf("\\AdaException ");}
exit            {BEGIN(Z); printf("\\AdaExit ");}
for             {BEGIN(Z); printf("\\AdaFor ");}
function        {BEGIN(Z); printf("\\AdaFunction ");}
generic         {BEGIN(Z); printf("\\AdaGeneric ");}
goto            {BEGIN(Z); printf("\\AdaGoto ");}
if              {BEGIN(Z); printf("\\AdaIf ");}
in              {BEGIN(Z); printf("\\AdaIn ");}
is              {BEGIN(Z); printf("\\AdaIs ");}
limited         {BEGIN(Z); printf("\\AdaLimited ");}
loop            {BEGIN(Z); printf("\\AdaLoop ");}
mod             {BEGIN(Z); printf("\\AdaMod ");}
new             {BEGIN(Z); printf("\\AdaNew ");}
not             {BEGIN(Z); printf("\\AdaNot ");}
null            {BEGIN(Z); printf("\\AdaNull ");}
of              {BEGIN(Z); printf("\\AdaOf ");}
or              {BEGIN(Z); printf("\\AdaOr ");}
others          {BEGIN(Z); printf("\\AdaOthers ");}
out             {BEGIN(Z); printf("\\AdaOut ");}
package         {BEGIN(Z); printf("\\AdaPackage ");}
pragma          {BEGIN(Z); printf("\\AdaPragma ");}
private         {BEGIN(Z); printf("\\AdaPrivate ");}
procedure       {BEGIN(Z); printf("\\AdaProcedure ");}
raise           {BEGIN(Z); printf("\\AdaRaise ");}
<Z,IDENT>range  {BEGIN(Z); printf("\\AdaRange ");}
record          {BEGIN(Z); printf("\\AdaRecord ");}
rem             {BEGIN(Z); printf("\\AdaRem ");}
renames         {BEGIN(Z); printf("\\AdaRenames ");}
return          {BEGIN(Z); printf("\\AdaReturn ");}
reverse         {BEGIN(Z); printf("\\AdaReverse ");}
select          {BEGIN(Z); printf("\\AdaSelect ");}
separate        {BEGIN(Z); printf("\\AdaSeparate ");}
subtype         {BEGIN(Z); printf("\\AdaSubtype ");}
task            {BEGIN(Z); printf("\\AdaTask ");}
terminate       {BEGIN(Z); printf("\\AdaTerminate ");}
then            {BEGIN(Z); printf("\\AdaThen ");}
type            {BEGIN(Z); printf("\\AdaType ");}
use             {BEGIN(Z); printf("\\AdaUse ");}
when            {BEGIN(Z); printf("\\AdaWhen ");}
while           {BEGIN(Z); printf("\\AdaWhile ");}
with            {BEGIN(Z); printf("\\AdaWith ");}
xor             {BEGIN(Z); printf("\\AdaXor ");}

"=>"            {BEGIN(Z); ECHO; }
".."            {BEGIN(Z); printf(".."); }
"**"            {BEGIN(Z); ECHO; }
":="            {BEGIN(Z); ECHO; }
"/="            {BEGIN(Z); ECHO; }
">="            {BEGIN(Z); ECHO; } 
"<="            {BEGIN(Z); ECHO; }
"<<"            {BEGIN(Z); ECHO; }
">>"            {BEGIN(Z); ECHO; }
"<>"            {BEGIN(Z); ECHO; }
"&"             {BEGIN(Z); printf("\\& "); }
"("             {BEGIN(Z); ECHO; }
")"             {BEGIN(IDENT); ECHO; }
"*"             {BEGIN(Z); ECHO; }
"+"             {BEGIN(Z); ECHO; }
","             {BEGIN(Z); ECHO; }
"-"             {BEGIN(Z); ECHO; }
"."             {BEGIN(Z); ECHO; }
"/"             {BEGIN(Z); ECHO; }
":"             {BEGIN(Z); ECHO; }
";"             {BEGIN(Z); ECHO; }
"<"             {BEGIN(Z); ECHO; }
"="             {BEGIN(Z); ECHO; }
">"             {BEGIN(Z); ECHO; }

[|!]            {BEGIN(Z); ECHO; }

<IDENT>\'       {BEGIN(Z1); ECHO; }


{IDENTIFIER}       		{ ECHO; }

{NUMERIC_LITERAL}		{ fix(0); }

{STRING_LITERAL}		{ fix(0); }

<Z,Z1>{CHARACTER_LITERAL}	{ fix(0); }

{WHITESPACE_RETURNS}		{ ECHO; }

{WHITESPACE}			{ ECHO; }

{HELP_COMMENT}			{ fix(0); }


.				{ ECHO; }

%%


main()
{
  yylex();
  exit(0);
}





