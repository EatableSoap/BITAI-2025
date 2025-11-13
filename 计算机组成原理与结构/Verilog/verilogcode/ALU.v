`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/27 15:41:26
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "define.v"
module ALU(
    input [31:0] ALU_DA,
    input [31:0] ALU_DB,
    input [1:0] ALU_Ctrl,
    output ALU_ZERO,
    output ALU_OverFlow,
    output reg [31:0] ALU_DC
    );

    wire SUBsig;
    assign SUBsig = ALU_Ctrl[0];

//ADD SUB
    wire [31:0] BIT_M,XOR_M;
    wire ADD_OverFlow;
    wire [31:0] ADD_result;

    assign BIT_M={32{SUBsig}};
    assign XOR_M=BIT_M^ALU_DB;

    Adder Adder(.A(ALU_DA),
                .B(XOR_M),
                .Cin(SUBsig),
                .ALU_Ctrl(ALU_Ctrl),
                .ADD_OverFlow(ADD_OverFlow),
                .ADD_zero(ALU_ZERO),
                .ADD_result(ADD_result));

    assign ALU_OverFlow = ADD_OverFlow;

//OR
    wire [31:0] OR_result;
    assign OR_result = ALU_DA|ALU_DB;

always @(*) begin
        case (ALU_Ctrl)
        `ADD: ALU_DC <= ADD_result;
        `OR: ALU_DC <= OR_result;
        `SUB:ALU_DC <= ADD_result;
    endcase
end

endmodule

//Adder
module Adder(input [31:0] A,
             input [31:0] B,
			 input Cin,
			 input [1:0] ALU_Ctrl,
			 output ADD_OverFlow,
			 output ADD_zero,
			 output [31:0] ADD_result);


    assign {ADD_carry,ADD_result}=A+B+Cin;
    assign ADD_zero = ~(|ADD_result);
    assign ADD_OverFlow=((ALU_Ctrl==2'b00) & ~A[31] & ~B[31] & ADD_result[31]) 
                        | ((ALU_Ctrl==2'b00) & A[31] & B[31] & ~ADD_result[31])
                        | ((ALU_Ctrl==2'b10) & ~A[31] & B[31] & ADD_result[31])
                        | ((ALU_Ctrl==2'b10) & A[31] & ~B[31] & ~ADD_result[31]);
endmodule

module add4Adder(input [31:0] A,
             input [31:0] B,
			 input Cin,
			 input [1:0] ALU_Ctrl,
			 output ADD_OverFlow,
			 output ADD_zero,
			 output [31:0] ADD_result);


    assign {ADD_carry,ADD_result}=A+B+Cin;
    assign ADD_zero = ~(|ADD_result);
    assign ADD_OverFlow=((ALU_Ctrl==2'b00) & ~A[31] & ~B[31] & ADD_result[31]) 
                        | ((ALU_Ctrl==2'b00) & A[31] & B[31] & ~ADD_result[31])
                        | ((ALU_Ctrl==2'b10) & ~A[31] & B[31] & ADD_result[31])
                        | ((ALU_Ctrl==2'b10) & A[31] & ~B[31] & ~ADD_result[31]);
endmodule

module addimmAdder(input [31:0] A,
             input [31:0] B,
			 input Cin,
			 input [1:0] ALU_Ctrl,
			 output ADD_OverFlow,
			 output ADD_zero,
			 output [31:0] ADD_result);


    assign {ADD_carry,ADD_result}=A+B+Cin;
    assign ADD_zero = ~(|ADD_result);
    assign ADD_OverFlow=((ALU_Ctrl==2'b00) & ~A[31] & ~B[31] & ADD_result[31]) 
                        | ((ALU_Ctrl==2'b00) & A[31] & B[31] & ~ADD_result[31])
                        | ((ALU_Ctrl==2'b10) & ~A[31] & B[31] & ADD_result[31])
                        | ((ALU_Ctrl==2'b10) & A[31] & ~B[31] & ~ADD_result[31]);
endmodule