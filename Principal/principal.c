

#include "DriverJeuLaser.h"
#include "ServiceJeuLaser.h"
#include "principal.h"
#include "./../GestionSon.h"

extern int PeriodeSonMicroSec;

int main(void)
{
// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

/* Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers */
CLOCK_Configure();

ServJeuLASER_Systick_IT_Init(PeriodeSonMicroSec ,0,GestionSon_Callback);

/* Configuration du son (voir ServiceJeuLaser.h) 
 Ins�rez votre code d'initialisation des parties mat�rielles g�rant le son ....*/	
	

//============================================================================	
	


	
while	(1)
	{
	}
}




