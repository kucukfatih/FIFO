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
    input wire [2:0] status_signals,
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
    
    always @(state,we,re,status_signals,fifo_full,fifo_empty) begin                  // status_signals = {not_equal_flag,equal_flag_full,equal_flag_empty}
                                                                // control_signals = {load_data,read_data,rst,r_adr_trigger,w_adr_trigger}
    case(state)
        state_0: control_signals <= 5'b00100;
        state_1: begin
            if((we==1&&re==1)&&(!fifo_full && !fifo_empty))     // load and read data (if fifo not full and not empty)
                control_signals <= 5'b11011;
            else if((we==1&&re==1)&& fifo_empty)                // load and read data (if fifo empty)
                control_signals <= 5'b10001; 
            else if((we==1&&re==1)&& fifo_full)                 // load and read data (if fifo full)
                control_signals <= 5'b01010;   
            else if((we==1&&re==0)&&(!fifo_full))               // load data
                control_signals <= 5'b10001; 
            else if((we==0&&re==1)&&(!fifo_empty))               // read data
                control_signals <= 5'b01010;
            else
                control_signals <= 5'b00000;
        end

        default: control_signals <= 5'b00000;
    endcase
    end 
    
    always @(*) begin
    
    case(state)
        state_0: begin
    
            fifo_full = 0;
            fifo_empty = 1;
        end
        
        default: begin
            fifo_full = (status_signals[2] && status_signals[1]);
            fifo_empty = status_signals[0] ;
        end
        
    endcase
    end

endmodule
