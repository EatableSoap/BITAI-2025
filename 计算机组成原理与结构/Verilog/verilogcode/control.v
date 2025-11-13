`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/28 00:14:52
// Design Name: 
// Module Name: control
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
// `include "main_control.v"
// `include "aluCtrl.v"
module control(
	input [6:0] opcode,
	input [2:0] func3,
	input func7,
	output MemRead,
	output MemtoReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output beq,
	output bge,
	output auipc,
	output [1:0] ALUCtrl
    );
	
	wire [1:0]ALUop;
	
	main_control main_control_inst(
	.opcode(opcode),
	.func3(func3),
	.MemRead(MemRead),
	.MemtoReg(MemtoReg),
	.ALUop(ALUop),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.RegWrite(RegWrite),
	.beq(beq),
	.bge(bge),
	.auipc(auipc)
	);
	
	aluCtrl alu_control_inst(
	.ALUOp(ALUop),
	.func3(func3),
	.func7(func7),
	.ALUCtrl(ALUCtrl)
    );
	
endmodule

