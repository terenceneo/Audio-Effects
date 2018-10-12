`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2018 02:41:40 PM
// Design Name: 
// Module Name: record
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


module record(
    input CLK,
    input [31:0]record_time,
    input [11:0]MIC_in,
    inout reg [11:0]memory [0:45000-1]
    );
    parameter [20:0] intervals = 45000;/////
    reg [20:0]a;
    
    reg [20:0]i = 0; 
    wire [31:0]period;
    wire clk_write;
    
    initial begin
    for (a=0; a<intervals; a=a+1) begin
        memory[a]=0; 
    end
    end
    
    assign period = record_time/intervals;////
    slowclock writeclk(CLK,period,clk_write);
    
    always @(posedge clk_write) begin // reading in to memory
        memory [i] <= MIC_in;
        i <= (i==intervals-1)? 0:i+1; ///intervals-1
    end
endmodule
