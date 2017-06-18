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

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using CyDesigner.Extensions.Common;
using CyDesigner.Extensions.Gde;

// The namespace is required to have the same name as the component for a customizer.
namespace Sawtooth_Generator_v1_0
{
    public class CyCustomizer : ICyShapeCustomize_v1
    {
        #region ICyParamEditHook_v1 Members

        public CyCustErr CustomizeShapes(
            ICyInstQuery_v1 instQuery,
            ICySymbolShapeEdit_v1 shapeEdit,
            ICyTerminalEdit_v1 termEdit)
        {
            CyCompDevParam width_param = instQuery.GetCommittedParam("Width");
            int terminal_width;
            CyCustErr err = width_param.TryGetValueAs<int>(out terminal_width);
            if(err.IsNotOk) return err;
            
            // Shape the width of the data buses
            string suffix = (terminal_width > 1) ? string.Format("[{0}:0]", terminal_width - 1) : string.Empty;
            
            string term_name = termEdit.GetTermName("slope");
            termEdit.TerminalRename(term_name, term_name + suffix);
            
            term_name = termEdit.GetTermName("value");
            termEdit.TerminalRename(term_name, term_name + suffix);
            
            return CyCustErr.OK;
        }

        #endregion
    }
}

//[] END OF FILE
