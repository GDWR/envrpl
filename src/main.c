#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <argp.h>

const char *argp_program_version = VERSION;
const char *argp_program_bug_address = "gregory.dwr@gmail.com";
static char doc[] = "Expand content with environment variables.";
static struct argp argp = { 0, 0, 0, doc };


char* read_until(FILE* stream, char end) {
  char*  str     = 0;
  size_t str_len = 0;

  int c;
  while ((c = fgetc(stream)) != EOF && !isspace(c)) {
    str = realloc(str, str_len++);
    str[str_len-1] = c;
  }

  fseek(stdin, -1, SEEK_CUR);
  return str;
}

int main(int argc, char *argv[], char *envp[]) {
  argp_parse(&argp, argc, argv, 0, 0, 0);

  int c;
  while ((c = fgetc(stdin)) != EOF) {
    if (c == '$') {
      char* name = read_until(stdin, ' ');
	  char* var_value = getenv(name);

	  if (var_value != NULL) {
	    fputs(var_value, stdout);
	  } else {
		fputc('$', stdout);
		fputs(name, stdout);
	  }
    } else {
      putchar(c);
    }
  }

  return 0;
}

