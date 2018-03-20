<explanation>
This example is very simple example for understanding g++.

g++: compiler for cpp-based source files. 
gcc: compiler for c-based source files
gcc = GNU compiler collection

details can be checked in 
https://en.wikipedia.org/wiki/GNU_Compiler_Collection

<instruction1>
#: explanation of instruction 
-: commands you should input
-cd ~   #move to your home folders
-mkdir workspace  #create folder named workspace
-cd workspace  #move to workspace folder(you created)
-mkdir cpp_example
-cd cpp_example
-gedit main.cpp   #create main.cpp file and open text editor
-(write below codes into main.cpp, and then save, and then close the window)

===
include <stdio.h>

int main(int argc, char** argv){
	printf "abcd";
	return 0;
}
===
-ls     #it will show the files in your directiory. In this example, there is only one file named main.cpp
-g++ main.cpp   #compile!
-ls   #it will show the files in your directory. you can see the a.out(green-colored) files are created.
-./a.out     #run the program.

-(Finally, you can see "abcd" is printed)


<instruction2>: How to change the name of executable file?(Can we output a file named "run" instead of "a.out"?)
#let's see the options of g++
-g++ --help    #too many options will be appeared. don't panic. 
-(find and read description about the option '-o')
-(it says, you can place the output into <file>. In other words, you can set the name of output to be <file>)
-(Finally, type this command again)
-g++ -o run main.cpp  #compile with options you give
-./run   #execute 


<Conclusion>
In summary, 
1. g++ is a compiler for c++ based source files. (ROS is compatible with c++&python)
2. you can compile source files by using the command 'g++'
3. g++ supports lots of options. (ex. output name, include directory, library settings, ...)
4. In this case, we just set the option related to output name. 
5. For a simple program, using just this command is enough!  ... However, what if there are too many options required for the program? for example, if you want to use opencv library with g++ command and set the name of ouput to be "run_opencv", then you should type "g++ -o run_opencv -l opencv main.cpp"
If there are more source files like main2.cpp camera.cpp ridarsensor.cpp ...
then you should type "g++ -o run_opencv -l opencv libusb main.cpp main2.cp camera.cpp ridarsensor.cpp ...."
What should we do?

see the example of main_pthread.cpp
type g++ main_pthread.cpp
it will not work.
type g++ -pthread main_pthread.cpp
then it will work because pthread-related options are included in g++...

6. we will study Makefile for the reason described above.


