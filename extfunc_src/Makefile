# capstone library name (without prefix 'lib' and suffix '.so')
LIBNAME = extfunc

CC=clang
CXX=clang++

CXX_FLAGS += -I$(realpath ./include)
LIB_FLAGS += -L$(realpath ./)

.PHONY: extfunc all
all: main.elf
main.elf: extfunc main.o
	$(CC) main.o $(LIB_FLAGS) -l$(LIBNAME) -o $@

extfunc: $(LIBNAME).o
	ar rcs lib$(LIBNAME).a $(LIBNAME).o

%.o: %.c
	${CC} -fPIC $(CXX_FLAGS) $(LIB_FLAGS) -c $< -o $@

clean:
	rm -f *.o *.a *.elf
