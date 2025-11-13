//~ `New testbench
`timescale  1ns / 1ps

module tb_registers;

// registers Parameters
parameter PERIOD  = 10;


// registers Inputs
reg   rst_n                                = 0 ;
reg   clk                                  = 0 ;
reg   W_en                                 = 0 ;
reg   [4:0]  Rs1                           = 0 ;
reg   [4:0]  Rs2                           = 0 ;
reg   [4:0]  Rd                            = 0 ;
reg   [31:0]  Wr_data                      = 0 ;

// registers Outputs
wire  [31:0]  Rd_data1                     ;
wire  [31:0]  Rd_data2                     ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

registers  u_registers (
    .rst_n                   ( rst_n            ),
    .clk                     ( clk              ),
    .W_en                    ( W_en             ),
    .Rs1                     ( Rs1       [4:0]  ),
    .Rs2                     ( Rs2       [4:0]  ),
    .Rd                      ( Rd        [4:0]  ),
    .Wr_data                 ( Wr_data   [31:0] ),

    .Rd_data1                ( Rd_data1  [31:0] ),
    .Rd_data2                ( Rd_data2  [31:0] )
);

initial
begin
    $dumpfile("registers.vcd");
    $dumpvars();
end
    

initial
begin
    // Reset and observe zero outputs
    rst_n = 0;
    W_en = 0;
    Wr_data = 0;
    #(PERIOD);
    rst_n = 1;

    // Test 1: Write to register 1 and read it back
    Rd = 5'd1;
    Wr_data = 32'hA5A5A5A5;
    W_en = 1;
    #(PERIOD);
    W_en = 0;

    Rs1 = 5'd1;
    Rs2 = 5'd2;
    #(PERIOD);

    // Test 2: Write to register 2 and read it back
    Rd = 5'd2;
    Wr_data = 32'h5A5A5A5A;
    W_en = 1;
    #(PERIOD);
    W_en = 0;

    Rs1 = 5'd2;
    #(PERIOD);

    // Test 3: Attempt to write to register 0 (should be ignored)
    Rd = 5'd0;
    Wr_data = 32'hFFFFFFFF;
    W_en = 1;
    #(PERIOD);
    W_en = 0;

    Rs1 = 5'd0;
    Rs2 = 5'd1;
    #(PERIOD);
    $finish;
end

endmodule
