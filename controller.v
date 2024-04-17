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
    input wire [4:0] status_signals,
    output reg [4:0] control_signals,
    output reg fifo_full,
    output reg fifo_empty
    
    );
    
    reg [1:0] state,next_state;
    
    parameter state_0 = 2'b00;
    parameter state_1 = 2'b01;
    parameter state_2 = 2'b10;
    
   
    (*dont_touch = "true" *)
    
    
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
            if(we==0 && re==0)
                next_state <= state_1;
            else 
                next_state <= state_2;
        end
        state_2:begin
                next_state <= state_1;
        end

        default: next_state <= state_0;
    endcase 
    end
    
    always @(state,we,re,status_signals) begin // status_signals = {r_adr_equal,w_adr_equal}
                                               // control_signals = {load_data,read_data,rst,r_adr_trigger,w_adr_trigger}
    case(state)
        state_0: control_signals <= 5'b00100;
        state_1: begin
            if(we==1&&re==1)                    // load and read data 
                control_signals <= 5'b11011;  
            else if(we==1&&re==0)               // load data
                control_signals <= 5'b10001; 
            else if(we==0&&re==1)               // read data
                control_signals <= 5'b01010;
            else
                control_signals <= 5'b00000;
        end
        state_2:begin
            if(status_signals[0])
                control_signals <= 5'b00000;
            else
                control_signals <= 5'b00000;
        end

        default: control_signals <= 5'b00000;
    endcase
    end 
    
    always @(state,status_signals) begin
    
    case(state)

        state_2: begin
            if(status_signals[0]==1 && status_signals[3]==1)
                fifo_full <= 1'b1;
            else
                fifo_full <= 1'b0;
         end

         default: fifo_full <= 1'b0;
    endcase
    end
    
    always @(state,status_signals) begin
    
    case(state)
        state_0: fifo_empty <= 1'b1;
        state_1: begin
            if(status_signals[2]==1 && status_signals[1]==1)
                fifo_empty <= 1'b1;
            else if(status_signals[4])
                fifo_empty <= 1'b1;
            else
                fifo_empty <= 1'b0;
        end
        state_2: begin
            if(status_signals[2]==1 && status_signals[1]==1)
                fifo_empty <= 1'b1;
            else if(status_signals[4])
                fifo_empty <= 1'b1;
            else
                fifo_empty <= 1'b0;
        end

         default: fifo_empty <= 1'b0;
    endcase
    end
        
    
    
endmodule
