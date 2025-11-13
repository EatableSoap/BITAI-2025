`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/27 21:57:42
// Design Name: 
// Module Name: dataPath
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

`include "pc_reg.v"
`include "instr_decode.v"
`include "registers.v"
`include "ALU.v"
`include "mux.v"

module dataPath(
    input clk,
    input rst_n,
    input [31:0] instr,
    input MemtoReg,
    input ALUSrc,
    input RegWrite,
    input beq,
    input bge,
    input auipc,
    input [1:0] ALUCtrl,
    input [31:0] Rd_mem_data,
    output [7:0] rom_addr,
    output [31:0] Wr_mem_data,
    output [31:0] ALU_result,
    output [6:0] opcode,
    output [2:0] func3,
    output func7
    );
	
	wire [4:0]Rs1;
	wire [4:0]Rs2;
	wire [4:0]Rd;
	wire [31:0]imme;
	
	wire [31:0] Wr_reg_data;
	wire [31:0] Rd_data1;
	wire [31:0] Rd_data2;
	
    wire jump_flag;

	wire zero;
    wire overflow;
	
	wire [31:0]pc_order;
	wire [31:0]pc_jump;
	
	wire [31:0]pc_new;
	wire [31:0]pc_out;
	
	wire [31:0]ALU_DB;
	
	wire [31:0]Wr_reg_data1;
	wire [31:0]Wr_reg_data2;
	// wire [31:0]pc_jump_order;
	
	assign Wr_mem_data=Rd_data2;
    assign rom_addr=pc_out[9:2];

	instr_decode instr_decode_inst (
    .instr(instr), 
    .opcode(opcode), 
    .func3(func3), 
    .func7(func7), 
    .Rs1(Rs1), 
    .Rs2(Rs2), 
    .Rd(Rd), 
    .imme(imme)
    );
	
    registers registers_inst (
    .clk(clk), 
    .W_en(RegWrite), 
    .Rs1(Rs1), 
    .Rs2(Rs2), 
    .Rd(Rd), 
    .Wr_data(Wr_reg_data), 
    .Rd_data1(Rd_data1), 
    .Rd_data2(Rd_data2)
    );

	
	ALU alu_inst (
    .ALU_DA(Rd_data1), 
    .ALU_DB(ALU_DB), 
    .ALU_Ctrl(ALUCtrl), 
    .ALU_ZERO(zero), 
    .ALU_OverFlow(overflow), 
    .ALU_DC(ALU_result)
    );

    assign jump_flag = (rst_n==1'b1)&&(((beq==1'b1) && (zero==1'b1))||((bge==1'b1) && ((overflow==1'b1)?ALU_result[31]:~ALU_result[31])));
	
//pc+4	
	add4Adder pc_adder_4 (
    .A(pc_out), 
    .B(32'd4), 
    .Cin(1'd0), 
    .ALU_Ctrl(2'b00),
    .ADD_OverFlow(),
    .ADD_zero(),
    .ADD_result(pc_order)
    );
	
//pc+imme
	addimmAdder pc_adder_imme (
    .A(pc_out), 
    .B(imme), 
    .Cin(1'd0), 
    .ALU_Ctrl(2'b00),
    .ADD_OverFlow(),
    .ADD_zero(),
    .ADD_result(pc_jump)
    );

    // assign pc_new = jump_flag?pc_jump:pc_order;

    pc_reg pc_reg_inst (
    .clk(clk), 
    .rst_n(rst_n), 
    .pc_new(pc_new), 
    .pc_out(pc_out)
    );



//pc_sel
    assign pc_new = (jump_flag==1'b1)?pc_jump:pc_order;
	// mux pc_mux (
    // .selectBranch(jump_flag),
    // .DataA(pc_order), 
    // .DataB(pc_jump), 
    // .result(pc_new)
    // );

	
//ALUdata_sel
    assign ALU_DB = (ALUSrc==1'b1)?imme:Rd_data2;	
	// mux ALU_data_mux (
    // .selectBranch(ALUSrc), 
    // .DataA(Rd_data2), 
    // .DataB(imme), 
    // .result(ALU_DB)
    // );
	
	
//ALU_result or datamem	
    assign Wr_reg_data = (auipc==1'b1)?pc_jump:MemtoReg?Rd_mem_data:ALU_result;
	// mux WB_data_mux (
    // .selectBranch(MemtoReg),
    // .DataA(ALU_result), 
    // .DataB(Rd_mem_data), 
    // .result(Wr_reg_data)
    // );
endmodule

