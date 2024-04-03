

#include "DriverJeuLaser.h"
#include "ServiceJeuLaser.h"
#include "principal.h"
#include "./../GestionSon.h"
#include "./../DFT/DFT.h"

extern int PeriodeSonMicroSec;

extern short LeSignal[64];

static float dfts[64];

int main(void)
{
// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

/* Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers */
CLOCK_Configure();

ServJeuLASER_Son_Init(PeriodeSonMicroSec ,0,GestionSon_Callback);

	
/* Configuration du son (voir ServiceJeuLaser.h) 
 Insérez votre code d'initialisation des parties matérielles gérant le son ....*/	
	

//============================================================================	
	for(int k=0;k<64;k++){
		dfts[k] = convert(DFT(k, LeSignal));
	}

while	(1)
	{
	}
}




