`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/28 00:04:00
// Design Name: 
// Module Name: main_control
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
module main_control(
	input clk,
	input rst_n,
	input [6:0]opcode,
	input [2:0]func3,
	output MemRead,
	output MemtoReg,
	output [1:0] ALUop,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output beq,
	output bge,
	output auipc
    );
	
	wire branch;
	wire R_type;
	wire I_type;
	wire load;
	wire store;
	
	assign branch=(opcode==`B_type)?1'b1:1'b0;
	assign R_type=(opcode==`R_type)?1'b1:1'b0;
	assign I_type=(opcode==`I_type)?1'b1:1'b0;
	assign load=(opcode==`load)?1'b1:1'b0;
	assign store=(opcode==`store)?1'b1:1'b0;
	assign auipc = (opcode==`auipc)? 1'b1:1'b0;
	assign beq= branch & (func3==3'b000);
	assign bge= branch & (func3==3'b101);
	
	
//memory or register r/w
	assign MemRead = load;
	assign MemWrite = store;
	assign RegWrite = load | I_type |R_type|auipc;
	
//	MUX
	assign ALUSrc = load | store | I_type |auipc;  //select imme
	assign MemtoReg= load;  //select datamemory data
	
//	ALUop
	assign ALUop[1]= branch|auipc; //OR 01 B 10 ADD 00
	assign ALUop[0]= I_type|auipc;
endmodule

