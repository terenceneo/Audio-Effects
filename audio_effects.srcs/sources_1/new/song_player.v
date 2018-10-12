`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2018 14:26:37
// Design Name: 
// Module Name: song_player
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


module song_player(
    input CLK,
    input song,
    output reg [11:0] speaker_out=0
    );
    slowclock scm (CLK, 250000000, SC);
    reg [6:0] song_time = 0;
    wire [22:0] note;
    
    slowclock C4 (CLK, 3822250, note[0]);
    slowclock D4 (CLK, 3405241, note[1]);
    slowclock E4 (CLK, 3033723, note[2]);
    slowclock F4 (CLK, 2863459, note[3]);
    slowclock G4 (CLK, 2551053, note[4]);
    slowclock A4 (CLK, 2272727, note[5]);
    slowclock B4 (CLK, 2024771, note[6]);
    
    slowclock C3 (CLK, 7644500, note[7]);
    slowclock D3 (CLK, 6810505, note[8]);
    slowclock E3 (CLK, 6067446, note[9]);
    slowclock F3 (CLK, 5726918, note[10]);
    slowclock G3 (CLK, 5102093, note[11]);
    slowclock A3 (CLK, 4545455, note[12]);
    slowclock B3 (CLK, 4049534, note[13]);
    
    slowclock C5 (CLK, 1911129, note[14]);
    slowclock D5 (CLK, 1702620, note[15]);
    slowclock E5 (CLK, 1516933, note[16]);
    slowclock F5 (CLK, 1431729, note[17]);
    slowclock G5 (CLK, 1259460, note[18]);
    slowclock A5 (CLK, 1136364, note[19]);
    slowclock B5 (CLK, 1012384, note[20]);
    slowclock Eb5 (CLK, 1607060, note[21]);
    slowclock Ab4 (CLK, 2407868, note[22]);
    
    always @ (posedge SC) begin
        if (song)
        song_time <= (song_time == 41)? 0 : song_time +1;
        else
        song_time=0;
    end
            
    always @ (*) begin
        if (song == 0) begin
            speaker_out <= 0;
        end
        else begin                
            if (song_time == 1)
                speaker_out <= note[16]; //E5
            else if (song_time == 2)
                speaker_out <= note[21]; //Eb5
            else if (song_time == 3)
                speaker_out <= note[16]; //E5
            else if (song_time == 4)
                speaker_out <= note[21]; //Eb5
            else if (song_time == 5)
                speaker_out <= note[16]; //E5
            else if (song_time == 6)
                speaker_out <= note[6]; //B4
            else if (song_time == 7)
                speaker_out <= note[15]; //D5
            else if (song_time == 8)
                speaker_out <= note[14]; //C5  
            else if (song_time == 9)
                speaker_out <= note[5]; //A4
            else if (song_time == 10)
                speaker_out <= note[5]; //A4
            else if (song_time == 11)
                speaker_out <= note[0]; //C4
            else if (song_time == 12)
                speaker_out <= note[2]; //E4            
            else if (song_time == 13)
                speaker_out <= note[5]; //A4
            else if (song_time == 14)
                speaker_out <= note[6]; //B4         
            else if (song_time == 15)
                speaker_out <= note[6]; //B4  
            else if (song_time == 16)
                speaker_out <= note[2]; //E4  
            else if (song_time == 17)
                speaker_out <= note[22]; //Ab4  
            else if (song_time == 18)
                speaker_out <= note[6]; //B4              
            else if (song_time == 19)
                speaker_out <= note[14]; //C5  
            else if (song_time == 20)
                speaker_out <= note[14]; //C5  
            else if (song_time == 21)
                speaker_out <= note[16]; //E5
            else if (song_time == 22)
                speaker_out <= note[21]; //Eb5
            else if (song_time == 23)
                speaker_out <= note[16]; //E5
            else if (song_time == 24)
                speaker_out <= note[21]; //Eb5
            else if (song_time == 25)
                speaker_out <= note[16]; //E5
            else if (song_time == 26)
                speaker_out <= note[6]; //B4
            else if (song_time == 27)
                speaker_out <= note[15]; //D5
            else if (song_time == 28)
                speaker_out <= note[14]; //C5  
            else if (song_time == 29)
                speaker_out <= note[5]; //A4
            else if (song_time == 30)
                speaker_out <= note[5]; //A4
            else if (song_time == 31)
                speaker_out <= note[0]; //C4
            else if (song_time == 32)
                speaker_out <= note[2]; //E4            
            else if (song_time == 33)
                speaker_out <= note[5]; //A4
            else if (song_time == 34)
                speaker_out <= note[6]; //B4         
            else if (song_time == 35)
                speaker_out <= note[6]; //B4  
            else if (song_time == 36)
                speaker_out <= note[2]; //E4            
            else if (song_time == 37)
                speaker_out <= note[14]; //C5             
            else if (song_time == 38)
                speaker_out <= note[6]; //B4 
            else if (song_time == 39)
                speaker_out <= note[5]; //A4 
            else if (song_time == 40)
                speaker_out <= note[5]; //A4 
            else 
                speaker_out <= 0; 
 
        end
    end
endmodule

//        else begin                
//            if (song_time == 1)
//                speaker_out <= note[2]; //E4
//            else if (song_time == 2)
//                speaker_out <= note[2]; //E4
//            else if (song_time == 3)
//                speaker_out <= note[3]; //F4
//            else if (song_time == 4)
//                speaker_out <= note[4]; //G4
//            else if (song_time == 5)
//                speaker_out <= note[4]; //G4
//            else if (song_time == 6)
//                speaker_out <= note[3]; //F4
//            else if (song_time == 7)
//                speaker_out <= note[2]; //E4
//            else if (song_time == 8)
//                speaker_out <= note[1]; //D4   
//            else if (song_time == 9)
//                speaker_out <= note[0]; //C4
//            else if (song_time == 10)
//                speaker_out <= note[0]; //C4        
//            else if (song_time == 11)
//                speaker_out <= note[1]; //D4
//            else if (song_time == 12)
//                speaker_out <= note[2]; //E4
//            else if (song_time == 13)
//                speaker_out <= note[2]; //E4            
//            else if (song_time == 14)
//                speaker_out <= note[1]; //D4
//            else if (song_time == 15)
//                speaker_out <= note[1]; //D4
//            else 
//                speaker_out <= 0; 
////            else if (song_time == 17)
////                    speaker_out <= 0; 
//        end