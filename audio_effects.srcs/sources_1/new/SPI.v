`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Project Name: Audio Effects
// Module Name: SPI
// Description: 
//      This module converts serial MIC input into a 12-bit parallel register [11:0]sample.    
//
//      The audio input is sampled by PmodMIC3, the sampling rate of which is assigned to Pin 1 ChipSelect (cs).
//      The Analog-to-Digital Concertor (ADC) on PmodMIC3 converts the audio analog signal into a 16-bit digital form
//      (4-bit leading zeros + 12-bit voice data). The 16 bits are output at PmodMIC3 Pin 3 (MISO) in serial (bit-by-bit)
//      according to a serial clock (sclk) that is assigned to PmodMIC3 Pin 4.
//
//      This module first generates sclk which is to be fed into PmodMIC3 Pin 4. Meanwhile it reads the 16 bits individually
//      while they are available and joins them into a 16-bit register temp. [11:0] sample is the final output represents the
//      12-bit MIC input sample.
//      
// 
//////////////////////////////////////////////////////////////////////////////////

module SPI(
    input CLK,                  // 100MHz clock
    input cs,                   // sampling clock, 20kHz
    input MISO,                 // J_MIC3_Pin3, serial mic input
    output clk_samp,            // J_MIC3_Pin1
    output reg sclk,            // J_MIC3_Pin4, MIC3 serial clock
    output reg [11:0]sample     // 12-bit audio sample data
    );
    
    reg [11:0]count2 = 0;
    reg [15:0]temp = 0;
    
    initial begin
        sclk = 0;
    end
    
    assign clk_samp = cs;
    
    //Creating SPI clock signals
    always @ (posedge CLK) begin
        count2 <= (cs == 0) ? count2 + 1 : 0;
        sclk <= (count2 == 50 || count2 == 100 || count2 == 150 || count2 == 200 || count2 == 250 || count2 == 300 || count2 == 350 || count2 == 400 || count2 == 450 || count2 == 500 || count2 == 550 || count2 == 600 || count2 == 650 || count2 == 700 || count2 == 750 || count2 == 800 || count2 == 850 || count2 == 900 || count2 == 950 || count2 == 1000 ||count2 == 1050 || count2 == 1100 || count2 == 1150 || count2 == 1200 || count2 == 1250 || count2 == 1300 || count2 == 1350 || count2 == 1400 || count2 == 1450 || count2 == 1500 || count2 == 1550 || count2 == 1600) ?  ~sclk  : sclk ;
    end
    
    always @ (negedge sclk) begin
        temp <= temp<<1 | MISO;
    end

    always @ (posedge cs) begin
        sample <= temp[11:0];
    end
    
endmodule