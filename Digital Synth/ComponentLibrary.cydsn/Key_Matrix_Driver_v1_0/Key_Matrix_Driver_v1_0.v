
//`#start header` -- edit after this line, do not edit this line
// ========================================
//
// Copyright YOUR COMPANY, THE YEAR
// All Rights Reserved
// UNPUBLISHED, LICENSED SOFTWARE.
//
// CONFIDENTIAL AND PROPRIETARY INFORMATION
// WHICH IS THE PROPERTY OF your company.
//
// ========================================
`include "cypress.v"
//`#end` -- edit above this line, do not edit this line
// Generated on 06/10/2017 at 14:00
// Component: Key_Matrix_Driver_v1_0
module Key_Matrix_Driver_v1_0 (
	output  Changed,
	output [3:0] Column_Output,
	output reg [31:0] Switch_State,
	input   Clock,
	input  [7:0] Row_Input
);
	parameter Generate_Interrupt = 0;

//`#start body` -- edit after this line, do not edit this line
    generate
    if (Generate_Interrupt == 1)
    begin
        reg [1:0] cnt;  // Current column
        reg changed_reg;

        // De-sequence the count as the output. It only has 1 pin high at a time
        assign Column_Output = ~(4'b0001 << cnt); // Hopefully, this optimizes to a LUT instead of SHIFT8 bullshit

        // Changed interrupt only goes high after all rows are polled
        assign Changed = (cnt == 2'b00) && changed_reg;

        always @ (posedge Clock)
        begin
            cnt <= cnt + 1;
            Switch_State <= Switch_State;  // Ensure all pins have default assignment
            case(cnt)
                2'b00:
                begin
                    Switch_State[7:0] <= Row_Input;
                    if(Switch_State[7:0] != Row_Input)
                    begin
                        changed_reg <= 1;
                    end
                    else
                    begin
                        changed_reg <= 0;
                    end
                end
                2'b01:
                begin
                    Switch_State[15:8] <= Row_Input;
                    if(Switch_State[15:8] != Row_Input)
                    begin
                        changed_reg <= 1;
                    end
                    else
                    begin
                        changed_reg <= changed_reg;
                    end
                end
                2'b10:
                begin
                    Switch_State[23:16] <= Row_Input;
                    if(Switch_State[23:16] != Row_Input)
                    begin
                        changed_reg <= 1;
                    end
                    else
                    begin
                        changed_reg <= changed_reg;
                    end
                end
                2'b11:
                begin
                    Switch_State[31:24] <= Row_Input;
                    if(Switch_State[31:24] != Row_Input)
                    begin
                        changed_reg <= 1;
                    end
                    else
                    begin
                        changed_reg <= changed_reg;
                    end
                end
        	endcase
        end
    end
    else // Do not generate interrupt
    begin
        reg [1:0] cnt;  // Current column

        // De-sequence the count as the output. It only has 1 pin high at a time
        assign Column_Output = ~(4'b0001 << cnt); // Hopefully, this optimizes to a LUT instead of SHIFT8 

        always @ (posedge Clock)
        begin
            cnt <= cnt + 1;
            Switch_State <= Switch_State;  // Ensure all pins have default assignment
            case(cnt)
                2'b00:
                begin
                    Switch_State[7:0] <= Row_Input;
                end
                2'b01:
                begin
                    Switch_State[15:8] <= Row_Input;
                end
                2'b10:
                begin
                    Switch_State[23:16] <= Row_Input;
                end
                2'b11:
                begin
                    Switch_State[31:24] <= Row_Input;
                end
        	endcase
        end
    end
    endgenerate

//`#end` -- edit above this line, do not edit this line
endmodule
//`#start footer` -- edit after this line, do not edit this line
//`#end` -- edit above this line, do not edit this line
