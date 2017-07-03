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

#if !defined(KEY_MATRIX_`$INSTANCE_NAME`_H)
    #define KEY_MATRIX_`$INSTANCE_NAME`_H

    #include "cytypes.h"
    #include "cyfitter.h"
    #include "CyLib.h" /* For CyEnterCriticalSection() and CyExitCriticalSection() functions */
    
    #include "`$INSTANCE_NAME`_Row_Status.h"
    #include "`$INSTANCE_NAME`_Column_Control.h"
    
    #define `$INSTANCE_NAME`_ROWS   `$Rows`u
    #define `$INSTANCE_NAME`_COLS   `$Columns`u
    #define `$INSTANCE_NAME`_N      (`$INSTANCE_NAME`_ROWS * `$INSTANCE_NAME`_COLS)
    
    void `$INSTANCE_NAME`_Read(uint32_t *val_ptr) `=ReentrantKeil($INSTANCE_NAME . "_Read")`;
    
    /**************************************
    *  Registers
    *************************************/
    #define `$INSTANCE_NAME`_ROW_STATUS_PTR     ( `$INSTANCE_NAME`_Row_Status_Status_PTR )
    #define `$INSTANCE_NAME`_ROW_STATUS         ( `$INSTANCE_NAME`_Row_Status_Status )
    #define `$INSTANCE_NAME`_COL_CONTROL_PTR    ( `$INSTANCE_NAME`_Column_Control_Control_PTR )
    #define `$INSTANCE_NAME`_COL_CONTROL        ( `$INSTANCE_NAME`_Column_Control_Control )
    
    
#endif
/* [] END OF FILE */
