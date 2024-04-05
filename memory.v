`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2024 14:00:05
// Design Name: 
// Module Name: memory
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


module memory#(parameter width = 16, parameter depth = 8,parameter adr_width = 3)(

    
    input wire [width-1:0] data_in,
    input wire [adr_width-1:0] w_adr,
    input wire [adr_width-1:0] r_adr,
    input wire load,
    input wire read,
    output reg [width-1:0]data_out

    );
    
    reg [width-1:0] mem [depth-1:0];
    
    always @(posedge load) begin
    
            mem[w_adr] <= data_in;
        
    end
     always @(posedge read) begin
    
            data_out <= mem[r_adr];
        
    end
    
endmodule
