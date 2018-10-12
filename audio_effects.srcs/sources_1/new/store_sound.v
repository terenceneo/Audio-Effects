`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2018 03:23:07 PM
// Design Name: 
// Module Name: store_sound
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


module store_sound(
    input CLK, MIC_in,
    input btnU,
    output reg [11:0] stored_sound_u[0:45000-1]
    );
    reg [11:0]memory [0:45000-1];
    reg [20:0]a;
    
    record re(CLK,1000000000,MIC_in,memory);
    always begin
        if(btnU) begin
            for (a=0; a<45000; a=a+1) begin
                stored_sound_u[a]=memory[a]; 
            end
        end
    end
endmodule
