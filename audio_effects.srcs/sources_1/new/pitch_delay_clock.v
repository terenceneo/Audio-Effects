`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2018 04:25:45 PM
// Design Name: 
// Module Name: pitch_delay_clock
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


module pitch_delay_clock(
    input CLK,
    input [3:0]pitch,
//    input [3:0]time_delay_count, ///time_delay_count
    input [31:0]time_delay,
    input [20:0]intervals,
    output reg clk_write,
    output reg clk_read,
    output reg [2:0]x_write,
    output reg [2:0]x_read
    );
    //calculation of clocks period
//    wire [31:0]time_delay; ///time_delay_count
    wire [31:0]period;
//    assign time_delay = time_delay_count*1000000000; ///time_delay_count
//    assign period = time_delay/(intervals-4);//// //(minus 2 from interval) //for implementation
    assign period = 300; //for simulation purposes    
    wire clk_0, clk_2, clk_4;
    slowclock clk0(CLK,period,clk_0);
//    slowclock clk2(CLK,period*6/5,clk_2); //1.2 times slower
//    slowclock clk4(CLK,period*3/2,clk_4); //1.5 times slower
    slowclock clk2(CLK,period/3,clk_2); //1.2 times slower
    slowclock clk4(CLK,period/5,clk_4); //1.5 times slower
    
    wire [2:0] x_clk0, x_clk2, x_clk4;
    assign x_clk0 = 1;
//    assign x_clk2 = 6;
//    assign x_clk4 = 3;
    assign x_clk2 = 3;
    assign x_clk4 = 5;
    
    //creating library of clk and x
    always @(*) begin
        case(pitch)
        0: begin
            clk_write <= clk_0;
            clk_read <= clk_0;
            x_write <= x_clk0;
            x_read <= x_clk0;
        end
        1: begin
            clk_write <= clk_0;
            clk_read <= clk_2;
            x_write <= x_clk0;
            x_read <= x_clk2;
        end
        2: begin
            clk_write <= clk_0;
            clk_read <= clk_4;
            x_write <= x_clk0;
            x_read <= x_clk4;
        end
        3: begin
            clk_write <= clk_2;
            clk_read <= clk_0;
            x_write <= x_clk2;
            x_read <= x_clk0;
        end
        4: begin
            clk_write <= clk_4;
            clk_read <= clk_0;
            x_write <= x_clk4;
            x_read <= x_clk0;
        end
        endcase
    end
endmodule
