`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2018 10:49:19 AM
// Design Name: 
// Module Name: pitch_shift_realtime
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


module pitch_shift_realtime(
    input CLK,
    input [3:0] pitch,
    input [11:0]MIC_in,
    output reg [11:0]realtime_out=0
    );
    parameter [20:0] intervals = 15;/////
    reg [3:0]a=0;
    reg [11:0]memory [0:intervals-1];/////
    reg [3:0]i = 0; 
    reg [3:0]j = 0; //(no spacing btw i and j)
    
    initial begin
        for (a=0; a<intervals; a=a+1) begin
            memory[a]=0; 
        end
    end
    
    wire [31:0]time_delay;
    assign time_delay = 1000000000/20000*intervals;
    
    wire clk_write, clk_read;
    wire [2:0]x_write, x_read;
    pitch_delay_clock clkx_adjuster(CLK,pitch,time_delay,intervals,clk_write,clk_read,x_write,x_read);
    
    reg [2:0] write_count=0;
    reg [2:0] read_count=0;
    reg [2:0] writeloop_count=1;
    reg [2:0] readloop_count=1;
    wire [1:0] interval_length = 1;   
    always @(posedge clk_write) begin // writing into memory
        memory [i] = MIC_in;  ////(changed all to blocking assignment)
        if(pitch<3)begin
            i <=(x_write==1)? (i+1)%intervals:
                (writeloop_count==x_write && write_count==interval_length)? (j+1)%intervals://(i+(interval_length-1)+(x_write-1))%(intervals):
                (write_count==interval_length)? i-interval_length:
    //            (x_write==1)? i+1:
    //            (i%x_write==0)? i+2:
                (i+1)%intervals;
             write_count <= (write_count==interval_length)? 0:write_count+1;
             writeloop_count <= (write_count!=interval_length)?writeloop_count:
                (writeloop_count==x_write)? 1:
                writeloop_count+1;
        end
        else i <= (i+1)%intervals;
    end
    always @(posedge clk_read) begin //reading memory sound out to speaker
        realtime_out = memory [j];
        if(pitch<3)begin
            j <=(x_read==1)? (j+1)%intervals:
                (readloop_count==x_read && read_count==interval_length)? i://(j+(interval_length-1)+(x_read-1))%(intervals):
                (read_count==interval_length)? j-interval_length: 
        //            (x_read==1)? j+1:
        //            (j%x_read==0)? j+2:
                (j+1)%intervals;
            read_count <= (read_count==interval_length)? 0:read_count+1;
            readloop_count <= (read_count!=interval_length)?readloop_count:
                (readloop_count==x_read)? 1:
                readloop_count+1;
        end
        else j <= i;
    end
endmodule
