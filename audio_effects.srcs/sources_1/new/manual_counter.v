`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2018 05:28:34 PM
// Design Name: 
// Module Name: manual_counter
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

module manual_counter( //starts at 3, range from 0 to 5
    input slowclock,
    input btn_plus,
    input btn_minus,
    input btn_reset,
    input sw_reset,
    input [3:0] min_count,
    input [3:0] max_count,
    output reg [3:0] led=3
    );
//    initial begin led=min_count; end
    wire sp_plus, sp_minus, sp_reset, reset;
    single_pulse pulse1(slowclock, btn_plus, sp_plus);
    single_pulse pulse2(slowclock, btn_minus, sp_minus);
    single_pulse pulse3(slowclock, btn_reset, sp_reset);
    assign reset = btn_reset | sw_reset;
    
    always @(posedge slowclock, posedge reset) begin //, sp_plus, posedge sp_minus
        if(reset) begin led=min_count; end
//        else if(sp_plus) begin
//            led = (led==(max_count))? 0: led+1;
//        end
        else if(sp_plus) begin
            led = (led==max_count)? led: led+1;
        end
        else if (sp_minus) begin
            led = (led==min_count)? led: led-1;
        end
    end
endmodule
//module manual_counter( //starts at 3, range from 0 to 5
//    input slowclock,
//    input btn_plus,
////    input btn_minus,
//    input btn_reset,
//    input sw_reset,
//    input [3:0] max_count,
//    output reg [3:0] led = 0
////    output sp_plus ///add back to wire
//    );
//    wire sp_plus, sp_minus, sp_reset, reset;
//    single_pulse pulse1(slowclock, btn_plus, sp_plus);
////    single_pulse pulse2(slowclock, btn_minus, sp_minus);
//    single_pulse pulse3(slowclock, btn_reset, sp_reset);
//    assign reset = sp_reset | sw_reset;
//    always @(posedge sp_plus, posedge reset) begin //, posedge sp_minus
//        led = (reset)? 0:
//            (sp_plus && led==(max_count))? 0:
//            (sp_plus)? led+1: led;
////        if(sp_reset | sw_hold) begin led=0; end
////        else if(sp_plus) begin
////            led = (led==(max_count))? 0: led+1;
////        end
////        else if (sp_minus) begin
////            led = (led==0)? led: led-1;
////        end
//    end
//endmodule