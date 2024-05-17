

#include "DriverJeuLaser.h"
#include "ServiceJeuLaser.h"
#include "principal.h"
#include "./../GestionSon.h"
#include "./../DFT/DFT.h"
#include "./../Affichage/Affichage_Valise.h"

#define SEUIL 0x00005FFF

extern int PeriodeSonMicroSec;

static short TheSignal[64];

static int currentTarget = 0;
static int dfts[64];
static int oldDfts[64];
int frequencies[6] = {17,18,19,20,23,24};

static unsigned int scores[6] = {0,0,0,0,0,0};

void Callback_Affichage() {
	int newTarget = dfts[1] % 4;	

	Prepare_Clear_LED(currentTarget);
	Prepare_Set_LED(newTarget);
	Choix_Capteur(newTarget + 1);
	currentTarget = newTarget;
	
	Prepare_Afficheur(1, scores[0]);
	Prepare_Afficheur(2, scores[1]);
	Prepare_Afficheur(3, scores[2]);
	Prepare_Afficheur(4, scores[3]);
	
	Mise_A_Jour_Afficheurs_LED();
}

int Test_Scoring(int frequencyIndex) {
	int freq = frequencies[frequencyIndex];
	
	if(dfts[freq] > SEUIL && oldDfts[freq] < SEUIL){
		GestionSon_Start();
		scores[frequencyIndex]++;
		
		Callback_Affichage();
	}
}

void Callback() {
	// On copie DFT dans la variable oldDFT
	memcpy(oldDfts, dfts, 64 * sizeof(int));
	
	ServJeuLASER_StartDMA();
	
	for(int k=0;k<64;k++){
		dfts[k] = DFT(k, TheSignal);
	}
	
	for (int i = 0; i < 6; i++) {
		Test_Scoring(i);
	}
}


int main(void)
{
	// ===========================================================================
	// ============= INIT PERIPH (faites qu'une seule fois)  =====================
	// ===========================================================================

	/* Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers */
	CLOCK_Configure();

	ServJeuLASER_Son_Init(PeriodeSonMicroSec ,0, GestionSon_Callback);
	ServJeuLASER_ADC_DMA(TheSignal);
	ServJeuLASER_Systick_IT_Init(5000, 9, Callback);
	
	Init_Affichage();
	
	Prepare_Set_LED(currentTarget);
	Choix_Capteur(currentTarget + 1);
	Mise_A_Jour_Afficheurs_LED();
	
/* Configuration du son (voir ServiceJeuLaser.h) 
 Insérez votre code d'initialisation des parties matérielles gérant le son ....*/	
	

//============================================================================	

while	(1)
	{
	}
}


