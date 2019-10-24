//*************************************
//  Jake Muller
//  CS1142 
//  10/24/19
//**************************************
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv){

  if(argc <= 4){
    printf("<number> <probability> <seed> <word1> [word2] ... \n");
    return 0;
  }
  int SentenceNum = atoi(argv[1]);
  float probability = atof(argv[2]);
  int seed = atoi(argv[3]);
  float rund = (float)rand()/RAND_MAX; // [0,1]
  // printf("This is Rund: %f \n", rund);
  int wordsPerSent[SentenceNum];
  srand(seed);
  //srand(time(Null));
  for(int i = 0; i < SentenceNum; i++){
    int numOfWords = 0;
    do{
      printf(" ");
      int wordnum = rand() % (argc - 4);
      wordnum = wordnum + 4;
      printf(argv[wordnum]);
      numOfWords++;
      rund = (float)rand()/RAND_MAX;
    }while(rund <= probability);
    printf(". \n");
    wordsPerSent[i] = numOfWords;
    }

  printf("Total Sentences = %d \n", SentenceNum);
  
  //calculate average words
  double total = 0;
  for(int i = 0; i < SentenceNum; i++){
    total = total + wordsPerSent[i];
  }
  total = (double)total / (double)SentenceNum;

  printf("Average words per sentence = %.2f \n", total);
  return 0;

}
