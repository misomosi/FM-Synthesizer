/* ========================================
 *
 * Copyright Michael Collins, 2017
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF your company.
 *
 * ========================================
*/
#include <project.h>

#define DEVICE                  (0u)
#define MIDI_MSG_SIZE           (4u)

int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */

    /* Start the USBFS interface */
    USB_Start(DEVICE, USB_DWR_VDDD_OPERATION);

    for(;;)
    {
        /* Place your application code here. */
        /* Host can send double SET_INTERFACE request */
        if(0u != USB_IsConfigurationChanged())
        {
            /* Initialize IN endpoints when device configured */
            if(0u != USB_GetConfiguration())   
            {   
            	/* Enable output endpoint */
                USB_MIDI_Init();
            }
            else
            {
                //SleepTimer_Stop();
            }    
        }
    }
}

/* [] END OF FILE */
