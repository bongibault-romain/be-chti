

#include "DriverJeuLaser.h"
#include "ServiceJeuLaser.h"
#include "principal.h"

extern void GestionSon_callback(void);

int main(void)
{
// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

/* Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers */
CLOCK_Configure();

ServJeuLASER_Systick_IT_Init(1000,0,GestionSon_callback);

/* Configuration du son (voir ServiceJeuLaser.h) 
 Ins�rez votre code d'initialisation des parties mat�rielles g�rant le son ....*/	


	
	

//============================================================================	
	


	
while	(1)
	{
	}
}




