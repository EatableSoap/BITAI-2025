//~ `New testbench
`timescale  1ns / 1ps

module tb_aluCtrl;

// aluCtrl Parameters
parameter PERIOD  = 10;


// aluCtrl Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   [1:0]  ALUOp                         = 0 ;
reg   [2:0]  func3                         = 0 ;
reg   func7                                = 0 ;

// aluCtrl Outputs
wire  [1:0]  ALUCtrl                       ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

aluCtrl  u_aluCtrl (
    .clk                     ( clk            ),
    .rst_n                   ( rst_n          ),
    .ALUOp                   ( ALUOp    [1:0] ),
    .func3                   ( func3    [2:0] ),
    .func7                   ( func7          ),

    .ALUCtrl                 ( ALUCtrl  [1:0] )
);

initial
begin
    $dumpfile("aluCtrl.vcd");
    $dumpvars();
end
    

initial
begin
    // reset
    #10 rst_n = 1;
    $display("ADD:b00, SUB:b01, OR:b10");

    #10 ALUOp = 2'b00;
        func3 = 3'b000;
        func7 = 1;
    #10;
    $display("ALUOp = %b, func3 = %b, func7 = %b, ALUCtrl = %b",ALUOp,func3,func7,ALUCtrl);

    #10 ALUOp = 2'b00;
        func3 = 3'b000;
        func7 = 0;
    #10;
    $display("ALUOp = %b, func3 = %b, func7 = %b, ALUCtrl = %b",ALUOp,func3,func7,ALUCtrl);

    #10 ALUOp = 2'b01;
        func3 = 3'b110;
        func7 = 0;
    #10;
    $display("ALUOp = %b, func3 = %b, func7 = %b, ALUCtrl = %b",ALUOp,func3,func7,ALUCtrl);

    #10 ALUOp = 2'b00;
        func3 = 3'b010;
        func7 = 1;
    #10;
    $display("ALUOp = %b, func3 = %b, func7 = %b, ALUCtrl = %b",ALUOp,func3,func7,ALUCtrl);

    #10 $finish;
end

endmodule
