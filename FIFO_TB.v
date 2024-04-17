`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2024 15:21:24
// Design Name: 
// Module Name: FIFO_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIFO_TB;

    parameter width = 16; 

    reg clk;
    reg rst;
    reg [width-1:0] data_in;
    reg we;
    reg re;
    wire fifo_full;
    wire fifo_empty;
    wire [width-1:0] data_out;
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    FIFO uut (.clk(clk),
    .rst(rst),
    .data_in(data_in),
    .we(we),
    .re(re),
    .fifo_full(fifo_full),
    .fifo_empty(fifo_empty),
    .data_out(data_out));
    
    
    
    initial begin 
    rst = 0;
    #5
    rst = 1;
    we = 0;
    re = 0;
    #5;
    rst = 0;
    we = 1;
    data_in = 16'd1;
    #20
    data_in = 16'd2;
    #20
    data_in = 16'd3;
    re = 1;
    #20
    data_in = 16'd4;
    #20
    data_in = 16'd5;
    #20
    data_in = 16'd6;
    re = 0;
    #20
    data_in = 16'd7;
    #20
    data_in = 16'd8;
    #20
    we = 0;
    re = 1;
    #265
    $finish;
    end
    
    
    
    
endmodule
