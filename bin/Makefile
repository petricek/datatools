
all: paste-product-fast bf

paste-product-fast: paste-product-fast.c
	gcc -O3 -march=nocona paste-product-fast.c -o paste-product-fast
     
bf: bf.c
	gcc -O3 -march=nocona bf.c -o bf
     
clean: 
	-rm bf paste-product-fast
