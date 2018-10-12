`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2018 08:45:25 PM
// Design Name: 
// Module Name: manual_counter_simul
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


module manual_counter_simul(

    );
    reg btnR;
    reg btnL;
    reg btn_reset;
    reg slowclock;
    wire [3:0]led;
    manual_counter dut(slowclock,btnR,btnL,btn_reset,led);
    
    always begin
        #5 slowclock = ~slowclock;
    end
    initial begin
        slowclock=0; btnL=0; btnR=0; btn_reset=0;
        #25 btnR =1;
        #25 btnR =0;
        #25 btnR =1;
        #25 btnR =0;
        #25 btnR =1;
        #25 btnR =0;
        #25 btnL =1;
        #25 btnL =0;
        #25 btnL =1;
        #25 btnL =0;
        #25 btnL =1;
        btnR =1; //[ress 2 buttons at the same time
        #25 btnL =0;
        #25 btnL =1;
        #25 btn_reset=1;
        #25 $finish;
    end
endmodule
