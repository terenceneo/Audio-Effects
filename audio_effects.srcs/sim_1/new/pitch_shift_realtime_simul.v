`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2018 11:36:03 AM
// Design Name: 
// Module Name: pitch_shift_realtime_simul
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


module pitch_shift_realtime_simul(

    );
    reg CLK;
    reg [3:0] pitch;
    reg [11:0]MIC_in;
    wire [11:0]realtime_out;
    pitch_shift_realtime dut(CLK,pitch,MIC_in,realtime_out);
    
    always begin
        #5 CLK = ~CLK;
    end
    initial begin
        CLK=0; MIC_in = 12'b111111111111; pitch=0;
        #2000 pitch = 1;
        #2000 pitch = 2;
        #2000 pitch = 3;
        #2000 pitch = 4;
        #2000 $finish;
    end
endmodule
