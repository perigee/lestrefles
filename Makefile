TARGET = eagraph #executive file name
CC = clang++ -g #-g
CFLAGS = -std=c++11 -stdlib=libc++

VPATH = src/ #space seperate the different dirs
#BIN_DIR = bin
OBJECTS = $(wildcard *.o)

#all : main.o gfile.o graphe.o ealgo.o matching.o analyseGraphe.o
all : main.o
	$(CC) -o $(TARGET) $(CFLAGS) $^  -O2

#create obj files
main.o: main.cpp
	$(CC) -c $(CFLAGS) $< -o $@

.PHONY: clean
clean: 
	rm  $(TARGET) $(OBJECTS)




