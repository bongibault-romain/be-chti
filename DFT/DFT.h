#ifndef DFT_H
#define DFT_H

#define M 64

extern float TabSin[64];
extern float TabCos[64];

float DFT(int k, float echantillon [M]);

#endif