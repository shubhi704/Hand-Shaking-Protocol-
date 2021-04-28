`timescale 1ns/1ns

module reciever(clk,data_in,req,clr,ack,data_out,complete);
input clk,clr,req;
input [5:0]data_in;
output reg ack, complete;
output reg [5:0]data_out;
parameter s0 =2'b00, s1=2'b01,s2=2'b10;
reg [1:0]PS,NS;


always @(posedge clk, negedge clr)
begin
 if(!clr)
  PS <= s0;
 else 
  PS <= NS;
 end
always @(posedge clk, negedge clr)
  begin
  if(clr)
   case(PS)
    s0 : NS <= req ? s1 : s0;
    s1 : NS <= s2;
    s2 : NS <= (req) ? s2 : s0;
    default : NS <= s0;        
   endcase
  end
always @(*)
  begin
   if(clr) 
   case(PS)
    s0 : begin ack = 0;complete = 0;  end
    s1 : begin data_out = data_in; complete = 1; 
          end
    s2 :  begin ack = 1;  end
    default : begin ack = 0; complete = 0;  end
   endcase
  end
endmodule