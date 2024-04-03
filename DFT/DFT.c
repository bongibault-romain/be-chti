#include "DFT.h"

int multiply(short a, short b) {
	int atemp = a;
	int result = (atemp << 3)* b;
	
	return result;
}

float convert(int a) {
	return (float) a / (1 << 27);
}

short DFT(int k, short echantillon [M]) {
	int real = 0;
	int im = 0;
	
	for (int i = 0; i < M; i++){
		real = real + multiply(echantillon[i], TabCos[(k*i) % 64]);
		im = im + multiply(echantillon[i], TabSin[(k*i) % 64]);
	}
	
	return real * real + im * im;
}