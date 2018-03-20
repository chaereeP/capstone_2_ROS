<explanation>
we will study Makefile.
Actually, you don't have to fully understand how Makefile is constructed because you will use 'cmake' for ROS related programs. 
However, understanding Makefile will help you solve most of problems you will face in developing programs. 

reference: http://developinghappiness.com/?p=28

<instruction>
#copy the sources file main.cpp & main_pthread.cpp from 'cpp_example' folder
#create makefile_example folder and goes to the folder
-cd ~
-cd workspace
-mkdir makefile_example
-cd makefile_example
-cp ../cpp_example/main* ./   # this command will copy the files
-gedit Makefile   #create and open Makefile and then, type the commands below to Makefile

===
CC = g++
OBJS = main.o 
TARGET = main
 
.SUFFIXES : .cpp .o
 
all : $(TARGET)
 
$(TARGET): $(OBJS)
	   $(CC) -o $@ $(OBJS)

clean :	$
	rm -rf $(OBJS) $(TARGET)
===
***Using a 'tab' is important in writing Makefile... just copy above lines and paste them. save and terminate a text editor

-ls 
-make
-ls
-./main
-ls
-make clean
-ls
#when you type 'ls', see the result and find differences.

Now, we will write Makefile for main_pthread.cpp

===
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
===



