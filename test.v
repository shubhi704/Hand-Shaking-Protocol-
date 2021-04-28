module main_test;

reg clk1,clk2,clr,en;
inout ack,req,complete;
wire [5:0]data_out;


main_bus ber(ack,en,clk1,clr,clk2,req,data_out,complete);


initial
 begin
  clk1=0; 
  forever #5 clk1 = ~clk1;
 end

initial
 begin
  clk2=0; 
  forever #4 clk2 = ~clk2;
 end

initial
 begin
  #0 en=0;
  #0 clr=0;
  #12 clr=1;
  #100 en=1;
   #40 en=0;
 end
initial
 begin
  $dumpfile("main.vcd");
  $dumpvars;
  #400 $finish;
 end
endmodule
