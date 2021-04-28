`timescale 1ns/1ns

`include "sender.v"
`include "reciever.v"


module main_bus(ack,en,clk1,clr,clk2,req,data_out,complete);

input clr,clk1,clk2,en;
inout ack,req,complete;
output [5:0]data_out;
wire [5:0]temp;


sender sen(clk1,clr,en,ack,temp,req,complete);
reciever rec(clk2,temp,req,clr,ack,data_out,complete);
endmodule