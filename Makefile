SHELL := cmd
CC = g++

EXEC = Modular3D
BIN = ./bin
SRCS_DIR = ./srcs
OBJS_DIR = ./srcs/objs

# flags for linking and compiling
LIBS = -lglew32 -lglfw3dll -lopengl32 -lglu32 -lgdi32 -lmingw32
LDFLAGS = -L./libs
CPPFLAGS = -I$(SRCS_DIR) -I./includes -g

# getting object and dependencies files
SRCS = $(wildcard $(SRCS_DIR)/*.cpp)
OBJS = $(patsubst $(SRCS_DIR)%.cpp,$(OBJS_DIR)%.o,$(SRCS))
DEPS = $(patsubst %.o,%.d,$(OBJS))

# default target 
# (build project but dont run)
.PHONY: all
all: $(BIN)/$(EXEC)
	@echo $(EXEC) was built successfully

# linking program from object files
$(BIN)/$(EXEC): $(OBJS)
	@echo linking $(EXEC)
	@$(CC) $^ -o $@ $(LDFLAGS) $(LIBS)

# compiling updated source files
$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.cpp
# 	@mkdir -p $(OBJS_DIR)
	@if not exist "$(OBJS_DIR)" mkdir "$(OBJS_DIR)"
	@echo compiling $<
	@$(CC) -c -MMD $(CPPFLAGS) $< -o $@

# run program
.PHONY: run
run: all
	@echo running...
	@$(BIN)/$(EXEC)

# remove executable and object files
.PHONY: clean
clean:
# 	@rm -rf $(OBJS_DIR)
# 	@rm -f $(BIN)/$(EXEC)
	@if exist "$(OBJS_DIR)" rd /s /q "$(OBJS_DIR)"
	@if exist "$(BIN)/$(EXEC).exe" del /q "$(subst /,\,$(BIN)/$(EXEC).exe)"

# include dependencies
-include $(DEPS)