`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2018 03:38:26 PM
// Design Name: 
// Module Name: testpitch_delay_clk
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


module pitch_delay_clk_v2(
    input CLK,
    input [3:0]pitch,
    input [31:0]time_delay,
    input [20:0]intervals,
    output reg clk_write,
    output reg clk_read,
    output reg [2:0]x_write,
    output reg [2:0]x_read
    );
    //calculation of clocks period
    wire [31:0]period;
    assign period = time_delay/(intervals-4);//// //(minus 2 from interval) 
    wire clk_0, clk_1, clk_2, clk_3, clk_4;
    slowclock clk0(CLK,period,clk_0);
    slowclock clk1(CLK,period/2,clk_1);
    slowclock clk2(CLK,period/4,clk_2);
    slowclock clk3(CLK,period*3/2,clk_3); //1.2 times slower
    slowclock clk4(CLK,period*2,clk_4); //1.5 times slower
    
    wire [2:0] x_clk0, x_clk1, x_clk2, x_clk3, x_clk4;
    assign x_clk0 = 1;
    assign x_clk1 = 2;
    assign x_clk2 = 4;
    assign x_clk3 = 3/2;
    assign x_clk4 = 2;
    
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
            clk_read <= clk_1;
            x_write <= x_clk0;
            x_read <= x_clk1;
        end
        2: begin
            clk_write <= clk_0;
            clk_read <= clk_2;
            x_write <= x_clk0;
            x_read <= x_clk2;
        end
        3: begin
            clk_write <= clk_0;
            clk_read <= clk_3;
            x_write <= x_clk3;
            x_read <= x_clk0;
        end
        4: begin
            clk_write <= clk_0;
            clk_read <= clk_4;
            x_write <= x_clk4;
            x_read <= x_clk0;
        end
        endcase
    end
endmodule
