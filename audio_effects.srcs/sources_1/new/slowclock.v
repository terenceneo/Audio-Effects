`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2018 03:23:55 PM
// Design Name: 
// Module Name: slowclock
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


module slowclock(
    input CLOCK,
    input [31:0] period,
    output reg SLOWCLOCK=0
    );
    wire [31:0] m = ((period / 20) == 0)? 1: period / 20;
    reg [31:0] count =  1;
    reg f1=0;
    reg f2=0;
    always @(posedge CLOCK) begin
        count<=(count>=m)? 1: count+1;
        SLOWCLOCK<=(count==1)? ~SLOWCLOCK: SLOWCLOCK;
    end
//    always @(CLOCK) begin
//        count<=(count==m)? 1: count+1;
//        SLOWCLOCK<=(count==1)? ~SLOWCLOCK: SLOWCLOCK;
//    end
//    always @(posedge CLOCK) begin
//        //f1 =1;
//    end
////    always @(negedge CLOCK) begin
////        f2 =1;
////    end
//    always @(f1, f2) begin
//        if(f1 | f2) begin
//            count<=(count==m)? 1: count+1;
//            SLOWCLOCK<=(count==1)? ~SLOWCLOCK: SLOWCLOCK;
//            f1=0;
//            f2=0;
//        end
//    end
endmodule
