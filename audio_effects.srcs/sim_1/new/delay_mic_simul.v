`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2018 02:47:25 PM
// Design Name: 
// Module Name: delay_mic_simul
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


module delay_mic_simul(

    );
    reg CLK;
    reg [31:0]time_delay;
    reg [11:0]MIC_in;
    wire [11:0]speaker_out;
    
//    input CLK,
//        input [3:0]time_delay_count,
//        input [3:0] pitch, //////////////////////implement pitch
//        input [11:0]MIC_in,
//        wire [11:0]delay_out=0
    
    delay_mic dut(CLK, time_delay_count, pitch,MIC_in,delay_out);
    
    always begin
        #5 CLK=~CLK;
    end
    initial begin
        CLK=0; time_delay = 100;
        MIC_in=12;
        #150 MIC_in=9;
        #125 MIC_in=1;
        #125 MIC_in=2;
        #125 MIC_in=3;
        #125 MIC_in=4;
        #125 MIC_in=5;
        #125 MIC_in=6;
        #125 MIC_in=7;
        #125 MIC_in=8;
        $finish;
    end
endmodule
