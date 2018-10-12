`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2018 05:53:42 PM
// Design Name: 
// Module Name: pitch_shift_realtime_v3
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


module pitch_shift_realtime_v3(
    input CLK,
    input [3:0] pitch,
    input [11:0]MIC_in,
    output reg [11:0]realtime_out=0
    );
    parameter [20:0] intervals = 2;/////
    reg [20:0]a=0;
    reg [11:0]memory [0:intervals-1];/////
    reg [20:0]i = 1; 
    reg [20:0]j = 0; //(no spacing btw i and j)
    
    initial begin
        for (a=0; a<intervals; a=a+1) begin
            memory[a]=0; 
        end
    end
    
    wire [31:0]time_delay;
    assign time_delay = 1000000000/40000*intervals;
    
    wire clk_write, clk_read;
    wire [2:0]x_write, x_read;
    pitch_delay_clk_v2 clkx_adjuster(CLK,pitch,time_delay,intervals+4,clk_write,clk_read,x_write,x_read);
      
    always @(posedge clk_write) begin // writing into memory
        memory [i] = MIC_in;  ////(changed all to blocking assignment)
        i <=(i+1)%intervals;
    end
    always @(posedge clk_read) begin //reading memory sound out to speaker
        realtime_out = memory [j];
        j <=(j+1)%intervals;
    end
endmodule
