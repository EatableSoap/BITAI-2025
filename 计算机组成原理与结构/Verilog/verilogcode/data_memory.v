`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/26 20:16:22
// Design Name: 
// Module Name: data_memory
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

module data_memory(
    input clk,
    input rst_n,
    input W_en,
    input R_en,
    input [31:0] addr,
    input [31:0] din,
    output [31:0] dout
    );

    reg [31:0] ram [255:0];
    wire [31:0] Rd_data;
    wire [31:0] Wr_data;

    assign Rd_data = ram[addr[9:2]];
    assign Wr_data = din;
    assign dout = Rd_data;

    always @(posedge clk) begin
      if(W_en)
        begin
          ram[addr[9:2]]<=Wr_data;
        end
    end
endmodule
