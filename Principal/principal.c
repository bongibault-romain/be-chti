

#include "DriverJeuLaser.h"
#include "ServiceJeuLaser.h"
#include "principal.h"
#include "./../GestionSon.h"
#include "./../DFT/DFT.h"

extern int PeriodeSonMicroSec;

extern short LeSignal[64];

static float dfts[64];
static int sdfts[64];

int main(void)
{
// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

/* Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers */
CLOCK_Configure();

ServJeuLASER_Son_Init(PeriodeSonMicroSec ,0,GestionSon_Callback);

	
/* Configuration du son (voir ServiceJeuLaser.h) 
 Ins�rez votre code d'initialisation des parties mat�rielles g�rant le son ....*/	
	

//============================================================================	
	for(int k=0;k<64;k++){
		sdfts[k] = DFT(k, LeSignal);
		dfts[k] = convert(sdfts[k]);
	}

while	(1)
	{
	}
}




