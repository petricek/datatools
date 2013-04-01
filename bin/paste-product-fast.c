#include <stdio.h>
#include <stdlib.h>
#include <string.h>


FILE * fA;
FILE * fB;
char * u = NULL;
char * i = NULL;
size_t len = 0;
ssize_t read;

int main(int argc, char *argv[])
{

        fA = fopen(argv[1], "r");

        if (fA == NULL) 
           exit(EXIT_FAILURE);

        while ((read = getline(&u, &len, fA)) != -1) 
        {
                u[strlen(u)-1] = 0; // chop
                fB = fopen(argv[2], "r");
                if (fB == NULL) 
                   exit(EXIT_FAILURE);
                while ((read = getline(&i, &len, fB)) != -1) 
                {
                        printf("%s%s", u, i);
                }
        }


        exit(EXIT_SUCCESS);
}

