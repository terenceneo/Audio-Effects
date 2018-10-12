`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2018 03:40:18 PM
// Design Name: 
// Module Name: lightshow
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


 module lightshow(
 
    //CLK Input
  input clk,

  //button input
  input btnC,
  input btnU,
  input btnD,
  input btnL,
  input btnR,

  //switch input     
  input [15:0] sw, 

 // LED output
  output reg [15:0] led = 1

);

 //main clock divider counter
 reg [10:0]  counter = 0;

 //loop counter for LED
 reg [10:0]  counter2 = 0;

 //loop counter for reading led_mem
 reg [10:0]  counter3 = 0;

 //array of current animation states for the 15 leds
 reg [15:0]  led_mem[15:0];

 //buffer for switch activation
 reg [15:0]  sw_mem =  0;

 //clock divider
 reg [30:0]  divider = 0;

 //stores frame of animation for each switch
 //3 bits reserved per position
 reg[48:0]   anim = 0;

 always @(posedge clk) begin

/*trigger animation on switch/button event*/
///////////////////////////////////////////
/*Buttons*/    
     if(btnC && sw_mem[7] == 0) begin
         sw_mem[7] = 1;
         if(anim[(7*3)+:3] == 0)   led_mem[7][7] = 1;
     end

     if(btnU && sw_mem[0] == 0) begin
         sw_mem[0] = 1;
         if(anim[(0*3)+:3] == 0)   led_mem[0][0] = 1;
     end

     if(btnR && sw_mem[5] == 0) begin
         sw_mem[5] = 1;
         if(anim[(5*3)+:3] == 0)   led_mem[5][5] = 1;
     end        

     if(btnL && sw_mem[10] == 0) begin
         sw_mem[10] = 1;
         if(anim[(10*3)+:3] == 0)   led_mem[10][10] = 1;
     end

     if(btnD && sw_mem[15] == 0) begin
         sw_mem[15] = 1;
         if(anim[(15*3)+:3] == 0)   led_mem[15][15] = 1;
     end
/*Switches*/
     if(sw[counter] == 1 && sw_mem[counter] == 0)    
     begin
         sw_mem[counter] = 1;
         if(anim[(counter*3)+:3] == 0)   led_mem[counter][counter] = 1;
     end

     if(sw[counter] == 0 && sw_mem[counter] == 1)    
     begin
         sw_mem[counter] = 0;
         if(anim[(counter*3)+:3] == 0)   led_mem[counter][counter] = 1;
     end
///////////////////////////////////////////

     //loop through memory array, set all LED's as per animated state
     led[counter] = led_mem[counter2][counter];


     //increment, reset counters
     if(counter<15)
     begin
         counter = counter +1;
     end
     else
     begin
         counter = 0;
         counter2 = counter2 +1;
     end

     if(counter2==16)    counter2 = 0;

/*perform animation*/
////////////////////////////////////////////////////////////////////////
     if(divider<300000)
     begin
         divider = divider +1;
     end
     else
     begin
         divider = 0;
         if(led_mem[counter3] > 0)
         begin
             //if frame is 0, increment frame until animation done
             if(anim[(counter3*3)+:3] == 0)
             begin
                 anim[(counter3*3)+:3] =  anim[(counter3*3)+:3] + 1;
             end
             else if(anim[(counter3*3)+:3] < 6)
             begin
                 //split activated led in two, bit shift to end of LED strip
                 led_mem[counter3] = (led_mem[counter3] >> 1) | (led_mem[counter3] << 1);
                 led_mem[counter3][counter3] = 1;
                 anim[(counter3*3)+:3] =  anim[(counter3*3)+:3] + 1;
             end
             else    
             begin

                 //cover all switch possibilities
                 if(counter3==0)
                 begin
                     led_mem[0][0] = 0;
                     led_mem[0][15:0] = led_mem[0][15:0] << 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==1)
                 begin
                     led_mem[1][1] = 0;
                     led_mem[1][15:1] = led_mem[1][15:1] << 1;
                     led_mem[1][1:0] = led_mem[1][1:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==2)
                 begin
                     led_mem[2][2] = 0;
                     led_mem[2][15:2] = led_mem[2][15:2] << 1;
                     led_mem[2][2:0] = led_mem[2][2:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==3)
                 begin
                     led_mem[3][3] = 0;
                     led_mem[3][15:3] = led_mem[3][15:3] << 1;
                     led_mem[3][3:0] = led_mem[3][3:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==4)
                 begin
                     led_mem[4][4] = 0;
                     led_mem[4][15:4] = led_mem[4][15:4] << 1;
                     led_mem[4][4:0] = led_mem[4][4:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==5)
                 begin
                     led_mem[5][5] = 0;
                     led_mem[5][15:5] = led_mem[5][15:5] << 1;
                     led_mem[5][5:0] = led_mem[5][5:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==6)
                 begin
                     led_mem[6][6] = 0;
                     led_mem[6][15:6] = led_mem[6][15:6] << 1;
                     led_mem[6][6:0] = led_mem[6][6:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==7)
                 begin
                     led_mem[7][7] = 0;
                     led_mem[7][15:7] = led_mem[7][15:7] << 1;
                     led_mem[7][7:0] = led_mem[7][7:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==8)
                 begin
                     led_mem[8][8] = 0;
                     led_mem[8][15:8] = led_mem[8][15:8] << 1;
                     led_mem[8][8:0] = led_mem[8][8:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==9)
                 begin
                     led_mem[9][9] = 0;
                     led_mem[9][15:9] = led_mem[9][15:9] << 1;
                     led_mem[9][9:0] = led_mem[9][9:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==10)
                 begin
                     led_mem[10][10] = 0;
                     led_mem[10][15:10] = led_mem[10][15:10] << 1;
                     led_mem[10][10:0] = led_mem[10][10:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==11)
                 begin
                     led_mem[11][11] = 0;
                     led_mem[11][15:11] = led_mem[11][15:11] << 1;
                     led_mem[11][11:0] = led_mem[11][11:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==12)
                 begin
                     led_mem[12][12] = 0;
                     led_mem[12][15:12] = led_mem[12][15:12] << 1;
                     led_mem[12][12:0] = led_mem[12][12:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==13)
                 begin
                     led_mem[13][13] = 0;
                     led_mem[13][15:13] = led_mem[13][15:13] << 1;
                     led_mem[13][13:0] = led_mem[13][13:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==14)
                 begin
                     led_mem[14][14] = 0;
                     led_mem[14][15:14] = led_mem[14][15:14] << 1;
                     led_mem[14][14:0] = led_mem[14][14:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

                 if(counter3==15)
                 begin
                     led_mem[15][15] = 0;
                     led_mem[15][15:0] = led_mem[15][15:0] >> 1;
                     if(led_mem[counter3] == 0)  anim[(counter3*3)+:3] = 0;
                 end

             end
         end
////////////////////////////////////////////////////////////////////////    

        //reset animation counter
        if(counter3<15)
        begin
             counter3 = counter3 + 1;
        end
        else counter3 = 0;

     end
 end

endmodule
