`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/27 14:26:31
// Design Name: 
// Module Name: aluCtrl
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
module aluCtrl(
    input [1:0] ALUOp, // op type(R/I/B/S)
    input [2:0] func3,
    input func7,
    output [1:0] ALUCtrl
    );

    reg [1:0] ctrl;

    // always@(*)
	// begin
	// 	case(func3)
	// 		3'b000: if(ALUOp==2'b00)
	// 				    if(func7)
    //                     ctrl=`SUB;
	// 				    else
	// 				    ctrl=`ADD;
    //                 else
    //                     if(ALUOp==2'b01)
    //                         ctrl=`ADD;
    //                     else
    //                         ctrl=`SUB;
	// 		3'b110: ctrl=`OR;
    //         3'b010: ctrl=`ADD;
    //         3'b101: ctrl=`SUB;
	// 		default:ctrl=`ADD;
	// 	endcase
	// end

    always@(*)
	begin
		case(ALUOp)
			2'b00:  if(func7)
                        ctrl=`SUB;
					else
					    ctrl=`ADD;

            2'b01:
                    if(func3==3'b000)
                        ctrl=`ADD;
                    else
                        ctrl=`OR;
			2'b10:  ctrl=`SUB;
            2'b11:  ctrl=`ADD;
			default:ctrl=`ADD;
		endcase
	end

    assign ALUCtrl = ctrl;
endmodule
