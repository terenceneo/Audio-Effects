`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2018 03:38:53 PM
// Design Name: 
// Module Name: testpitch_shift_realtime
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


module pitch_shift_realtime_v2(
    input CLK,
    input [3:0] pitch,
    input [11:0]MIC_in,
    output [11:0]realtime_out
    );
    parameter [5:0] intervals = 36;/////
    reg [5:0]a=0;
    reg [11:0]memory_low [0:intervals-1];/////
//    reg [11:0]memory_high [0:intervals-1];/////
    reg [5:0]i = 0; 
    reg [5:0]j = 2; //(no spacing btw i and j)
    reg [11:0] temp_out;
    initial begin
        for (a=0; a<intervals; a=a+1) begin
            memory_low[a]=0; 
//            memory_high[a]=0; 
        end
    end
    
    wire [31:0]time_delay;
    assign time_delay = 1000000000/40000*intervals;
    
    wire clk_write, clk_read;
    wire [2:0]x_write, x_read;
    reg [5:0] write_count=0, read_count=0;
    
    pitch_delay_clk_v2 clkx_adjuster(CLK,pitch,time_delay,intervals+2,clk_write,clk_read,x_write,x_read);
    
    always @(posedge clk_write) begin // writing into memory
        case (pitch)
        0: begin
            memory_low [i] = MIC_in;
            i = (i+1)%intervals;
        end
        1: begin //read is 2* faster
            if (i<intervals/x_read) begin
                memory_low [i] = MIC_in;
                memory_low [i+intervals/x_read] = MIC_in;
                memory_low [i+2*intervals/x_read] = MIC_in;
                i = (i+1)%intervals;
            end
            else i = 0;
        end
        2: begin //read is 4* faster
            if (i<intervals/x_read) begin
                memory_low [i] = MIC_in;
                memory_low [i+intervals/x_read] = MIC_in;
                memory_low [i+2*intervals/x_read] = MIC_in;
                memory_low [i+3*intervals/x_read] = MIC_in;
                memory_low [i+4*intervals/x_read] = MIC_in;
                i = (i+1)%intervals;
            end
            else i = 0;
        end
        3: begin //write is faster
            memory_low [i] = MIC_in;
            i = (i+1)%intervals;
        end
        4: begin //write is faster
            memory_low [i] = MIC_in;
            i = (i+1)%intervals;
        end
        endcase
//        memory_high [i] = MIC_in; 
//        i <=(i+1)%intervals;
    end
    always @(posedge clk_read) begin //reading memory sound out to speaker
        case (pitch)
        0: begin
            temp_out = memory_low [j];
            j = (j+1)%intervals;
        end
        1: begin
            temp_out = memory_low [j];
            j = (j+1)%intervals;
        end
        2: begin
            temp_out = memory_low [j];
            j = (j+1)%intervals;
        end
        3: begin
            if (j<(24+2)) begin //intervals/x_write, but x_write=3/2 rounded off to integer
                temp_out = memory_low [j];
                j = (j+1)%intervals;
            end
            else j = 2;
        end
        4: begin
            if (j<(intervals/x_write+2)) begin
                temp_out = memory_low [j];
                j = (j+1)%intervals;
            end
            else j = 2;
        end
        endcase
    end
    assign realtime_out = (pitch==0)? MIC_in: temp_out;
endmodule
