#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>


int main(int argc, char** argv){
pthread_t thrd;
int nr = 0;
void* data;
nr = pthread_join(thrd, &data);


	return 0;
}
