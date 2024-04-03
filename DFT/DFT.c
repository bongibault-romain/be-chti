#include "DFT.h"

float DFT(int k, float echantillon [M]) {
	float real = 0;
	float im = 0;
	
	for (int i = 0; i < M; i++){
		real = real + echantillon[i]* TabCos[k];
		im = im + echantillon[i] * TabSin[k];
	}
	
	return real*real + im*im;
}