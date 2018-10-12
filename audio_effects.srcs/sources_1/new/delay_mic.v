`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2018 02:28:17 PM
// Design Name: 
// Module Name: delay_mic
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


module delay_mic(
    input CLK,
//    input [3:0]time_delay_count,
    input [31:0]time_delay,
    input [3:0] pitch, //////////////////////implement pitch
    input [11:0]MIC_in,
    output reg [11:0]delay_out=0
    );
    parameter [20:0] intervals = 40004;/////
    reg [20:0]a=0;
    reg [11:0]memory [0:intervals-1];/////
    reg [20:0]i = 0; 
    reg [20:0]j = 4; //(added spacing btw i and j)
//    wire [31:0] time_delay;
//    wire [31:0]period;
    
    initial begin
        for (a=0; a<intervals; a=a+1) begin
            memory[a]=0; 
        end
    end
    
    wire clk_write, clk_read;
    wire [2:0]x_write, x_read;
    pitch_delay_clock clkx_adjuster(CLK,pitch,time_delay,intervals,clk_write,clk_read,x_write,x_read);
    
//    assign time_delay = time_delay_count*1000000000;
//    assign period = time_delay/(intervals-2);//// //(minus 2 from interval)
//    slowclock writeclk(CLK,period,clk_write); 
//    slowclock readclk(CLK,period,clk_read);
    reg [2:0] write_count=0;
    reg [2:0] read_count=0;
    reg [2:0] writeloop_count=1;
    reg [2:0] readloop_count=1;
    wire [1:0] interval_length = 0;  
    always @(posedge clk_write) begin // writing into memory
//        memory [i] = MIC_in;  ////(changed all to blocking assignment)
//        i = (i==intervals-1)? 0: ///intervals-1
//            (x_write==1)? i+1: //add condition to delay mic
//            (i%x_write==0)? i+2: i+1; 
        memory [i] = MIC_in;  ////(changed all to blocking assignment)
        i <=(writeloop_count==x_write && write_count==interval_length)? (i+1+2*(x_write-1))%(intervals):
            (write_count==interval_length)? i-1:
            (i==intervals-1)? 0:
            i+1;
         write_count <= (write_count==interval_length)? 0:write_count+1;
         writeloop_count <= (write_count!=interval_length)?writeloop_count:
            (writeloop_count==x_write)? 1:
            writeloop_count+1;
    end
    always @(posedge clk_read) begin //reading memory sound out to speaker
//        delay_out = memory [j];
//        j = (j==intervals-1)? 0: ///intervals-1
//            (x_read==1)? j+1:
//            (j%x_read==0)? j+2: j+1;
        delay_out = memory [j];
        j <=(readloop_count==x_read && read_count==interval_length)? (j+1+2*(x_read-1))%(intervals):
            (read_count==interval_length)? j-1: 
            (j==intervals-1)? 0:
            j+1;
        read_count <= (read_count==interval_length)? 0:read_count+1;
        readloop_count <= (read_count!=interval_length)?readloop_count:
            (readloop_count==x_read)? 1:
            readloop_count+1;
    end
endmodule
