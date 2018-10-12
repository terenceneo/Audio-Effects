`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2018 09:25:40 PM
// Design Name: 
// Module Name: test_bits
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


module test_bits(
    input [11:0]sw,
    input [11:0]sound_in,
    output reg [11:0]sound_out=0
    );
    integer i, j, k;    
    always @ (sw) begin
        j=0;
        for(i=0; i<12; i=i+1) begin //i max = length of switch selector
            if(sw[i]) begin
                sound_out[j] = sound_in[i];
                j = j+1;
            end  
        end   
        case(j)
        0: begin sound_out=0; end
        1: begin sound_out [11:1] = 0; end
        2: begin sound_out [11:2] = 0; end
        3: begin sound_out [11:3] = 0; end
        4: begin sound_out [11:4] = 0; end
        5: begin sound_out [11:5] = 0; end
        6: begin sound_out [11:6] = 0; end
        7: begin sound_out [11:7] = 0; end
        8: begin sound_out [11:8] = 0; end
        9: begin sound_out [11:9] = 0; end
        10: begin sound_out [11:10] = 0; end
        11: begin sound_out [11] = 0; end
        endcase
    end  
endmodule
