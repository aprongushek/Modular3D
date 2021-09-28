CC = g++

EXEC = Modular3D
BIN = ./bin
SRCS_DIR = ./srcs
OBJS_DIR = ./srcs/objs

# flags for linking and compiling
LIBS = -lglew32 -lglfw3dll -lopengl32 -lglu32 -lgdi32 -lmingw32
LDFLAGS = -L./libs
CPPFLAGS = -I$(SRCS_DIR) -I./includes

# get .o and .d files
SRCS := $(shell find $(SRCS_DIR) -name "*.cpp")
OBJS := $(SRCS:$(SRCS_DIR)/%.cpp=$(OBJS_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

.PHONY: all run clear

# default target 
# (build project but dont run)
all: $(BIN)/$(EXEC)
	@echo $(EXEC) was built successfully

# linking program from object files
$(BIN)/$(EXEC): $(OBJS)
	@echo linking $(EXEC)
	@$(CC) $^ -o $@ $(LDFLAGS) $(LIBS)

# compiling updated source files
$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.cpp
	@mkdir -p $(dir $@)
	@echo compiling $<
	@$(CC) -c -MMD $(CPPFLAGS) $< -o $@

# run program
run: all
	@echo running...
	@$(BIN)/$(EXEC)

# remove executable and object files
clear:
	@rm -rf $(OBJS_DIR)
	@rm -f $(BIN)/$(EXEC)

# include dependencies
-include $(DEPS)