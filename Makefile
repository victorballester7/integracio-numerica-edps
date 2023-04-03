# compiler to use and flags
CC := gcc
CC_FLAGS := -Wall -pedantic -std=c11 -ggdb

GNUPLOT = gnuplot
GNUPLOT_FLAGS = -pedantic

LIBS := -lm

# location of header files
INCLUDE := include
# location of binary files
BIN := bin
# location of .c files
SRC := src
# location of .gnu files
PLOT := plot
# Executable name
TARGET := main

# We create a list of all the sources by looking for all the .cpp and .c files
SOURCES := $(wildcard $(SRC)/*.c)

# We create a list of object files by replacing the .cpp or .c extension with .o in the list of sources
OBJECTS := $(patsubst $(SRC)/%.c, $(BIN)/%.o, $(filter %.c, $(SOURCES))) 

# We need to tell the compiler where to find the headers
HEADERS := $(wildcard $(INCLUDE)/*.h)

#  .PHONY target specifies that all and clean are not real files, but are just targets that don't produce output files.
.PHONY: all clean

all: $(BIN)/$(TARGET)

# We link all the object files together to create the executable
$(BIN)/$(TARGET): $(OBJECTS)
	$(CC) $(CC_FLAGS) $^ -o $@ $(LIBS)

# We compile the .c files
$(BIN)/%.o: $(SRC)/%.c
	$(CC) $(CC_FLAGS) -I$(INCLUDE) -c $< -o $@ $(LIBS)

# polexpl: $(SRC)/grRDF.c $(SRC)/polexpl.c
# 	@$(CC) $(CC_FLAGS) -I$(INCLUDE) $^ -o $(BIN)/$@ $(LIBRARIES)

# plot: 
# 	@$(GNUPLOT) $(GNUPLOT_FLAGS) $(PLOT)/placa.gnu

clean:
	rm -f $(BIN)/*.o $(BIN)/$(TARGET)