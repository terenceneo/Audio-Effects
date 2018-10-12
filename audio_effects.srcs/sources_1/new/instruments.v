`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2018 17:48:28
// Design Name: 
// Module Name: instruments
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


module instruments(
    input CLK,
    input [6:0] sw,
    input vol,
    input song,
    input [3:0] led,
    output reg [11:0] tone = 0
//    output reg led1=0
    ); 
  
    wire [27:0] note;
    wire [6:0] note1;
    
  
    slowclock C2 (CLK, 15289117, note[0]);
    slowclock D2 (CLK, 13621009, note[1]);
    slowclock E2 (CLK, 12134891, note[2]);
    slowclock F2 (CLK, 11453835, note[3]);
    slowclock G2 (CLK, 10204186, note[4]);
    slowclock A2 (CLK, 9090909, note[5]);
    slowclock B2 (CLK, 8099067, note[6]);

    slowclock C3 (CLK, 7644500, note[7]);
    slowclock D3 (CLK, 6810505, note[8]);
    slowclock E3 (CLK, 6067446, note[9]);
    slowclock F3 (CLK, 5726918, note[10]);
    slowclock G3 (CLK, 5102093, note[11]);
    slowclock A3 (CLK, 4545455, note[12]);
    slowclock B3 (CLK, 4049534, note[13]);

    slowclock C4 (CLK, 3822250, note[14]);
    slowclock D4 (CLK, 3405241, note[15]);
    slowclock E4 (CLK, 3033723, note[16]);
    slowclock F4 (CLK, 2863459, note[17]);
    slowclock G4 (CLK, 2551053, note[18]);
    slowclock A4 (CLK, 2272727, note[19]);
    slowclock B4 (CLK, 2024771, note[20]);

    slowclock C5 (CLK, 1911129, note[21]);
    slowclock D5 (CLK, 1702620, note[22]);
    slowclock E5 (CLK, 1516933, note[23]);
    slowclock F5 (CLK, 1431729, note[24]);
    slowclock G5 (CLK, 1259460, note[25]);
    slowclock A5 (CLK, 1136364, note[26]);
    slowclock B5 (CLK, 1012384, note[27]);
    
    slowclock C6 (CLK, 955564, note1[0]);
    slowclock D6 (CLK, 851311, note1[1]);
    slowclock E6 (CLK, 758432, note1[2]);
    slowclock F6 (CLK, 715864, note1[3]);
    slowclock G6 (CLK, 637762, note1[4]);
    slowclock A6 (CLK, 568182, note1[5]);
    slowclock B6 (CLK, 506193, note1[6]);       
    
//    slowclock scm (CLK, 500000000, SC);
    reg [3:0] j=0;
    reg [3:0] i=0;
    reg [3:0] k=0;
    reg [15:0] song_count = 0;
    reg [15:0] song_time = 0;
//    always @ (posedge CLK) begin

     
////            tone <= (song_count == 200000000)? note[16] :
////            (song_count == 400000000)? note[16] :
////            (song_count == 600000000)? note[17] : 0;
////        end
//    end
    always @ (posedge CLK) begin //S, led
            if (led == 1 && vol == 0) begin //c2-b2 octave
                for(i=0; i<7; i=i+1) begin
                    if(sw[i]) begin
                        tone[j] = note[i];
                        j = j+1;
                    end  
                end  
                case(j)
                0: tone[j]=0;
                1: begin
                    for (k=0; k<12-1; k=k+1) begin 
                        tone [k+1] = 0;
                    end
                end
                2: begin
                    for (k=0; k<12-2; k=k+1) begin  
                        tone [k+2] = 0;
                    end
                end
                3: begin
                    for (k=0; k<12-3; k=k+1) begin 
                        tone [k+3] = 0;
                    end
                end
                4: begin
                    for (k=0; k<12-4; k=k+1) begin  
                        tone [k+4] = 0;
                    end
                end
                5: begin
                    for (k=0; k<12-5; k=k+1) begin 
                        tone [k+5] = 0;
                    end
                end
                6: begin
                    for (k=0; k<12-6; k=k+1) begin  
                        tone [k+6] = 0;
                    end
                end
                endcase
                j=0;
            end//end c2-a2 octave
            else if (led == 2 && vol == 0) begin //c3-b3 octave
                for(i=0; i<7; i=i+1) begin
                    if(sw[i]) begin
                        tone[j] = note[i+7];
                        j = j+1;
                    end  
                end   
                case(j)
                0: tone[j]=0;
                1: begin
                    for (k=0; k<12-1; k=k+1) begin 
                        tone [k+1] = 0;
                    end
                end
                2: begin
                    for (k=0; k<12-2; k=k+1) begin  
                        tone [k+2] = 0;
                    end
                end
                3: begin
                    for (k=0; k<12-3; k=k+1) begin 
                        tone [k+3] = 0;
                    end
                end
                4: begin
                    for (k=0; k<12-4; k=k+1) begin  
                        tone [k+4] = 0;
                    end
                end
                5: begin
                    for (k=0; k<12-5; k=k+1) begin 
                        tone [k+5] = 0;
                    end
                end
                6: begin
                    for (k=0; k<12-6; k=k+1) begin  
                        tone [k+6] = 0;
                    end
                end
                endcase
                j=0;
            end//end c3-b3 octave
            else if (led == 3 && vol == 0) begin //c4-b4 octave
                for(i=0; i<7; i=i+1) begin
                    if(sw[i]) begin
                        tone[j] = note[i+14];
                        j = j+1;
                    end  
                end   
                case(j)
                0: tone[j]=0;
                1: begin
                    for (k=0; k<12-1; k=k+1) begin 
                        tone [k+1] = 0;
                    end
                end
                2: begin
                    for (k=0; k<12-2; k=k+1) begin  
                        tone [k+2] = 0;
                    end
                end
                3: begin
                    for (k=0; k<12-3; k=k+1) begin 
                        tone [k+3] = 0;
                    end
                end
                4: begin
                    for (k=0; k<12-4; k=k+1) begin  
                        tone [k+4] = 0;
                    end
                end
                5: begin
                    for (k=0; k<12-5; k=k+1) begin 
                        tone [k+5] = 0;
                    end
                end
                6: begin
                    for (k=0; k<12-6; k=k+1) begin  
                        tone [k+6] = 0;
                    end
                end
                endcase
                j=0;
            end//end c4-b4 octave
            else if (led == 4 && vol == 0) begin //c5-b5 octave
                for(i=0; i<7; i=i+1) begin
                    if(sw[i]) begin
                        tone[j] = note[i+21];
                        j = j+1;
                    end  
                end   
                case(j)
                0: tone[j]=0;
                1: begin
                    for (k=0; k<12-1; k=k+1) begin 
                        tone [k+1] = 0;
                    end
                end
                2: begin
                    for (k=0; k<12-2; k=k+1) begin  
                        tone [k+2] = 0;
                    end
                end
                3: begin
                    for (k=0; k<12-3; k=k+1) begin 
                        tone [k+3] = 0;
                    end
                end
                4: begin
                    for (k=0; k<12-4; k=k+1) begin  
                        tone [k+4] = 0;
                    end
                end
                5: begin
                    for (k=0; k<12-5; k=k+1) begin 
                        tone [k+5] = 0;
                    end
                end
                6: begin
                    for (k=0; k<12-6; k=k+1) begin  
                        tone [k+6] = 0;
                    end
                end
                endcase
                j=0;
            end//end c5-b5 octave            
            else if (led == 5 && vol == 0) begin //c6-b6 octave
                for(i=0; i<7; i=i+1) begin
                    if(sw[i]) begin
                        tone[j] = note1[i];
                        j = j+1;
                    end  
                end   
                case(j)
                0: tone[j]=0;
                1: begin
                    for (k=0; k<12-1; k=k+1) begin 
                        tone [k+1] = 0;
                    end
                end
                2: begin
                    for (k=0; k<12-2; k=k+1) begin  
                        tone [k+2] = 0;
                    end
                end
                3: begin
                    for (k=0; k<12-3; k=k+1) begin 
                        tone [k+3] = 0;
                    end
                end
                4: begin
                    for (k=0; k<12-4; k=k+1) begin  
                        tone [k+4] = 0;
                    end
                end
                5: begin
                    for (k=0; k<12-5; k=k+1) begin 
                        tone [k+5] = 0;
                    end
                end
                6: begin
                    for (k=0; k<12-6; k=k+1) begin  
                        tone [k+6] = 0;
                    end
                end
                endcase
                j=0;
            end//end c6-b6 octave
            
            /*volume increase*/
            if (led == 1 && vol == 1) begin //c2-b2 octave
                j=2;
                for(i=0; i<7; i=i+1) begin
                    if(sw[i]) begin
                        tone[j] = note[i];
                        j = j+1;
                    end  
                end   
                case(j)
                0: tone[j]=0;
                1: begin
                    for (k=0; k<12-1; k=k+1) begin 
                        tone [k+1] = 0;
                    end
                end
                2: begin
                    for (k=0; k<12-2; k=k+1) begin  
                        tone [k+2] = 0;
                    end
                end
                3: begin
                    for (k=0; k<12-3; k=k+1) begin 
                        tone [k+3] = 0;
                    end
                end
                4: begin
                    for (k=0; k<12-4; k=k+1) begin  
                        tone [k+4] = 0;
                    end
                end
                5: begin
                    for (k=0; k<12-5; k=k+1) begin 
                        tone [k+5] = 0;
                    end
                end
                6: begin
                    for (k=0; k<12-6; k=k+1) begin  
                        tone [k+6] = 0;
                    end
                end
                endcase
                j=0;
            end//end c2-a2 octave
            else if (led == 2 && vol == 1) begin //c3-b3 octave
                j=2;
                for(i=0; i<7; i=i+1) begin
                    if(sw[i]) begin
                        tone[j] = note[i+7];
                        j = j+1;
                    end  
                end   
                case(j)
                0: tone[j]=0;
                1: begin
                    for (k=0; k<12-1; k=k+1) begin 
                        tone [k+1] = 0;
                    end
                end
                2: begin
                    for (k=0; k<12-2; k=k+1) begin  
                        tone [k+2] = 0;
                    end
                end
                3: begin
                    for (k=0; k<12-3; k=k+1) begin 
                        tone [k+3] = 0;
                    end
                end
                4: begin
                    for (k=0; k<12-4; k=k+1) begin  
                        tone [k+4] = 0;
                    end
                end
                5: begin
                    for (k=0; k<12-5; k=k+1) begin 
                        tone [k+5] = 0;
                    end
                end
                6: begin
                    for (k=0; k<12-6; k=k+1) begin  
                        tone [k+6] = 0;
                    end
                end
                endcase
                j=0;
            end//end c3-b3 octave
            else if (led == 3 && vol == 1) begin //c4-b4 octave
                j=2;
                for(i=0; i<7; i=i+1) begin
                    if(sw[i]) begin
                        tone[j] = note[i+14];
                        j = j+1;
                    end  
                end   
                case(j)
                0: tone[j]=0;
                1: begin
                    for (k=0; k<12-1; k=k+1) begin 
                        tone [k+1] = 0;
                    end
                end
                2: begin
                    for (k=0; k<12-2; k=k+1) begin  
                        tone [k+2] = 0;
                    end
                end
                3: begin
                    for (k=0; k<12-3; k=k+1) begin 
                        tone [k+3] = 0;
                    end
                end
                4: begin
                    for (k=0; k<12-4; k=k+1) begin  
                        tone [k+4] = 0;
                    end
                end
                5: begin
                    for (k=0; k<12-5; k=k+1) begin 
                        tone [k+5] = 0;
                    end
                end
                6: begin
                    for (k=0; k<12-6; k=k+1) begin  
                        tone [k+6] = 0;
                    end
                end
                endcase
                j=0;
            end//end c4-b4 octave
            else if (led == 4 && vol == 1) begin //c5-b5 octave
                j=2;
                for(i=0; i<7; i=i+1) begin
                    if(sw[i]) begin
                        tone[j] = note[i+21];
                        j = j+1;
                    end  
                end   
                case(j)
                0: tone[j]=0;
                1: begin
                    for (k=0; k<12-1; k=k+1) begin 
                        tone [k+1] = 0;
                    end
                end
                2: begin
                    for (k=0; k<12-2; k=k+1) begin  
                        tone [k+2] = 0;
                    end
                end
                3: begin
                    for (k=0; k<12-3; k=k+1) begin 
                        tone [k+3] = 0;
                    end
                end
                4: begin
                    for (k=0; k<12-4; k=k+1) begin  
                        tone [k+4] = 0;
                    end
                end
                5: begin
                    for (k=0; k<12-5; k=k+1) begin 
                        tone [k+5] = 0;
                    end
                end
                6: begin
                    for (k=0; k<12-6; k=k+1) begin  
                        tone [k+6] = 0;
                    end
                end
                endcase
                j=0;
            end//end c5-b5 octave            
            else if (led == 5 && vol == 1) begin //c6-b6 octave
                j=2;
                for(i=0; i<7; i=i+1) begin
                    if(sw[i]) begin
                        tone[j] = note1[i];
                        j = j+1;
                    end  
                end   
                case(j)
                0: tone[j]=0;
                1: begin
                    for (k=0; k<12-1; k=k+1) begin 
                        tone [k+1] = 0;
                    end
                end
                2: begin
                    for (k=0; k<12-2; k=k+1) begin  
                        tone [k+2] = 0;
                    end
                end
                3: begin
                    for (k=0; k<12-3; k=k+1) begin 
                        tone [k+3] = 0;
                    end
                end
                4: begin
                    for (k=0; k<12-4; k=k+1) begin  
                        tone [k+4] = 0;
                    end
                end
                5: begin
                    for (k=0; k<12-5; k=k+1) begin 
                        tone [k+5] = 0;
                    end
                end
                6: begin
                    for (k=0; k<12-6; k=k+1) begin  
                        tone [k+6] = 0;
                    end
                end
                endcase
                j=0;
            end//end c6-b6 octave                
//            else if (song) begin //play a song with sw[8]
////                song_time <= (song_time == 5000)? 0: song_time <= song_time +1; //2hz
////                if (song_time == 0) begin
//////                    led1= 1;
//                    song_count <= (song_count == 100000000)? 0: song_count + 1; //plus 1 every 0.5s
//                    if (song_count == 33333333)
//                        tone[1] <= note[16]; //EEFGGFEDCCDEEDD
//                    else if (song_count == 66666666)
//                        tone[1] <= note[16];
//                    else if (song_count == 99999999)
//                        tone[1] <= note[17];
////                end
//            end
    end

endmodule
