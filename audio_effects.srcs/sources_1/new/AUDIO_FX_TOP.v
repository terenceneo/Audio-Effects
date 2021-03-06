`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AY1718 Sem 2 EE2026 Project
// Project Name: Audio Effects
// Module Name: AUDIO_FX_TOP
// Team No.: 24
// Student Names: Neo Yu Yao Terence, Clive Yuan Yue Herng
// Matric No.: A0164651E, A0176830B
// Description: 
// 
// Work Distribution:
//////////////////////////////////////////////////////////////////////////////////

module AUDIO_FX_TOP(
    input CLK,            // 100MHz FPGA clock
    
    input  J_MIC3_Pin3,   // PmodMIC3 audio input data (serial)
    output J_MIC3_Pin1,   // PmodMIC3 chip select, 20kHz sampling clock
    output J_MIC3_Pin4,   // PmodMIC3 serial clock (generated by module SPI.v)
     
    output [15:0]led,
    output J_DA2_Pin1,    // PmodDA2 sampling clock (generated by module DA2RefComp.vhd)
    output J_DA2_Pin2,    // PmodDA2 Data_A, 12-bit speaker output (generated by module DA2RefComp.vhd)
    output J_DA2_Pin3,    // PmodDA2 Data_B, not used (generated by module DA2RefComp.vhd)
    output J_DA2_Pin4,     // PmodDA2 serial clock, 50MHz clock
    
    input [15:0]sw,
    
    input btnU,					
    input btnL,
    input btnR,
    input btnD,
    input btnC,
    
    output [0:6] seg,
    output [0:3] an
    );
    
    wire record_on = sw[14];
    wire mic_on = sw[15];
    
    wire sw_left, sw_right;
    assign sw_left = sw[12];
    assign sw_right = sw[11];
    
    wire filter_toggle = sw[13];
    
    wire sw_reset;
    assign sw_reset = record_on;
    
    //////////////////////////////////////////////////////////////////////////////////
    // Clock Divider Module: Generate necessary clocks from 100MHz FPGA CLK
    // Please create the clock divider module and instantiate it here.
    wire clk_20k;
    wire clk_50M;
    slowclock clk20k(CLK,50000,clk_20k);
    slowclock clk50M(CLK,20,clk_50M);
  
     //////////////////////////////////////////////////////////////////////////////////
     //SPI Module: Converting serial data into a 12-bit parallel register
     //Do not change the codes in this area
    wire [11:0]MIC_in;
    SPI u1 (CLK, clk_20k, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, MIC_in);
   
    /////////////////////////////////////////////////////////////////////////////////////
    // Real-time Audio Effect Features
    // Please create modules to implement different features and instantiate them here   
    
    // Adjustable delay function
    wire [3:0] time_delay_count;
    wire clk_counter;
    wire [3:0] max_time_count;
    assign max_time_count = (sw_left || sw_right)? 1: 4;
    slowclock clkcounter(CLK,100000000,clk_counter); //250000000
    manual_counter timedelay_adjuster(clk_counter,btnU,btnD,btnC,sw_reset,0,max_time_count,time_delay_count); //btnC resets the count to default setting of 0 = 0s delay, range from 0-4s delay
    
    wire [31:0]time_delay;
    assign time_delay = time_delay_count*1000000000;
    wire [11:0] delay_out;
    delay_mic_new delay1(CLK, time_delay, MIC_in, delay_out); //time_delay_count in s, defaults at 0s delay
    
    //Adjustable pitch shift function
    wire [3:0] pitch;
    manual_counter pitch_adjuster(clk_counter,btnR,btnL,btnC,sw_reset,0,4,pitch); //btnC resets the count to default setting of 0 = normal pitch, 5 levels (0-4) of pitch
        
    wire [11:0] realtime_out, pitch_delay_out;
    pitch_shift_realtime_v2 realtime1(CLK,pitch,MIC_in,realtime_out); //passing delayed signal through pitch shift
    pitch_shift_realtime_v2 delayedpitch1(CLK,pitch,delay_out,pitch_delay_out);
    
    wire [11:0] final_out;
    assign final_out = (time_delay==0)? realtime_out: pitch_delay_out;
    
    //Piano instrument
    wire vol = sw[7];
    wire song_on = sw[10];
    wire octave_up = btnU;
    wire octave_down = btnD;
    wire reset = btnC;
    wire [3:0] octave_count;
    wire [11:0] piano_out;
    wire [11:0] song_player_out;
    
    manual_counter mcpiano (clk_counter, octave_up, octave_down, reset, 0, 1, 5, octave_count);//CLK, btnU, btnD, btnC, sw_reset, min_count, max_count, led
    instruments piano (CLK, sw[6:0], vol, song_on, octave_count, piano_out);
    song_player play (CLK, song_on, song_player_out);
    
    wire [11:0]tone;
    assign tone = (song_on)? song_player_out: piano_out;
    
    //Recording and Playback function & Playback Time Extension function
    wire [11:0]play_out_u, play_out_l, play_out_r, play_out_d;
    record_and_play button_left(CLK,1000000000,MIC_in,time_delay_count,btnL,sw_left,record_on,play_out_l);
    record_and_play button_right(CLK,1000000000,MIC_in,time_delay_count,btnR,sw_right,record_on,play_out_r);

    //Pitch shift Playback function
    wire [11:0] pitch_play_out_l, pitch_play_out_r;
    pitch_shift_realtime_v2 playback_left(CLK,pitch,play_out_l,pitch_play_out_l);
    pitch_shift_realtime_v2 playback_right(CLK,pitch,play_out_r,pitch_play_out_r);
    
    
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////Assigning of outputs///////////////////////////////////////////////
    //assigning of audio outs to speaker_out
    //Sound Merging function
    wire [11:0] temp_speaker_out;
    wire [1:0] sounds_on;
    sound_merge merge1(sw_left,sw_right,mic_on,sw[6:0],song_on, pitch_play_out_l,pitch_play_out_r,final_out,tone, sounds_on,temp_speaker_out); ////biggest index = loudest, highest priority

    //Noise Filter function
    wire [11:0] speaker_out;
    wire [11:0] speaker_out1;
    assign speaker_out = (sounds_on<2 && filter_toggle)? temp_speaker_out[11:3]:
        (~sw_left & ~sw_right & ~mic_on)? tone:
        temp_speaker_out;
        
//    test_bits bits(sw[11:0],speaker_out1,speaker_out);
    
//     assign speaker_out = MIC_in;
//    assign led[11:0]=speaker_out;
//    assign led[11:0]=delay_out;
    
    //Lightshow function
    lightshow light1(CLK,btnC,btnU,btnD,btnL,btnR,sw,led);

    //Displaying levels on 7-segment
    wire [3:0] segment_in1;
    wire [3:0] segment_in2;
    wire [3:0] segment_in3;
    wire [3:0] segment_in4;
    assign segment_in1 = (record_on)? 10: //logic for what to display on seven segment
                        (sw_left | sw_right | mic_on)? time_delay_count:
                        13; 
    assign segment_in2 = (record_on)? 11: 
                        (sw_left | sw_right | mic_on)? pitch:
                        13;
    assign segment_in3 = (record_on)? 12:
                        (sounds_on<2 && filter_toggle && (sw[6:0]==0) && ~song_on)? 14: 
                        13;
    assign segment_in4 = (~sw_left & ~sw_right & ~mic_on)? octave_count: 13;
    
    seven_segment segmentout(CLK, segment_in1, segment_in2, segment_in3, segment_in4, seg, an);

    /////////////////////////////////////////////////////////////////////////////////////
    //DAC Module: Digital-to-Analog Conversion
    //Do not change the codes in this area        
      DA2RefComp u2(clk_50M, clk_20k, speaker_out, ,1'b0, J_DA2_Pin2, J_DA2_Pin3, J_DA2_Pin4, J_DA2_Pin1,);
        
  //////////////////////////////////////////////////////////////////////////////////

endmodule