`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2024 22:54:57
// Design Name: 
// Module Name: comp
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


module comp#(parameter K = 4)(

input wire [K-1:0] A,B,
output wire equal_flag_empty,
output wire equal_flag_empty_fwft,
output wire equal_flag_full,
output wire not_equal_flag

    );
    
assign equal_flag_empty = (A == B) ? 1'b1 : 1'b0;

assign equal_flag_empty_fwft = (A == (B-1)) ? 1'b1 : 1'b0;

assign equal_flag_full = (A[K-2:0] == B[K-2:0]) ? 1'b1 : 1'b0;

assign not_equal_flag = (A[K-1] != B[K-1]) ? 1'b1 : 1'b0;



endmodule
