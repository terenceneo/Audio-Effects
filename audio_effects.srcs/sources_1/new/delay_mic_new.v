`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2018 04:27:39 PM
// Design Name: 
// Module Name: delay_mic_new
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


module delay_mic_new(
    input CLK,
    input [31:0]time_delay,
    input [11:0]MIC_in,
    output reg [11:0]delay_out=0
    );
    parameter [20:0] intervals = 25004;/////
    reg [20:0]a=0;
    reg [11:0]memory [0:intervals-1];/////
    reg [20:0]i = 0; 
    reg [20:0]j = 4; //(added spacing btw i and j)
    wire [31:0]period;
    
    initial begin
        for (a=0; a<intervals; a=a+1) begin
            memory[a]=0; 
        end
    end
    
    wire clk_write, clk_read; 
//    assign time_delay = time_delay_count*1000000000;
    assign period = time_delay/(intervals-4);//// //(minus 4 from interval)
    slowclock writeclk(CLK,period,clk_write); 
//    slowclock readclk(CLK,period,clk_read);

    always @(posedge clk_write) begin // writing into memory
        memory [i] = MIC_in;  ////(changed all to blocking assignment)
        i =(i+1)%intervals; ///intervals-1
//    end
//    always @(posedge clk_read) begin //reading memory sound out to speaker
        delay_out = memory [j];
        j =(j+1)%intervals;
    end
endmodule
