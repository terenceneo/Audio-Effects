`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2018 08:00:40 AM
// Design Name: 
// Module Name: seven_segment_test
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


module seven_segment_test(
    input CLK,
    input btnU,					
    input btnL,
    input btnR,
    input btnD,
    input btnC,
    output [0:6] seg,
    output [0:3] an,
    output [3:0] led
//    output sp_plus
    );
    wire [3:0] segment_in1, segment_in2, segment_inw;
    slowclock clkcounter(CLK,250000000,clk_counter);
    manual_counter count_test1(clk_counter,btnR,btnC,5,segment_in1);
    manual_counter count_test2(clk_counter,btnU,btnL,7,segment_in2);
    assign led = segment_in2;
    assign segment_inw = (btnU)?12: segment_in1;
    seven_segment seg1(CLK,segment_inw,segment_in2,3,7,seg,an);
endmodule
