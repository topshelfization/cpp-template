# info to locate/create the executable i.e prog.exe
BINARY_NAME = main.exe
BINARY_DIR = bin

# directories listed by spaces ( use . for current, same for above )
SOURCE = src
INCLUDE = include
LIB = lib

CXX = g++.exe
OFLAG = -O3
SUBSYS = console

# list of the names you would put after '-l' flags
# LINK = opengl32 freetype winmm gdi32

###########################################

SYSFLAG = -w -Wl,-subsystem,$(SUBSYS)
STATIC_CPP = -static
DFLAGS = -MP -MD
WFLAGS = -Wall -Wextra -g 

# generate lists of dirs to include, librarys and the linker flags
IDIRS = $(foreach DIR,$(INCLUDE),-I$(DIR))
LDIRS = $(foreach DIR,$(LIB),-L$(DIR))
LFLAGS = $(foreach NAME,$(LINK),-l$(NAME))

# generate lists of all the files we will work with and create
CFILES = $(foreach DIR, $(SOURCE),$(wildcard $(DIR)/*.cpp))
OFILES = $(patsubst %.cpp,%.o,$(CFILES))
DFILES = $(patsubst %.cpp,%.d,$(CFILES))

# generate flags for object files and the executable.
FLAGS = $(WFLAGS) $(DFLAGS) $(OFLAG) $(STATIC_CPP) $(IDIRS)
EXEFLAGS = $(FLAGS) $(SYSFLAG) $(LDIRS) $(LFLAGS)
OBJFLAGS = $(FLAGS)

MSG = $(foreach DIR, $(SOURCE),$(DIR)/*.o)

BINARY = $(BINARY_DIR)\$(BINARY_NAME)

all: $(BINARY)

$(BINARY): $(OFILES)
	@echo ******************************
	@echo $(MSG) -o $@
	@if not exist "$(BINARY_DIR)" mkdir $(BINARY_DIR)
	@$(CXX) -o $@ $^ $(EXEFLAGS)

%.o: %.cpp
	@echo $< -o $@
	@$(CXX) -c -o $@ $< $(OBJFLAGS)

clean:
	@del/q /s *.d && del/q /s *.o && del/q /s $(BINARY) 

-include $(DFILES)
