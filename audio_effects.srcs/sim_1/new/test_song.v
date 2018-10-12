`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2018 13:17:22
// Design Name: 
// Module Name: test_song
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


module test_song(

    );
    reg CLK;
    reg song;
    wire [11:0] speaker_out;
    
    song_player dut (CLK, song, speaker_out);
    
    always begin
        #5 CLK = ~CLK;
    end
    
    initial begin
        CLK = 0;
        song = 1;
    end
endmodule










