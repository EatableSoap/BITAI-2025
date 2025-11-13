`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/27 18:22:39
// Design Name: 
// Module Name: pc_reg
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
module pc_reg(
    input clk,
    input rst_n,
    input [31:0] pc_new,
    output reg [31:0] pc_out
    );

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			pc_out<=`zero_word;
		else
			pc_out<=pc_new;
	end

endmodule
