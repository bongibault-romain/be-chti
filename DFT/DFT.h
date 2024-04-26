#ifndef DFT_H
#define DFT_H

#define M 64

extern short TabSin[64];
extern short TabCos[64];

float convert(int a);

int DFT(int k, short echantillon [M]);

#endif