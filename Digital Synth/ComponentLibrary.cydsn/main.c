/* ========================================
 *
 * Copyright YOUR COMPANY, THE YEAR
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF your company.
 *
 * ========================================
*/
#include <project.h>
#include "stdio.h"

#define USBFS_DEVICE    (0u)

/* The buffer size is equal to the maximum packet size of the IN and OUT bulk
* endpoints.
*/
#define USBUART_BUFFER_SIZE (64u)
#define LINE_STR_LENGTH     (20u)

void get_switch_matrix(uint32_t *switch_bits)
{
    Software_Key_Matrix_Driver_1_Read(switch_bits);
}

int main(void)
{
    char buffer[USBUART_BUFFER_SIZE];
    
    CyGlobalIntEnable; /* Enable global interrupts. */

    /* Start USBFS operation with 5-V operation. */
    USBUART_Start(USBFS_DEVICE, USBUART_5V_OPERATION);

    for(;;)
    {
        /* Host can send double SET_INTERFACE request. */
        if (0u != USBUART_IsConfigurationChanged())
        {
            /* Initialize IN endpoints when device is configured. */
            if (0u != USBUART_GetConfiguration())
            {
                /* Enumeration is done, enable OUT endpoint to receive data 
                 * from host. */
                USBUART_CDC_Init();
            }
        }
        
        /* Service USB CDC when device is configured. */
        if (0u != USBUART_GetConfiguration())
        {            
            /* Wait until component is ready to send data to host. */
            while (0u == USBUART_CDCIsReady())
            {
            }
            
            // Read the switch state
            uint32_t switch_bits;
            get_switch_matrix(&switch_bits);
            
            // Print the bits out to the console
            for(int i = 0; i < 32; i++)
            {
                buffer[i] = (switch_bits & (1 << i))? '1' : '0';   
            }
            
            sprintf(&buffer[32], "__%x\r", Status_Reg_1_Read());
            USBUART_PutString(buffer);
        }
        CyDelay(10);
    }
}

/* [] END OF FILE */
