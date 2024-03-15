

#include "DriverJeuLaser.h"
#include "ServiceJeuLaser.h"
#include "principal.h"

extern void GestionSon_callback(void);

int main(void)
{
// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

/* Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers */
CLOCK_Configure();

ServJeuLASER_Systick_IT_Init(1000,0,GestionSon_callback);

/* Configuration du son (voir ServiceJeuLaser.h) 
 Insérez votre code d'initialisation des parties matérielles gérant le son ....*/	


	
	

//============================================================================	
	


	
while	(1)
	{
	}
}




