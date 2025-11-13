//~ `New testbench
`timescale  1ns / 1ps

module tb_mux;

// mux Parameters
parameter PERIOD  = 10;


// mux Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   selectBranch                         = 0 ;
reg   [31:0]  DataA                        = 0 ;
reg   [31:0]  DataB                        = 0 ;

// mux Outputs
wire  [31:0]  result                       ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

mux  u_mux (
    .clk                     ( clk                  ),
    .rst_n                   ( rst_n                ),
    .selectBranch            ( selectBranch         ),
    .DataA                   ( DataA         [31:0] ),
    .DataB                   ( DataB         [31:0] ),

    .result                  ( result        [31:0] )
);

initial
begin
    $dumpfile("mux.vcd");
    $dumpvars();
end
    

initial
begin
    DataA = "A";
    DataB = "B";
    selectBranch = 1'b0; //A
    #PERIOD
    $display("DataA is %s, DataB is %s, select branch is %b, result is %s",DataA,DataB,selectBranch,result);

    DataA = "Hello,";
    DataB = "World!";
    selectBranch = 1'b1; //B
    #PERIOD
    $display("DataA is %s, DataB is %s, select branch is %b, result is %s",DataA,DataB,selectBranch,result);
    $finish;
end

endmodule
