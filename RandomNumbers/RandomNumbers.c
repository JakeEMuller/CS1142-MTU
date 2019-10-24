//**********************************************
// Jake Muller
// 10/24/19
// CS1142
//**********************************************

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

int main(int argc, char** argv){


  //Create Initial Conditions for Program
  if(argc != 5){
    printf("RandomNumbers, <bits> <seed> <tab bit> <numbers>\n");
    return 0;
  }
  int NumberOfBits = atoi(argv[1]);
  int Seed = atoi(argv[2]);
  int tapbit = atoi(argv[3]);
  int numberOfNumbers = atoi(argv[4]);
  if( (NumberOfBits < 0) | (NumberOfBits > 31) ){
    printf("Invalid input!\n");
    return 0;
  }
  int maxNum = pow(2, NumberOfBits);
  maxNum = maxNum - 1; 
  if( (Seed < 0) | (Seed > maxNum) ){
    printf("Invalid input!\n");
    return 0;
  }
  if( (tapbit < 0) | (tapbit >= NumberOfBits) ){
    printf("Invalid input!\n");
    return 0;
  }
  //Creating bit Buffer Based on Seed
  bool bitBuffer[NumberOfBits];

  //fill buffer with seed
  int divResult = Seed;
  int remained = 0;
  for(int i = NumberOfBits - 1; i >= 0; i--){
    remained = divResult % 2;
    divResult = divResult / 2;
    if(remained == 0){
      bitBuffer[i] = false;
    }else{
      bitBuffer[i] = true;
    }
    // printf("We Got Through %d\n", i);
  }
  //printout bits
  for(int i = 0; i < NumberOfBits; i++){
    printf("%d", bitBuffer[i]);
  }
 
  printf(" = %d\n", Seed);
  
  //Start shifting bits yo 
   for(int i = 1; i < numberOfNumbers; i++){
   
    //define varables every iteration
    bool tapValue = bitBuffer[NumberOfBits - tapbit -1]; //done because tapbit is backwords from array
    bool MSB = bitBuffer[0];
    bool A = MSB ^ tapValue;
   
    
   
    //shift the bits right
    for(int j = 0; j < NumberOfBits - 1; j++){
      bitBuffer[j] = bitBuffer[j + 1];
    }
    bitBuffer[NumberOfBits -1] = A; //least significant bit to A
    
   

    //calculate the value of random number
    int PowerOfTwo = 1; // start with 2^0
    int total = 0;
    for(int j = NumberOfBits - 1; j >= 0; j--){
      if(bitBuffer[j] == 1){
	total = total + PowerOfTwo;
      }
      PowerOfTwo = PowerOfTwo * 2;
    }
    //printout bits
    for(int j = 0; j < NumberOfBits; j++){
      printf("%d", bitBuffer[j]);
    }
    printf(" = %d\n", total);

   }
  
}
