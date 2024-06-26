`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2024 15:54:51
// Design Name: 
// Module Name: counter
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


module counter#(parameter K = 4)(

    input clk,rst,en,
    output reg [K-1:0] cnt_out

    );
    
    always @(posedge clk,posedge rst) begin 
    
    if (rst) 
        cnt_out <= 0;
    else if(en) 
        cnt_out <= cnt_out + 1;
    else
        cnt_out <= cnt_out;
    
    end
endmodule
