`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2018 05:32:16 PM
// Design Name: 
// Module Name: sp
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


module single_pulse(
    input CLOCK,
    input btnC,
    output sp
    );
    wire q1, q2;
    dff dff1(CLOCK, btnC, q1);
    dff dff2(CLOCK, q1, q2);
    assign sp=q1&~q2;
endmodule