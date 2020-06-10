// MIPS test bench - To drive and simulate the entire MIPS ALU 
`include "uPower_core.v"
module upower_testbench();

reg clock;
wire result;

upower_core Datapath(clock);
initial clock = 0;

initial 
 begin
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
 end

endmodule

