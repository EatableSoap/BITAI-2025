`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/26 22:57:03
// Design Name: 
// Module Name: registers
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

module registers(
    input clk,
    input W_en,
    input [4:0] Rs1,
    input [4:0] Rs2,
    input [4:0] Rd,
    input [31:0] Wr_data,
    output [31:0] Rd_data1,
    output [31:0] Rd_data2
    );

    reg [31:0] regs[31:0];

//write
    always @(posedge clk) begin
        if(W_en&(Rd!=0))
        begin
            regs[Rd] = Wr_data;
        end
    end
//read
    assign Rd_data1 = (Rs1==5'd0 ) ? `zero_word: regs[Rs1];
    assign Rd_data2 = (Rs2==5'd0 ) ? `zero_word: regs[Rs2];

endmodule
