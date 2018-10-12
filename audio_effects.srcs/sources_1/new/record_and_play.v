`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2018 03:31:26 PM
// Design Name: 
// Module Name: record_and_play
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


module record_and_play(
    input CLK,
    input [31:0]record_time,
    input [11:0]MIC_in,
    input [3:0] time_delay_count, //goes from 0 to 1
    input btn,
    input sw,
    input record_on,
    output reg [11:0]play_out=0
    );
    parameter [13:0] intervals = 20000;///// must be multiple of 6
    reg [13:0]a=0 ; //same length as intervals
    reg [11:0]memory [0:intervals-1];/////
    reg [13:0]i = 0; //same length as intervals
    reg [13:0]j = 0; //same length as intervals
    wire [31:0]period_write, period_read;
    wire clk_write, clk_read;
    
    initial begin
    for (a=0; a<intervals; a=a+1) begin
        memory[a]=0; 
    end
    end
    
    assign period_write = record_time/intervals;////
    assign period_read = (time_delay_count==1)? period_write*2: period_write;
    slowclock writeclk(CLK,period_write,clk_write); 
    slowclock readclk(CLK,period_read,clk_read);
    
    always @(posedge clk_write) begin // reading in to memory on btn press
        if(btn & record_on) begin
            memory [i] <= MIC_in;
            i <= (i==intervals-1)? 0:i+1; ///intervals-1
        end
    end
    always @(posedge clk_read) begin //playing sound out to speaker on sw on
        if(sw) begin
            play_out <= memory [j];
            j <= (j==intervals-1)? 0:j+1; ///intervals-1
        end
    end
endmodule
