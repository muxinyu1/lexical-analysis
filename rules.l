%option C++ noyywrap

%{
  #include <stdio.h>
	#include <string.h>
  #include <fstream>
  int row_cnt = 1;
	int word_cnt = 0;
	int col_cnt = 0;
	char res_c_str[1024];
	char* build_output(const char* word, const char* type);
%}

O   [0-7]
D   [0-9]
NZ  [1-9]
H   [a-fA-F0-9]
HP  (0[xX])
E   ([Ee][+-]?{D}+)
P   ([Pp][+-]?{D}+)
FS  (f|F|l|L)
IS  (((u|U)(l|L|ll|LL)?)|((l|L|ll|LL)(u|U)?))
CP  (u|U|L)
SP  (u8|u|U|L)
ES  (\\(['"\?\\abfnrtv]|[0-7]{1,3}|x[a-fA-F0-9]+))
WS  [ \t\v\n\f]
blank [ \t]+
newline \n
keyword (auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|inline|int|long|register|restrict|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while)
identifier [a-zA-Z_][a-zA-z0-9_]*

%%
"/*" { 
      int c;
      while((c = yyinput()) != 0) {
        if(c == '\n')
          ++row_cnt;

        else if(c == '*')
          {
          if((c = yyinput()) == '/')
            break;
          else
            unput(c);
          }
      } 
}
      
"//".*  { }

{keyword} {
  const char* word = YYText();
	char type[64];
	sprintf(type, "\'%s\'", word);
	printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
	word_cnt++;
}

{identifier} {
  const char* word = YYText();
  const char* type = "Identifier";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++;
}

{HP}{H}+{IS}?				{ const char* word = YYText();
  const char* type = "IntegerConstant";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }
{NZ}{D}*{IS}?				{ const char* word = YYText();
  const char* type = "IntegerConstant";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }
"0"{O}*{IS}?				{ const char* word = YYText();
  const char* type = "IntegerConstant";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }
{CP}?"'"([^'\\\n]|{ES})+"'"		{ const char* word = YYText();
  const char* type = "IntegerConstant";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }

{D}+{E}{FS}?				{ const char* word = YYText();
  const char* type = "FloatConstant";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }
{D}*"."{D}+{E}?{FS}?			{ const char* word = YYText();
  const char* type = "FloatConstant";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }
{D}+"."{E}?{FS}?			{ const char* word = YYText();
  const char* type = "FloatConstant";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }
{HP}{H}+{P}{FS}?			{ const char* word = YYText();
  const char* type = "FloatConstant";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }
{HP}{H}*"."{H}+{P}{FS}?			{ const char* word = YYText();
  const char* type = "FloatConstant";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }
{HP}{H}+"."{P}{FS}?			{ const char* word = YYText();
  const char* type = "FloatConstant";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }

({SP}?\"([^"\\\n]|{ES})*\"{WS}*)+	{ const char* word = YYText();
  const char* type = "StringLiteral";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);
  word_cnt++; }

"..."					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word);} 
">>="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"<<="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"+="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"-="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"*="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"/="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"%="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"&="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"^="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"|="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
">>"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"<<"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"++"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"--"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"->"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"&&"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"||"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"<="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
">="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"=="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"!="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
";"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
("{"|"<%")				{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
("}"|"%>")				{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
","					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
":"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"="					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"("					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
")"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
("["|"<:")				{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
("]"|":>")				{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"."					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"&"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"!"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"~"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"-"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"+"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"*"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"/"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"%"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"<"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
">"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"^"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"|"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }
"?"					{ const char* word = YYText();
  char type[64];
  sprintf(type, "\'%s\'", word);
  printf("%s\n", build_output(word, type));
  ++word_cnt;
  col_cnt += strlen(word); }


{blank} {col_cnt += strlen(YYText());}

{newline} {++row_cnt; col_cnt = 0;}

. {const char* word = YYText();
  const char* type = "Unknown";
  printf("%s\n", build_output(word, type));
  col_cnt += strlen(word);}
%%

char* build_output(const char* word, const char* type) {
		int start_col = col_cnt;
		int end_col = start_col + strlen(word) - 1;
		int start_row = row_cnt;
		sprintf(res_c_str, "[@%d,%d:%d=\'%s\',<%s>,%d:%d]", word_cnt, start_col, end_col, word, type, start_row, start_col);
		return res_c_str;
}

int main(int argc, char* argv[]) {
  if (argc < 2) {
    perror("Lack of filename.\n");
    return 1;
  }
  try {
	std::fstream in(argv[1], std::ios::in);
	freopen("res.tokens", "w", stdout);
  FlexLexer* lexer = new yyFlexLexer(&in);
	while(lexer->yylex() != 0);
	in.close();
  } catch (std::exception& e) {
    printf("%s\n", e.what());
    return -1;
  }
	return 0;
}
