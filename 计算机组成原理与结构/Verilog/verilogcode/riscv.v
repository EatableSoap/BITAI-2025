`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/28 00:52:55
// Design Name: 
// Module Name: riscv
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

// `include "control.v"
// `include "dataPath.v"
module riscv(
	input clk,
	input rst_n,
	input [31:0]instr,
	input [31:0]Rd_mem_data,
	
	output [7:0]rom_addr,
	output [31:0]Wr_mem_data,
	output W_en,
	output R_en,
	output [31:0]ram_addr
    );
	
	wire [6:0]opcode;
	wire [2:0]func3;
	wire func7;
	wire MemtoReg;
	wire ALUSrc;
	wire RegWrite;
	wire beq;
    wire bge;
    wire auipc;
	wire [1:0]ALUCtrl;
	
	
	
	control control_inst (
    .opcode(opcode), 
    .func3(func3), 
    .func7(func7), 
    .MemRead(R_en), 
    .MemtoReg(MemtoReg), 
    .MemWrite(W_en), 
    .ALUSrc(ALUSrc), 
    .RegWrite(RegWrite), 
    .beq(beq), 
    .bge(bge),
    .auipc(auipc),
    .ALUCtrl(ALUCtrl)
    );
	
	dataPath datapath_inst (
    .clk(clk), 
    .rst_n(rst_n), 
    .instr(instr), 
    .MemtoReg(MemtoReg), 
    .ALUSrc(ALUSrc), 
    .RegWrite(RegWrite), 
    .beq(beq), 
    .bge(bge),
    .auipc(auipc),
    .ALUCtrl(ALUCtrl), 
    .Rd_mem_data(Rd_mem_data), 
    .rom_addr(rom_addr), 
    .Wr_mem_data(Wr_mem_data),
	.ALU_result(ram_addr),
	.opcode(opcode),
	.func3(func3),
	.func7(func7)
    );

endmodule


