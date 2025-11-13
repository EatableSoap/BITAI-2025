//~ `New testbench
`timescale  1ns / 1ps

module tb_ALU;

// ALU Parameters
parameter PERIOD  = 10;


// ALU Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   [31:0]  ALU_DA                       = 0 ;
reg   [31:0]  ALU_DB                       = 0 ;
reg   [1:0]  ALU_Ctrl                      = 0 ;

// ALU Outputs
wire  ALU_ZERO                             ;
wire  ALU_OverFlow                         ;
wire  [31:0]  ALU_DC                       ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

ALU  u_ALU (
    .clk                     ( clk                  ),
    .rst_n                   ( rst_n                ),
    .ALU_DA                  ( ALU_DA        [31:0] ),
    .ALU_DB                  ( ALU_DB        [31:0] ),
    .ALU_Ctrl                ( ALU_Ctrl      [1:0]  ),

    .ALU_ZERO                ( ALU_ZERO             ),
    .ALU_OverFlow            ( ALU_OverFlow         ),
    .ALU_DC                  ( ALU_DC        [31:0] )
);

initial
begin
    $dumpfile("ALU.vcd");
    $dumpvars();
end
    

initial
begin
    // reset
    #10 rst_n = 1;

    //Add
    #10 ALU_DA = 32'h00000010; 
        ALU_DB = 32'h00000020;
        ALU_Ctrl = 2'b00;
    #10;
    $display("ADD: ALU_DA = %h, ALU_DB = %h, ALU_DC = %h, ALU_ZERO = %b, ALU_OverFlow = %b", 
                ALU_DA, ALU_DB, ALU_DC, ALU_ZERO, ALU_OverFlow);

    // Sub
    #10 ALU_DA = 32'h00000030;
        ALU_DB = 32'h00000010;
        ALU_Ctrl = 2'b01;
    #10;
    $display("SUB: ALU_DA = %h, ALU_DB = %h, ALU_DC = %h, ALU_ZERO = %b, ALU_OverFlow = %b", 
                ALU_DA, ALU_DB, ALU_DC, ALU_ZERO, ALU_OverFlow);

    // Or
    #10 ALU_DA = 32'hFF00FF00;
        ALU_DB = 32'h00FF00FF;
        ALU_Ctrl = 2'b10;
    #10;
    $display("OR: ALU_DA = %h, ALU_DB = %h, ALU_DC = %h, ALU_ZERO = %b, ALU_OverFlow = %b", 
                ALU_DA, ALU_DB, ALU_DC, ALU_ZERO, ALU_OverFlow);

    // overflow
    #10 ALU_DA = 32'h7FFFFFFF; 
        ALU_DB = 32'h00000001; 
        ALU_Ctrl = 2'b00;
    #10;
    $display("Overflow ADD: ALU_DA = %h, ALU_DB = %h, ALU_DC = %h, ALU_ZERO = %b, ALU_OverFlow = %b", 
                ALU_DA, ALU_DB, ALU_DC, ALU_ZERO, ALU_OverFlow);

    #10 $finish;
end

endmodule
