`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2018 04:45:44 PM
// Design Name: 
// Module Name: sound_merge
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


module sound_merge(
    input sound_selector0,
    input sound_selector1,
    input sound_selector2,
    input [0:6]sw,
    input song_on,
    input [11:0]sound0,
    input [11:0]sound1,
    input [11:0]sound2,
    input [11:0]sound_default,
    output [1:0] sounds_on,
    output reg [11:0]merged_sound=0
//    output reg led
    );
    
    parameter sounds_number = 3;
    wire [0:sounds_number-1] sound_selector;
    assign sound_selector[0] = sound_selector0;
    assign sound_selector[1] = sound_selector1;
    assign sound_selector[2] = sound_selector2; //biggest index = loudest
    assign sounds_on =  sound_selector[0]+sound_selector[1]+sound_selector[2];
    
    wire sound_default_selector = sw || song_on;
//    wire [11:0] speaker_out_library [0:sounds_number-1];
//    assign speaker_out_library[0] = sound1;
//    assign speaker_out_library[1] = sound2;
//    assign speaker_out_library[2] = sound3;
    
    integer i, j, k, a;    
    always @ (sound_selector, sound_default) begin
        merged_sound=0;
        if((sounds_on+sound_default_selector)<2) begin
            merged_sound =(sound_selector[2])?sound2: //biggest index at highest priority
                (sound_selector[1])?sound1:
                (sound_selector[0])?sound0:
                sound_default;
        end
        else begin
            j=0;
//            for(i=0; i<sounds_number; i=i+1) begin //i max = length of switch selector
                if(sound_default) begin
                    merged_sound[7] = sound_default[0];
                end
                else merged_sound[7] = 0;
                if(sound_selector[0]) begin
//                        merged_sound[j+9] = speaker_out_library[i][11];
//                        merged_sound[j+6] = speaker_out_library[i][10];
//                        merged_sound[j+3] = speaker_out_library[i][9];
//                        merged_sound[j+0] = speaker_out_library[i][8];
//                    for (a=0; a<10; a=a+3) begin
//                        merged_sound[j+a] = sound0[8+(a/3)];
//                    end
//                    merged_sound[j+8] = sound0[11];
//                    j = j+1;
                    merged_sound[8] = sound0[10];
//                    a=0;
                end
                else merged_sound[8] = 0;
                if(sound_selector[1]) begin
//                    for (a=0; a<10; a=a+3) begin
//                        merged_sound[j+a] = sound1[8+(a/3)];
//                    end
//                    merged_sound[j+8] = sound1[11];
//                    j = j+1;
                    merged_sound[9] = sound1[10];
//                    a=0;
                end
                else merged_sound[9] = 0;
                if(sound_selector[2]) begin
//                    for (a=0; a<10; a=a+3) begin
//                        merged_sound[j+a] = sound2[8+(a/3)];
//                    end
//                    merged_sound[j+8] = sound2[11];
//                    j = j+1;
                    merged_sound[10] = sound2[10];
//                    a=0;
                end
                else merged_sound[10] = 0;    
//            for (k=0; k<sounds_number; k=k+1) begin: reset  //k max = length of switch selector
//                merged_sound [k+j] = 0;
//                merged_sound [k+j+3] = 0;
//                merged_sound [k+j+6] = 0;
//                merged_sound [k+j+9] = 0;
//                if((k+j)>=sounds_number-1) begin disable reset; end
//            end
//            case(j)
//            0: begin merged_sound=0; end
//            1: begin
//                merged_sound [0+j] = 0;
//                merged_sound [0+j+3] = 0;
//                merged_sound [0+j+6] = 0;
//                merged_sound [0+j+9] = 0;
//                merged_sound [1+j] = 0;
//                merged_sound [1+j+3] = 0;
//                merged_sound [1+j+6] = 0;
//                merged_sound [1+j+9] = 0;
//                end
//            2: begin
//                merged_sound [0+j] = 0;
//                merged_sound [0+j+3] = 0;
//                merged_sound [0+j+6] = 0;
//                merged_sound [0+j+9] = 0;
//                end
//            endcase
        end
    end  
endmodule
