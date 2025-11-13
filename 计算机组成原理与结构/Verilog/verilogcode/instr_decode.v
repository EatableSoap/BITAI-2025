`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/27 12:39:05
// Design Name: 
// Module Name: instr_decode
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
module instr_decode(
    input [31:0] instr,
    output [6:0] opcode,
    output [2:0] func3,
    output func7,
    output [4:0] Rs1,
    output [4:0] Rs2,
    output [4:0] Rd,
    output [31:0] imme
    );

    wire I_type;
	wire B_type;
	wire S_type;

    wire [31:0]I_imme;
	wire [31:0]B_imme;
	wire [31:0]S_imme;

    assign opcode=instr[6:0];
	assign func3=instr[14:12];
	assign func7=instr[30];
	assign Rs1=instr[19:15];
	assign Rs2=instr[24:20];
	assign Rd =instr[11:7];

	assign I_type=(instr[6:0]==`load) | (instr[6:0]==`I_type);
	assign B_type=(instr[6:0]==`B_type);
	assign S_type=(instr[6:0]==`store);
	assign auipc=(instr[6:0]==`auipc);

    assign I_imme={{20{instr[31]}},instr[31:20]}; 
	assign B_imme={{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};
	assign S_imme={{20{instr[31]}},instr[31:25],instr[11:7]}; 
	assign auipc_imme={instr[31:12],12'b0};
	
	assign imme= I_type?I_imme :
				 B_type?B_imme :
				 S_type?S_imme :
				 auipc?auipc_imme :32'd0;

endmodule
