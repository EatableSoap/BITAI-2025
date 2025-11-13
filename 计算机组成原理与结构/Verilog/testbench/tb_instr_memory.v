//~ `New testbench
// `include"instr_memory.v"

`timescale  1ns / 1ps

module tb_instr_memory;

// instr_memory Parameters
parameter PERIOD  = 10;


// instr_memory Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   [7:0]  addr                          = 0 ;

// instr_memory Outputs
wire  [31:0]  instr                        ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

instr_memory  u_instr_memory (
    .clk                     ( clk           ),
    .rst_n                   ( rst_n         ),
    .addr                    ( addr   [7:0]  ),

    .instr                   ( instr  [31:0] )
);

initial
begin
    $dumpfile("instr_memory.vcd");
    $dumpvars();
end
    

initial
begin
    // 初始化信号
    rst_n = 0;
    addr = 8'd0; // 地址从 0 开始

    // 复位
    #10 rst_n = 1;

    // 开始读取 ROM 的不同地址
    repeat (10) begin  // 假设我们读取前 10 个地址
        #10;
        $display("Address = %d, Instruction = %b", addr, instr);
        addr = addr + 1;   // 每次地址加 1
    end
    $finish;
end

endmodule
