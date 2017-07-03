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

#include "`$INSTANCE_NAME`_key_matrix.h"

void `$INSTANCE_NAME`_Read(uint32_t *val_ptr) `=ReentrantKeil($INSTANCE_NAME . "_Read")`
{
    uint8_t* val_arr = (uint8_t*) val_ptr;
    for(uint8_t row = 0; row < `$INSTANCE_NAME`_COLS; row++)
    {
        // Drive the current row pin low
        `$INSTANCE_NAME`_COL_CONTROL = ~(1 << row);
        CyDelayUs(10);
        val_arr[(`$INSTANCE_NAME`_COLS - 1) - row] = ~`$INSTANCE_NAME`_ROW_STATUS;
    }
}

/* [] END OF FILE */
