%option C++ noyywrap

%{
  #include <iostream>
	#include <cstring>
  int row_cnt = 1;
	int word_cnt = 0;
	int col_cnt = 0;
	char res_c_str[1024];
	char* build_output(const char* word, const char* type) {
		int start_col = col_cnt;
		int end_col = start_col + strlen(word) - 1;
		int start_row = row_cnt;
		sprintf(res_c_str, "[@%d,%d:%d=\'%s\',<%s>,%d:%d]", word_cnt, start_col, end_col, word, type, start_row, start_col);
		return res_c_str;
	}
%}

keyword "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"inline"|"int"|"long"|"register"|"restrict"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"

blank [ \t]+

digit [0-9]

nondigit [_a-zA-Z]

identifier 

%%
"/*" {
		int c;
		while((c = yyinput()) != 0)
			{
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

{blank} {col_cnt += strlen(YYText());}

{keyword} {
						auto word = YYText(); 
						char type[64];
						sprintf(type, "\'%s\'", word);
						printf("%s\n", build_output(word, type));
						col_cnt += strlen(word);
						word_cnt++;
					}

\n {++row_cnt; col_cnt = 0;}
%%

int main() {
	FlexLexer* lexer = new yyFlexLexer;
	while(lexer->yylex() != 0)
		;
	return 0;
	}
