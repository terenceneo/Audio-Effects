`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2018 10:07:09 PM
// Design Name: 
// Module Name: seven_segment
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

//reference from http://www.fpga4student.com/2017/09/seven-segment-led-display-controller-basys3-fpga.html
module seven_segment(
    input CLK,
    input [3:0] segment_in1,
    input [3:0] segment_in2,
    input [3:0] segment_in3,
    input [3:0] segment_in4,
    output reg [0:6] seg,
    output reg [0:3] an
    );
    reg [1:0] counter;
    reg [3:0] segment_in;
    
    wire segment_clk;
    slowclock sclk(CLK,5000000,segment_clk);
    
    always @(posedge segment_clk) begin
        counter = counter+1;
    end
    always @(*) begin //determines which digit is on
        case(counter)
        2'b00: begin
            an <= 4'b0111; 
            segment_in <= segment_in4;
         end
        2'b01: begin
            an <= 4'b1011; 
            segment_in <= segment_in3;
        end
        2'b10: begin
            an <= 4'b1101;
            segment_in <= segment_in2; 
        end
        2'b11: begin
            an <= 4'b1110;
            segment_in <= segment_in1;
        end   
        default:begin
             an <= 4'b0111;
             segment_in <= segment_in4; 
        end
        endcase
    end
    always @(*) begin //library of the number on the on digit and their corresponding seg codes
        case(segment_in)
        4'b0000: seg = 7'b0000001; // "0"     
        4'b0001: seg = 7'b1001111; // "1" 
        4'b0010: seg = 7'b0010010; // "2" 
        4'b0011: seg = 7'b0000110; // "3" 
        4'b0100: seg = 7'b1001100; // "4" 
        4'b0101: seg = 7'b0100100; // "5" 
        4'b0110: seg = 7'b0100000; // "6" 
        4'b0111: seg = 7'b0001111; // "7" 
        4'b1000: seg = 7'b0000000; // "8"     
        4'b1001: seg = 7'b0000100; // "9" 
        10: seg = 7'b0001000; // "R"
        11: seg = 7'b0110000; // "E"
        12: seg = 7'b0110001; // "C"
        13: seg = 7'b1111111; // "blank"
        14: seg = 7'b0111000; // "F"
        default: seg = 7'b0000001; // "0"
        endcase
    end

endmodule
