
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
// Generated on 06/17/2017 at 19:33

module Adder_Hard_IN_Hard_OUT (
    value,
    clk,
    slope,
    carry_in,
    carry_out
);

    output reg [7:0] value;
	input wire clk;
	input wire [7:0] slope;
    input wire carry_in;
    output wire carry_out;
    
    localparam STATE_ADD      = 2'b00;
    localparam STATE_LATCH_PO = 2'b01;
    
    reg state;
    wire [7:0] po;
    
    always @(posedge clk)
    begin
        case (state)
            STATE_ADD: // PI is added to A0 and stored in A0. PO is invalid
            begin
                state <= STATE_LATCH_PO;
            end
            
            STATE_LATCH_PO: // A0 is output on PO. Latch to value reg
            begin
                state <= STATE_ADD;
                value <= po;
            end
        endcase
    end
    
    cy_psoc3_dp #(.a0_init(0), .a1_init(0), 
.cy_dpconfig(
    {
        `CS_ALU_OP__ADD, `CS_SRCA_A0, `CS_SRCB_A0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_ENBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM0:   A0 = A0 + PI (STATE_ADD)*/
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM1: PO = A0*/
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM2:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM3:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM4:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM5:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM6:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM7:   */
        8'hFF, 8'h00,  /*CFG9:   */
        8'hFF, 8'hFF,  /*CFG11-10:   */
        `SC_CMPB_A1_D1, `SC_CMPA_A1_D1, `SC_CI_B_ARITH,
        `SC_CI_A_ARITH, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
        `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
        `SC_SI_A_DEFSI, /*CFG13-12:   */
        `SC_A0_SRC_ACC, `SC_SHIFT_SL, `SC_PI_DYN_EN,
        1'h0, `SC_FIFO1_BUS, `SC_FIFO0_BUS,
        `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_CHNED,
        `SC_FB_CHNED, `SC_CMP1_CHNED,
        `SC_CMP0_CHNED, /*CFG15-14:   */
        10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_AX,
        `SC_FIFO_LEVEL,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
        `SC_WRK16CAT_DSBL /*CFG17-16:   */
    }
    )) add_pi_po(
            /*  input                   */  .reset(1'b0),
            /*  input                   */  .clk(clk),
            /*  input   [02:00]         */  .cs_addr({2'b0, state}),
            /*  input                   */  .route_si(1'b0),
            /*  input                   */  .route_ci(1'b0),
            /*  input                   */  .f0_load(1'b0),
            /*  input                   */  .f1_load(1'b0),
            /*  input                   */  .d0_load(1'b0),
            /*  input                   */  .d1_load(1'b0),
            /*  output                  */  .ce0(),
            /*  output                  */  .cl0(),
            /*  output                  */  .z0(),
            /*  output                  */  .ff0(),
            /*  output                  */  .ce1(),
            /*  output                  */  .cl1(),
            /*  output                  */  .z1(),
            /*  output                  */  .ff1(),
            /*  output                  */  .ov_msb(),
            /*  output                  */  .co_msb(),
            /*  output                  */  .cmsb(),
            /*  output                  */  .so(),
            /*  output                  */  .f0_bus_stat(),
            /*  output                  */  .f0_blk_stat(),
            /*  output                  */  .f1_bus_stat(),
            /*  output                  */  .f1_blk_stat(),
            
            /* input                    */  .ci(carry_in),     // Carry in from previous stage
            /* output                   */  .co(carry_out),         // Carry out to next stage
            /* input                    */  .sir(1'b0),    // Shift in from right side
            /* output                   */  .sor(),        // Shift out to right side
            /* input                    */  .sil(1'b0),    // Shift in from left side
            /* output                   */  .sol(),        // Shift out to left side
            /* input                    */  .msbi(1'b0),   // MSB chain in
            /* output                   */  .msbo(),       // MSB chain out
            /* input [01:00]            */  .cei(2'b0),    // Compare equal in from prev stage
            /* output [01:00]           */  .ceo(),        // Compare equal out to next stage
            /* input [01:00]            */  .cli(2'b0),    // Compare less than in from prv stage
            /* output [01:00]           */  .clo(),        // Compare less than out to next stage
            /* input [01:00]            */  .zi(2'b0),     // Zero detect in from previous stage
            /* output [01:00]           */  .zo(),         // Zero detect out to next stage
            /* input [01:00]            */  .fi(2'b0),     // 0xFF detect in from previous stage
            /* output [01:00]           */  .fo(),         // 0xFF detect out to next stage
            /* input [01:00]            */  .capi(2'b0),   // Software capture from previous stage
            /* output [01:00]           */  .capo(),       // Software capture to next stage
            /* input                    */  .cfbi(1'b0),   // CRC Feedback in from previous stage
            /* output                   */  .cfbo(),       // CRC Feedback out to next stage
            /* input [07:00]            */  .pi(slope),     // Parallel data port
            /* output [07:00]           */  .po(po)      // Parallel data port
    );
endmodule

module Adder_Hard_IN_Reg_OUT (
    clk,
    slope,
    carry_in,
    carry_out
    );
    
	input wire clk;
	input wire [7:0] slope;
    input wire carry_in;
    output wire carry_out;
    
    cy_psoc3_dp #(.a0_init(0), .a1_init(0), 
.cy_dpconfig(
    {
        `CS_ALU_OP__ADD, `CS_SRCA_A0, `CS_SRCB_A0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_ENBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM0:   A0 = A0 + PI*/
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM1:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM2:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM3:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM4:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM5:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM6:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM7:   */
        8'hFF, 8'h00,  /*CFG9:   */
        8'hFF, 8'hFF,  /*CFG11-10:   */
        `SC_CMPB_A1_D1, `SC_CMPA_A1_D1, `SC_CI_B_ARITH,
        `SC_CI_A_ARITH, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
        `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
        `SC_SI_A_DEFSI, /*CFG13-12:   */
        `SC_A0_SRC_ACC, `SC_SHIFT_SL, `SC_PI_DYN_EN,
        1'h0, `SC_FIFO1_BUS, `SC_FIFO0_ALU,
        `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_NOCHN,
        `SC_FB_NOCHN, `SC_CMP1_NOCHN,
        `SC_CMP0_NOCHN, /*CFG15-14:  Clock F0 to ALU*/
        10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_AX,
        `SC_FIFO_LEVEL,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
        `SC_WRK16CAT_DSBL /*CFG17-16:   */
    }
    )) add_pi_r(
            /*  input                   */  .reset(1'b0),
            /*  input                   */  .clk(clk),
            /*  input   [02:00]         */  .cs_addr(3'b0),
            /*  input                   */  .route_si(1'b0),
            /*  input                   */  .route_ci(1'b0),
            /*  input                   */  .f0_load(1'b0),
            /*  input                   */  .f1_load(1'b0),
            /*  input                   */  .d0_load(1'b0),
            /*  input                   */  .d1_load(1'b0),
            /*  output                  */  .ce0(),
            /*  output                  */  .cl0(),
            /*  output                  */  .z0(),
            /*  output                  */  .ff0(),
            /*  output                  */  .ce1(),
            /*  output                  */  .cl1(),
            /*  output                  */  .z1(),
            /*  output                  */  .ff1(),
            /*  output                  */  .ov_msb(),
            /*  output                  */  .co_msb(),
            /*  output                  */  .cmsb(),
            /*  output                  */  .so(),
            /*  output                  */  .f0_bus_stat(),
            /*  output                  */  .f0_blk_stat(),
            /*  output                  */  .f1_bus_stat(),
            /*  output                  */  .f1_blk_stat(),
            
            /* input                    */  .ci(carry_in),     // Carry in from previous stage
            /* output                   */  .co(carry_out),         // Carry out to next stage
            /* input                    */  .sir(1'b0),    // Shift in from right side
            /* output                   */  .sor(),        // Shift out to right side
            /* input                    */  .sil(1'b0),    // Shift in from left side
            /* output                   */  .sol(),        // Shift out to left side
            /* input                    */  .msbi(1'b0),   // MSB chain in
            /* output                   */  .msbo(),       // MSB chain out
            /* input [01:00]            */  .cei(2'b0),    // Compare equal in from prev stage
            /* output [01:00]           */  .ceo(),        // Compare equal out to next stage
            /* input [01:00]            */  .cli(2'b0),    // Compare less than in from prv stage
            /* output [01:00]           */  .clo(),        // Compare less than out to next stage
            /* input [01:00]            */  .zi(2'b0),     // Zero detect in from previous stage
            /* output [01:00]           */  .zo(),         // Zero detect out to next stage
            /* input [01:00]            */  .fi(2'b0),     // 0xFF detect in from previous stage
            /* output [01:00]           */  .fo(),         // 0xFF detect out to next stage
            /* input [01:00]            */  .capi(2'b0),   // Software capture from previous stage
            /* output [01:00]           */  .capo(),       // Software capture to next stage
            /* input                    */  .cfbi(1'b0),   // CRC Feedback in from previous stage
            /* output                   */  .cfbo(),       // CRC Feedback out to next stage
            /* input [07:00]            */  .pi(slope[7:0]),     // Parallel data port
            /* output [07:00]           */  .po()          // Parallel data port
    );
    
endmodule

module Adder_Reg_IN_Hard_OUT (
    value,
    clk,
    carry_in,
    carry_out
    );
    
    input wire clk;
	output wire [7:0] value;
    input wire carry_in;
    output wire carry_out;
    
    cy_psoc3_dp #(.a0_init(0), .a1_init(0), 
.cy_dpconfig(
    {
        `CS_ALU_OP__ADD, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_ENBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM0:   A0 = A0 + D0*/
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM1:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM2:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM3:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM4:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM5:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM6:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM7:   */
        8'hFF, 8'h00,  /*CFG9:   */
        8'hFF, 8'hFF,  /*CFG11-10:   */
        `SC_CMPB_A1_D1, `SC_CMPA_A1_D1, `SC_CI_B_ARITH,
        `SC_CI_A_ARITH, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
        `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
        `SC_SI_A_DEFSI, /*CFG13-12:   */
        `SC_A0_SRC_ACC, `SC_SHIFT_SL, `SC_PI_DYN_DS,
        1'h0, `SC_FIFO1_BUS, `SC_FIFO0_BUS,
        `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_NOCHN,
        `SC_FB_NOCHN, `SC_CMP1_NOCHN,
        `SC_CMP0_NOCHN, /*CFG15-14:   */
        10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_AX,
        `SC_FIFO_LEVEL,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
        `SC_WRK16CAT_DSBL /*CFG17-16:   */
    }
    )) add_r_po(
            /*  input                   */  .reset(1'b0),
            /*  input                   */  .clk(clk),
            /*  input   [02:00]         */  .cs_addr(3'b0),
            /*  input                   */  .route_si(1'b0),
            /*  input                   */  .route_ci(1'b0),
            /*  input                   */  .f0_load(1'b0),
            /*  input                   */  .f1_load(1'b0),
            /*  input                   */  .d0_load(1'b0),
            /*  input                   */  .d1_load(1'b0),
            /*  output                  */  .ce0(),
            /*  output                  */  .cl0(),
            /*  output                  */  .z0(),
            /*  output                  */  .ff0(),
            /*  output                  */  .ce1(),
            /*  output                  */  .cl1(),
            /*  output                  */  .z1(),
            /*  output                  */  .ff1(),
            /*  output                  */  .ov_msb(),
            /*  output                  */  .co_msb(),
            /*  output                  */  .cmsb(),
            /*  output                  */  .so(),
            /*  output                  */  .f0_bus_stat(),
            /*  output                  */  .f0_blk_stat(),
            /*  output                  */  .f1_bus_stat(),
            /*  output                  */  .f1_blk_stat(),
            
            /* input                    */  .ci(carry_in),     // Carry in from previous stage
            /* output                   */  .co(carry_out),         // Carry out to next stage
            /* input                    */  .sir(1'b0),    // Shift in from right side
            /* output                   */  .sor(),        // Shift out to right side
            /* input                    */  .sil(1'b0),    // Shift in from left side
            /* output                   */  .sol(),        // Shift out to left side
            /* input                    */  .msbi(1'b0),   // MSB chain in
            /* output                   */  .msbo(),       // MSB chain out
            /* input [01:00]            */  .cei(2'b0),    // Compare equal in from prev stage
            /* output [01:00]           */  .ceo(),        // Compare equal out to next stage
            /* input [01:00]            */  .cli(2'b0),    // Compare less than in from prv stage
            /* output [01:00]           */  .clo(),        // Compare less than out to next stage
            /* input [01:00]            */  .zi(2'b0),     // Zero detect in from previous stage
            /* output [01:00]           */  .zo(),         // Zero detect out to next stage
            /* input [01:00]            */  .fi(2'b0),     // 0xFF detect in from previous stage
            /* output [01:00]           */  .fo(),         // 0xFF detect out to next stage
            /* input [01:00]            */  .capi(2'b0),   // Software capture from previous stage
            /* output [01:00]           */  .capo(),       // Software capture to next stage
            /* input                    */  .cfbi(1'b0),   // CRC Feedback in from previous stage
            /* output                   */  .cfbo(),       // CRC Feedback out to next stage
            /* input [07:00]            */  .pi(),     // Parallel data port
            /* output [07:00]           */  .po(value)      // Parallel data port
    );
    
endmodule

module Adder_Reg_IN_Reg_OUT (
    clk,
    carry_in,
    carry_out
    );
    
    input wire clk;
    input wire carry_in;
    output wire carry_out;
    
    cy_psoc3_dp #(.a0_init(0), .a1_init(0), 
.cy_dpconfig(
    {
        `CS_ALU_OP__ADD, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_ENBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM0:   A0 = A0 + D0*/
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM1:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM2:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM3:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM4:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM5:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM6:   */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM7:   */
        8'hFF, 8'h00,  /*CFG9:   */
        8'hFF, 8'hFF,  /*CFG11-10:   */
        `SC_CMPB_A1_D1, `SC_CMPA_A1_D1, `SC_CI_B_ARITH,
        `SC_CI_A_ARITH, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
        `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
        `SC_SI_A_DEFSI, /*CFG13-12:   */
        `SC_A0_SRC_ACC, `SC_SHIFT_SL, `SC_PI_DYN_DS,
        1'h0, `SC_FIFO1_BUS, `SC_FIFO0_ALU,
        `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_NOCHN,
        `SC_FB_NOCHN, `SC_CMP1_NOCHN,
        `SC_CMP0_NOCHN, /*CFG15-14:  Clock F0 with ALU output*/
        10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_AX,
        `SC_FIFO_LEVEL,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
        `SC_WRK16CAT_DSBL /*CFG17-16:   */
    }
    )) add_r_r(
            /*  input                   */  .reset(1'b0),
            /*  input                   */  .clk(clk),
            /*  input   [02:00]         */  .cs_addr(3'b0),
            /*  input                   */  .route_si(1'b0),
            /*  input                   */  .route_ci(1'b0),
            /*  input                   */  .f0_load(1'b0),
            /*  input                   */  .f1_load(1'b0),
            /*  input                   */  .d0_load(1'b0),
            /*  input                   */  .d1_load(1'b0),
            /*  output                  */  .ce0(),
            /*  output                  */  .cl0(),
            /*  output                  */  .z0(),
            /*  output                  */  .ff0(),
            /*  output                  */  .ce1(),
            /*  output                  */  .cl1(),
            /*  output                  */  .z1(),
            /*  output                  */  .ff1(),
            /*  output                  */  .ov_msb(),
            /*  output                  */  .co_msb(),
            /*  output                  */  .cmsb(),
            /*  output                  */  .so(),
            /*  output                  */  .f0_bus_stat(),
            /*  output                  */  .f0_blk_stat(),
            /*  output                  */  .f1_bus_stat(),
            /*  output                  */  .f1_blk_stat(),
            
            /* input                    */  .ci(carry_in),     // Carry in from previous stage
            /* output                   */  .co(carry_out),         // Carry out to next stage
            /* input                    */  .sir(1'b0),    // Shift in from right side
            /* output                   */  .sor(),        // Shift out to right side
            /* input                    */  .sil(1'b0),    // Shift in from left side
            /* output                   */  .sol(),        // Shift out to left side
            /* input                    */  .msbi(1'b0),   // MSB chain in
            /* output                   */  .msbo(),       // MSB chain out
            /* input [01:00]            */  .cei(2'b0),    // Compare equal in from prev stage
            /* output [01:00]           */  .ceo(),        // Compare equal out to next stage
            /* input [01:00]            */  .cli(2'b0),    // Compare less than in from prv stage
            /* output [01:00]           */  .clo(),        // Compare less than out to next stage
            /* input [01:00]            */  .zi(2'b0),     // Zero detect in from previous stage
            /* output [01:00]           */  .zo(),         // Zero detect out to next stage
            /* input [01:00]            */  .fi(2'b0),     // 0xFF detect in from previous stage
            /* output [01:00]           */  .fo(),         // 0xFF detect out to next stage
            /* input [01:00]            */  .capi(2'b0),   // Software capture from previous stage
            /* output [01:00]           */  .capo(),       // Software capture to next stage
            /* input                    */  .cfbi(1'b0),   // CRC Feedback in from previous stage
            /* output                   */  .cfbo(),       // CRC Feedback out to next stage
            /* input [07:00]            */  .pi(),     // Parallel data port
            /* output [07:00]           */  .po()      // Parallel data port
    );
    
endmodule

// Component: Sawtooth_Generator_v1_0
module Sawtooth_Generator_v1_0 (
	value,
	clk,
	slope
);

	parameter [7:0] Width = 8'd8;
    output wire [(Width-1):0] value;
	input wire clk;
	input wire [(Width-1):0] slope;
    
    wire carry_0;

    Adder_Hard_IN_Hard_OUT add_0(.value(value[7:0]), .clk(clk), .slope(slope[7:0]), .carry_in(1'b0), .carry_out(carry_0));
    
//`#end` -- edit above this line, do not edit this line
endmodule
//`#start footer` -- edit after this line, do not edit this line
//`#end` -- edit above this line, do not edit this line


