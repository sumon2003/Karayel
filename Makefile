CC = gcc
CFLAGS = -Wall -g

# Output Executable Name
TARGET = karayel

# Source Files
SRCS = lex.yy.c parser.tab.c keyword_table.c symbol_table.c main.c
OBJS = $(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): parser.tab.c lex.yy.c
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexer.l parser.tab.h
	flex lexer.l

clean:
	rm -f lex.yy.c parser.tab.c parser.tab.h $(TARGET) *.o

run: $(TARGET)
	./$(TARGET) examples/test.kl

.PHONY: all clean run