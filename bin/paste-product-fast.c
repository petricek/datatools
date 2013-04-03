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

        char * usage = "%s file1 file2 [sep]\n";

        fA = fopen(argv[1], "r");
        fB = fopen(argv[2], "r");

        char * sep = argv[3];
        if(sep == NULL)
                sep = "";

        if (fA == NULL) 
        {
           printf(usage, argv[0]);
           exit(EXIT_FAILURE);
        }

        while ((read = getline(&u, &len, fA)) != -1) 
        {
                u[strlen(u)-1] = 0; // chop
                rewind(fB);
                if (fB == NULL) 
                {
                   printf(usage, argv[0]);
                   exit(EXIT_FAILURE);
                }
                while ((read = getline(&i, &len, fB)) != -1) 
                {
                        if(sep != NULL)
                        {
                                printf("%s%s%s", u, sep, i);
                        }
                        else
                        {
                                printf("%s%s", u, i);
                        }
                }
        }
        fclose(fB);
        fclose(fA);


        exit(EXIT_SUCCESS);
}

