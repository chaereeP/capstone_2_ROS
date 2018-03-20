CC = g++
OBJS = main_pthread.o 
TARGET = run_pthread
LIBFLAGS = -pthread
 
.SUFFIXES : .cpp .o
 
all : $(TARGET)
 
$(TARGET): $(OBJS)
	   $(CC) -o $@ $(LIBFLAGS) $(OBJS)

clean :	$
	rm -rf $(OBJS) $(TARGET)
