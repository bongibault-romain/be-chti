#include "DFT.h"

float convert(int a) {
	unsigned int b = (unsigned int) a;
	
	return ((float) b) / (1 << 22);
}

int DFT(int k, short echantillon[M]) {
	long long real = 0;
	long long im = 0;
	
	for (int i = 0; i < M; i++){
		int echan = (int) echantillon[i];
		
		real = real + echan * TabCos[(k*i) & 63]; // & 63 / equivalent mod 64
		im = im + echan * TabSin[(k*i) & 63];
	}
	
	return (real * real + im * im) >> 32;
}