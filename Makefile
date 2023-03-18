CC = gcc                       					   # compiler to use
CC_FLAGS = -Wall -pedantic -std=c99	-ggdb  # flags

LIBRARIES := -lm
EXECUTABLE := main 

# location of header files
INCLUDE := ./

# Rules are of the form:
# target: prerequisites
# 	 recipe


# default target to be executed is the first encountered. To change it, uncomment the following line and replace all with another target.
# .DEFAULT_GOAL := all
# all: $(BIN)/$(EXECUTABLE) 

# $^ evaluates to $(SRC)/rf_pendulum.c $(SRC)/pendulum.c $(SRC)/rk78.c
# S@ evaluates to rf_pendulum
# The option -I is will tell the compiler where to find the header file.

polexpl: grRDF.c polexpl.c
	@$(CC) $(CC_FLAGS) -I$(INCLUDE) $^ -o $@ $(LIBRARIES)
