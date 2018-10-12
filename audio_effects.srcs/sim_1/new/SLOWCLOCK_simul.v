`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2018 03:29:25 PM
// Design Name: 
// Module Name: SLOWCLOCK_simul
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


module SLOWCLOCK_simul(
    );
    reg CLOCK;
    reg [31:0] period;
    wire SLOWCLOCK;
    slowclock dut(CLOCK,period,SLOWCLOCK);
    always begin
        #5 CLOCK=~CLOCK;
    end
    initial begin
        CLOCK=0;
        period=32;
    end
endmodule
