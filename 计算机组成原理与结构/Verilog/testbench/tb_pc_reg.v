//~ `New testbench
`timescale  1ns / 1ps

module tb_pc_reg;

// pc_reg Parameters
parameter PERIOD  = 10;


// pc_reg Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   [31:0]  pc_new                       = 0 ;

// pc_reg Outputs
wire  [31:0]  pc_out                       ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

pc_reg  u_pc_reg (
    .clk                     ( clk            ),
    .rst_n                   ( rst_n          ),
    .pc_new                  ( pc_new  [31:0] ),

    .pc_out                  ( pc_out  [31:0] )
);

initial
begin
    $dumpfile("pc_reg.vcd");
    $dumpvars();
end
    

initial
begin
    // Reset test
    rst_n = 0;
    #(PERIOD * 2);
    rst_n = 1;

    // Test 1: Write to pc_new after reset
    pc_new = 32'h00000010;
    #(PERIOD);
    pc_new = 32'h00000020;
    #(PERIOD);

    // Test 2: Check reset functionality again
    rst_n = 0;
    #(PERIOD);
    rst_n = 1;

    // Test 3: Check if pc_new changes are reflected in pc_out
    pc_new = 32'h00000030;
    #(PERIOD);
    pc_new = 32'h00000040;
    #(PERIOD);
    pc_new = 32'h00000050;
    #(PERIOD);
    $finish;
end

endmodule
