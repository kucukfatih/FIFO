`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2024 11:31:21
// Design Name: 
// Module Name: FIFO
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


module FIFO#(parameter width = 16, parameter depth = 8,parameter adr_width = $clog2(depth))(

    input wire clk,
    input wire rst,
    input wire [width-1:0] data_in,
    input wire we,
    input wire re,
    output wire fifo_full,
    output wire fifo_empty,
    output wire [width-1:0] data_out

    );
    
    wire [2:0] status_signals_w;
    wire [4:0] control_signals_w;
    
    wire [adr_width:0] w_adr_w;
    wire [adr_width:0] r_adr_w;
    
    (*dont_touch = "true" *)
     
    controller con1(.clk(clk),
    .rst(rst),
    .we(we),
    .re(re),
    .status_signals(status_signals_w),
    .control_signals(control_signals_w),
    .fifo_full(fifo_full),
    .fifo_empty(fifo_empty));
    
    memory mem1(.data_in(data_in),
    .w_adr(w_adr_w[2:0]),
    .r_adr(r_adr_w[2:0]),
    .load(control_signals_w[4]),
    .read(control_signals_w[3]),
    .clk(clk),
    .data_out(data_out));
    
    comp adr_comp (.A(w_adr_w),
    .B(r_adr_w),
    .equal_flag_empty(status_signals_w[0]),
    .equal_flag_full(status_signals_w[1]),
    .not_equal_flag(status_signals_w[2]));
    
    counter w_cnt (.clk(clk),.en(control_signals_w[0]),
    .rst(control_signals_w[2]),
    .cnt_out(w_adr_w));
    
    counter r_cnt (.clk(clk),.en(control_signals_w[1]),
    .rst(control_signals_w[2]),
    .cnt_out(r_adr_w));
    
 
endmodule
