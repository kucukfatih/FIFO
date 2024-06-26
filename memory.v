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


module memory#(parameter fwft_enable = 1,parameter width = 16, parameter depth = 8,parameter adr_width = $clog2(depth))(

    
    input wire [width-1:0] data_in,
    input wire [adr_width-1:0] w_adr,
    input wire [adr_width-1:0] r_adr,
    input wire load,
    input wire read,
    input wire clk,
    output reg [width-1:0]data_out

    );
    
    (* ram_style = "block" *)  reg [width-1:0] mem [depth-1:0];
    
    always @(posedge clk) begin
        if(load)
            mem[w_adr] <= data_in;
        else
            mem[w_adr] <= mem[w_adr];
    end
     always @(posedge clk) begin
        if(fwft_enable) begin
        
            data_out <= mem[r_adr];
        
        end
        else begin
            if(read)
                data_out <= mem[r_adr];
            else
                data_out <= data_out;
         end

    end
    
endmodule
