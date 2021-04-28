`timescale 1ns/1ns

module sender(.clk(clk),.clr(clr),.en(en),.ack(ack),.data_out(data_out),.req(req),complete);
input clk,clr,ack,en,complete;
output reg [5:0]data_out;
output reg req;

reg [5:0]mem;
parameter s0 =1'b0, s1=1'b1;
reg PS,NS;
integer xyz = 6;

initial
 begin
   repeat(10)
   begin #22; if(!ack) mem = $random(xyz); end
   end

always @(posedge clk, negedge clr)
 begin
  if(!clr && !en)
   PS <= s0;
  else 
   PS <= NS;
 end

always @(posedge clk , negedge clr)
  begin
  if(clr && !en)
   case(PS)
    s0 : NS <= (!en) ? s1 : s0;
    s1 : NS <= (!ack)? s1 : s0;
    default : NS <= s0;        
    endcase
   else NS <= s0;    
  end

always @(*)
  begin 
     if(clr && !en)
   case(PS)
    s0 : begin req = 0; end
    s1 : begin if(complete) data_out = mem; req = 1; end
    default : begin req = 0; end
   endcase
    else begin req = 0; end
  end
endmodule