//~ `New testbench
// `include"data_memory.v"

`timescale  1ns / 1ps

module tb_data_memory;

// data_memory Parameters
parameter PERIOD  = 10;


// data_memory Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   W_en                                 = 0 ;
reg   R_en                                 = 0 ;
reg   [31:0]  addr                         = 0 ;
reg   [31:0]  din                          = 0 ;

// data_memory Outputs
wire  [31:0]  dout                         ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

data_memory  u_data_memory (
    .clk                     ( clk           ),
    .rst_n                   ( rst_n         ),
    .W_en                    ( W_en          ),
    .R_en                    ( R_en          ),
    .addr                    ( addr   [31:0] ),
    .din                     ( din    [31:0] ),

    .dout                    ( dout   [31:0] )
);

initial
begin
    $dumpfile("data_memory.vcd");
    $dumpvars();
end
    

initial
begin
    rst_n = 0;
    addr = 32'd0;
    W_en = 1;
    R_en = 0;
    din = 32'd0;
    #10 rst_n = 1;

    repeat (32) begin
        #10;
        din = din+1;
        addr = addr+4;
    end

    W_en = 0;
    R_en = 1;
    addr = addr-4;

    repeat (32) begin
      #10;
      $display("Address = %d, MemoryData = %d", addr, dout);
      addr = addr-4;
    end

    $finish;
end

endmodule
