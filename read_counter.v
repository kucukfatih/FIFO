`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2024 11:28:25
// Design Name: 
// Module Name: read_counter
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


module read_counter#(parameter fwft = 1,parameter K = 4)(

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
