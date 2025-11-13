//~ `New testbench
`timescale  1ns / 1ps
`include "../define.v"
module tb_main_control;

// main_control Parameters
parameter PERIOD  = 10;


// main_control Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   [6:0]  opcode                        = 0 ;
reg   [2:0]  func3                         = 0 ;

// main_control Outputs
wire  MemRead                              ;
wire  MemtoReg                             ;
wire  [1:0]  ALUop                         ;
wire  MemWrite                             ;
wire  ALUSrc                               ;
wire  RegWrite                             ;
wire  beq                                  ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

main_control  u_main_control (
    .clk                     ( clk             ),
    .rst_n                   ( rst_n           ),
    .opcode                  ( opcode    [6:0] ),
    .func3                   ( func3     [2:0] ),

    .MemRead                 ( MemRead         ),
    .MemtoReg                ( MemtoReg        ),
    .ALUop                   ( ALUop     [1:0] ),
    .MemWrite                ( MemWrite        ),
    .ALUSrc                  ( ALUSrc          ),
    .RegWrite                ( RegWrite        ),
    .beq                     ( beq             )
);

initial
begin
    $dumpfile("main_control.vcd");
    $dumpvars();
end
    

initial
begin
    // Reset signal
    rst_n = 0;
    #(PERIOD);
    rst_n = 1;

    // Test 1: R-type instruction
    opcode = `R_type;
    func3 = 3'b000;
    #(PERIOD);
    
    // Test 2: I-type instruction (e.g., immediate ALU operations)
    opcode = `I_type;
    func3 = 3'b000;
    #(PERIOD);

    // Test 3: Load instruction
    opcode = `load;
    func3 = 3'b000;
    #(PERIOD);

    // Test 4: Store instruction
    opcode = `store;
    func3 = 3'b000;
    #(PERIOD);

    // Test 5: Branch instruction (BEQ)
    opcode = `B_type;
    func3 = 3'b000; // BEQ condition
    #(PERIOD);

    // Test 6: Branch instruction (other branch types)
    opcode = `B_type;
    func3 = 3'b001; // Other branch condition
    #(PERIOD);
    $finish;
end

endmodule
