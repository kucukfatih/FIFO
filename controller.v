`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2024 13:56:11
// Design Name: 
// Module Name: controller
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


module controller(

    input wire clk,
    input wire rst,
    input wire we,
    input wire re,
    input wire [1:0] status_signals,
    output reg [4:0] control_signals,
    output reg fifo_full,
    output reg done

    );
    
    reg [2:0] state,next_state;
    
    parameter state_0 = 3'b000;
    parameter state_1 = 3'b001;
    parameter state_2 = 3'b010;
    parameter state_3 = 3'b011;
    parameter state_4 = 3'b100;
    
    
    always @(posedge clk,posedge rst) begin
        
        if(rst)
            state <= state_0;
        else 
            state <= next_state;
    end
    
    always @(state,we,re,status_signals) begin
    
    case(state)
        
        state_0: next_state <= state_1;
        state_1: begin
            if(we)
                next_state <= state_2;
            else
                next_state <= state_1;
        end
        state_2:begin
            if(status_signals[0])
                next_state <= state_3;
            else
                next_state <= state_1;
        end
        state_3:begin
            if(re)
                next_state <= state_4;
            else
                next_state <= state_3;
        end
        state_4:begin
            if(status_signals[1])
                next_state <= state_0;
            else
                next_state <= state_3;
        end
        default: next_state <= state_0;
    endcase 
    end
    
    always @(state,we,re,status_signals) begin
    
    case(state)
        state_0: control_signals <= 5'b00100;
        state_1: begin
            if(we)
                control_signals <= 5'b10001;
            else
                control_signals <= 5'b00000;
        end
        state_2:begin
            if(status_signals[0])
                control_signals <= 5'b00000;
            else
                control_signals <= 5'b00000;
        end
        state_3:begin
            if(re)
                control_signals <= 5'b01010;
            else
                control_signals <= 5'b00000;
        end
        state_4:begin
            if(status_signals[1])
                control_signals <= 5'b00000;
            else
                control_signals <= 5'b00000;
        end
        default: control_signals <= 5'b00000;
    endcase
    end 
    
    always @(state,re,status_signals) begin
    
    case(state)
        state_2: begin
            if(status_signals[0])
                fifo_full <= 1'b1;
            else
                fifo_full <= 1'b0;
         end
         state_3: begin
            if(re)
                fifo_full <= 1'b0;
            else
                fifo_full <= 1'b1;
         end
         default: fifo_full <= 1'b0;
    endcase
    end
    
    always @(state,status_signals) begin
    
    case(state)
        state_4: begin
            if(status_signals[1])
                done <= 1'b1;
            else
                done <= 1'b0;
         end
       
         default: done <= 1'b0;
    endcase
    end
        
    
    
endmodule
