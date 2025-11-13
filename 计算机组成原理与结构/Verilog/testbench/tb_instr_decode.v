//~ `New testbench
`timescale  1ns / 1ps

module tb_instr_decode;

// instr_decode Parameters
parameter PERIOD  = 10;


// instr_decode Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   [31:0]  instr                        = 0 ;

// instr_decode Outputs
wire  [6:0]  opcode                        ;
wire  [2:0]  func3                         ;
wire  func7                                ;
wire  [4:0]  Rs1                           ;
wire  [4:0]  Rs2                           ;
wire  [4:0]  Rd                            ;
wire  [31:0]  imme                         ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

instr_decode  u_instr_decode (
    .clk                     ( clk            ),
    .rst_n                   ( rst_n          ),
    .instr                   ( instr   [31:0] ),

    .opcode                  ( opcode  [6:0]  ),
    .func3                   ( func3   [2:0]  ),
    .func7                   ( func7          ),
    .Rs1                     ( Rs1     [4:0]  ),
    .Rs2                     ( Rs2     [4:0]  ),
    .Rd                      ( Rd      [4:0]  ),
    .imme                    ( imme    [31:0] )
);

initial
begin
    $dumpfile("instr_decode.vcd");
    $dumpvars();
end
    

initial
begin
    // Test Case 1: Load instruction (I-type format)
    instr = 32'b000000000001_00001_010_00010_0000011; // Example load instruction
    #PERIOD;
    $display("TC1 - Load instruction:");
    $display("opcode = %b, func3 = %b, func7 = %b, Rs1 = %b, Rs2 = %b, Rd = %b, imme = %d",
              opcode, func3, func7, Rs1, Rs2, Rd, imme);

    // Test Case 2: Branch instruction (B-type format)
    instr = 32'b0000000_00001_00010_001_00000_1100011; // Example branch instruction
    #PERIOD;
    $display("TC2 - Branch instruction:");
    $display("opcode = %b, func3 = %b, func7 = %b, Rs1 = %b, Rs2 = %b, Rd = %b, imme = %d",
              opcode, func3, func7, Rs1, Rs2, Rd, imme);

    // Test Case 3: Store instruction (S-type format)
    instr = 32'b0000000_00001_00010_010_00000_0100011; // Example store instruction
    #PERIOD;
    $display("TC3 - Store instruction:");
    $display("opcode = %b, func3 = %b, func7 = %b, Rs1 = %b, Rs2 = %b, Rd = %b, imme = %d",
              opcode, func3, func7, Rs1, Rs2, Rd, imme);
    $finish;
end

endmodule
