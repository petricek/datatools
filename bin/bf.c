#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
 
int b=16;
int verbose=0;
char *dfile="/dev/stdin";
char *bfile=NULL;
 
void usage(char *prog) {
  fprintf(stderr, "usage: cat data | %s [-b <2|4|8|...|32>] [-v] <blacklist>\n", prog);
  exit(-1);
}

unsigned hash_ber(char *in, size_t len) {
  unsigned hashv = 0;
  while (len--)  hashv = ((hashv) * 33) + *in++;
  return hashv;
}
unsigned hash_fnv(char *in, size_t len) {
  unsigned hashv = 2166136261UL;
  while(len--) hashv = (hashv * 16777619) ^ *in++;
  return hashv;
}
#define MASK(u,b) ( u & ((1UL << b) - 1))
#define NUM_HASHES 2
void get_hashv(char *in, size_t len, unsigned *out) {
  assert(NUM_HASHES==2);
  out[0] = MASK(hash_ber(in,len),b);
  out[1] = MASK(hash_fnv(in,len),b);
}

#define BIT_TEST(c,i) (c[i/8] & (1 << (i % 8)))
#define BIT_SET(c,i) (c[i/8] |= (1 << (i % 8)))
#define byte_len(n) (((1UL << b) / 8) + (((1UL << b) % 8) ? 1 : 0))
#define num_bits(n) (1UL << b)
char *bf_new(unsigned b) {
  char *bf = calloc(1,byte_len(n));
  return bf;
}
void bf_add(char *bf, char *line) {
  unsigned i, hashv[NUM_HASHES];
  get_hashv(line,strlen(line),hashv);
  for(i=0;i<NUM_HASHES;i++) BIT_SET(bf,hashv[i]);
}
void bf_info(char *bf, FILE *f) {
  unsigned i, on=0;
  for(i=0; i<num_bits(n); i++) 
    if (BIT_TEST(bf,i)) on++;

  fprintf(f, "%.2f%% saturation (%lu bits)\n", on*100.0/num_bits(n), num_bits(n));
}
int bf_hit(char *bf, char *line) {
  unsigned i, hashv[NUM_HASHES];
  get_hashv(line,strlen(line),hashv);
  for(i=0;i<NUM_HASHES;i++) {
    if (BIT_TEST(bf,hashv[i])==0) return 0;
  }
  return 1;
}
 
int main(int argc, char * argv[]) {
  int opt;
  FILE *dfilef=stdin;
  FILE *bfilef=NULL;
  char line[100];
 
  while ( (opt = getopt(argc, argv, "b:v+")) != -1) {
    switch (opt) {
      case 'b':
        b = atoi(optarg);
        break;
      case 'v':
        verbose++;
        break;
      default:
        usage(argv[0]);
        break;
    }
  }
 
  if (optind < argc) bfile=argv[optind++];
  if (!bfile || !dfile) usage(argv[0]);

  /* open files */
  if ( (bfilef = fopen(bfile,"r")) == NULL) {
    fprintf(stderr,"can't open %s: %s\n", bfile, strerror(errno));
    exit(-1);
  }
  if ( (dfilef = fopen(dfile,"r")) == NULL) {
    fprintf(stderr,"can't open %s: %s\n", dfile, strerror(errno));
    exit(-1);
  }

  /* make the bloom filter */
  char *bf= bf_new(b);
 
  /* loop over the source file */
  while (fgets(line,sizeof(line),bfilef) != NULL) bf_add(bf,line);

  /* print saturation etc */
  if (verbose) bf_info(bf,stderr); 

  /* now loop over the test file */
  while (fgets(line,sizeof(line),dfilef) != NULL) {
    if (!bf_hit(bf,line)) {
      printf("%s", line);
    }
  }
}
