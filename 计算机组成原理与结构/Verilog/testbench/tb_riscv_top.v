
`timescale  1ns / 1ps
module tb_riscv_top;

// riscv_top Parameters
parameter PERIOD  = 10;


// riscv_top Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;

// riscv_top Outputs
wire  [7:0]  rom_addr                          ;


reg [31:0]ram_addr;
reg [31:0]instr;
reg [31:0]Rd_mem_data;
reg [31:0]Wr_mem_data;
reg W_en=0;
reg R_en=0;
// reg [31:0] regs[31:0];


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

riscv_top  u_riscv_top (
    .clk                     ( clk             ),
    .rst_n                   ( rst_n           ),

    .rom_addr                ( rom_addr  [7:0] )
);

// Reset signal
initial begin
    u_riscv_top.data_memory_inst.ram[0] = 5;
    u_riscv_top.data_memory_inst.ram[1] = 3;
    u_riscv_top.data_memory_inst.ram[2] = 8;
    u_riscv_top.data_memory_inst.ram[3] = 1;
    u_riscv_top.data_memory_inst.ram[4] = 7;
    $readmemb("D:/Material/SingleRoundCPU/SingleRoundCPU.srcs/sources_1/new/rom_binary_file.txt",u_riscv_top.instr_memory_inst.rom,0,16);
    assign ram_addr = u_riscv_top.ram_addr;
    assign instr = u_riscv_top.instr;
    assign Rd_mem_data = u_riscv_top.Rd_mem_data;
    assign Wr_mem_data = u_riscv_top.Wr_mem_data;
    assign W_en = u_riscv_top.W_en;
    assign R_en = u_riscv_top.R_en;
    // assign regs = u_riscv_top.riscv_inst.datapath_inst.registers_inst.regs;
    $monitor("Time: %t | Reset: %b | ROM Addr: %h | RAM Addr: %d | Instr: %h | Rd_mem_data: %h | Wr_mem_data: %h | W_en: %b | R_en: %b|Rd :%d|Rd_data :%d|Wr_data :%d",
                $time, rst_n, rom_addr, ram_addr, instr, Rd_mem_data, Wr_mem_data, W_en, R_en,instr[11:7],u_riscv_top.riscv_inst.datapath_inst.registers_inst.regs[instr[11:7]],u_riscv_top.riscv_inst.datapath_inst.registers_inst.Wr_data);
end

initial
begin
    #950;
    $finish;
end

endmodule
