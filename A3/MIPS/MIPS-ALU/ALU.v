//Names: 
//Sai Sree Harsha: 181CO146
//Krishna Swaroop: 181CO125
//Aditya Sohoni:   181CO203
//Videh Raj Nema:  181CO158

//Date:16/05/2020
//Question No.:1
//Program:Implements the MIPS-ALU

`timescale 1ns/1ns
module half_adder(
     input in_a,in_b,
     output sum,carry
 );
  xor(sum,in_a,in_b);
  and(carry,in_a,in_b);
 endmodule

 module full_adder(
     input in_a,in_b,in_carry,
     output fsum,fcarry
 );
    wire s1,c1,c2;
    half_adder h1(in_a,in_b,s1,c1);
    half_adder h2(s1,in_carry,fsum,c2);
    or(fcarry,c1,c2);
  endmodule

// MULTIPLEXER
module mux (           input a,
                       input b,
                       input c,
                       input [1:0] sel,
                       output reg out);
   // This always block gets executed whenever a/b/c/d/sel changes value
   // When that happens, based on value in sel, output is assigned to either a/b/c/d
   always @ (a or b or c or sel) begin
      case (sel)
         2'b00 : out <= a;
         2'b01 : out <= b;
         2'b10 : out <= c;
         2'b11 : out <= c;
      endcase
   end
endmodule

//REGISTER FILE
module regfile(input clock,input reset, input [4:0] address,
               input en_write, input [63:0]idata,output [63:0]data);

// Register file storage
reg [63:0] registers[31:0];
reg [63:0] out_val;

// Read and write from register file
always @(posedge clock)
    if(!reset) begin
        if (en_write)
                registers[address] <= idata;
        else
                out_val <= registers[address];
    end

assign data = en_write ? 64'bx : out_val;

endmodule

//1 BIT ALU

module ALU_1b(
    input a,b,A_invert,B_invert,Carry_in,
    input [1:0]operation,
    output Result,Carry_out
);
    wire w0,w1,w2;
    and(w0,a^A_invert,b^B_invert);
    or(w1,a^A_invert,b^B_invert);
    full_adder f1(a^A_invert,b^B_invert,Carry_in,w2,Carry_out);
    mux m1(w0,w1,w2,operation,Result);

endmodule

// 64 BIT ALU

module ALU_64b(
    input [63:0]a,
    input [63:0]b,
    input A_invert,B_invert,
    input Carry_in,
    input [1:0]operation,
    output [63:0]result,
    output Carry_out,
    output slt,overflow
);
    wire [64:0]w1;
    assign w1[0]=Carry_in;
    reg slt;

    genvar p;
    generate
    for(p = 0; p < 64; p = p + 1)
    begin
        ALU_1b a1(b[p],a[p],A_invert,B_invert,w1[p],operation,result[p],w1[p+1]);
    end
    endgenerate

    assign overflow=w1[63]^w1[64];
    assign Carry_out=w1[64];

    always@(*)
    begin
        if(operation==2'b11)
        begin
            slt<=result[63];
        end
    end
endmodule

//test bench

module tb;
    reg clock;
    reg reset;
    reg [4:0] address;
    reg en_write;
    reg [63:0] idata;
    wire [63:0] data;
    reg A_invert,B_invert,Carry_in;
    reg[1:0]operation;
    wire[63:0] ans;
    wire carry_out;
    wire slt,overflow;
    reg[63:0] data1,data2;

    regfile r1(
        .clock(clock),
        .reset(reset),
        .address(address),
        .en_write(en_write),
        .idata(idata),
        .data(data)
    );
    ALU_64b a2(data2,data1,A_invert,B_invert,Carry_in,operation,ans,carry_out,slt,overflow);

    integer i;

    initial begin
    $dumpfile("ALU.vcd");
    $dumpvars(0,tb);
    reset = 0;
    #5;
    #5 en_write=1; address=1; idata= 212;
    #10;
    #5 en_write=1; address=2; idata= 32;
    #10;
    #5 en_write=1; address=3; idata= 7616778545161;
    #10;
    #5 en_write=1; address=4;idata = 4781784544581;
    #10;
    #5 en_write=1; address=5;idata = 185454903;
    #10;
    #5 en_write=1; address=6;idata = 674545449;
    #10;
    #5 en_write=1; address=7;idata = 632;
    #10;
    #5 en_write=1; address=8;idata = 4321;
    #10;
    #5 en_write=1; address=9;idata = 4192;
    #10;
    #5 en_write=1; address=10;idata = 190;
    #10;
    #5 en_write=0; address=1;
    #10;
    #5 data1=data;
    #10;
    #5 en_write=0; address=2;
    #10;
    #5 data2 =data;operation=2'b10;A_invert=1'b0;B_invert=1'b0;Carry_in=1'b0;
    #10;
    #5 en_write=1;address=11;idata=ans;$display("data1=%d,data2=%d,SUM=%d,CarryOut=%d,Overflow=%d\n",data1,data2,ans,carry_out,overflow);
    #10;
    #5 en_write=0; address=3;
    #10;
    #5 data1=data;
    #10;
    #5 en_write=0; address=4;
    #10;
    #5 data2 =data;operation=2'b00;A_invert=1'b0;B_invert=1'b0;Carry_in=1'b0;
    #10;
    #5 en_write=1;address=12;idata=ans;$display("data1=%b\ndata2=%b\nAND  =%b\n",data1,data2,ans);
    #10;
    #5 en_write=0; address=5;
    #10;
    #5 data1=data;
    #10
    #5 en_write=0; address=6;
    #10;
    #5 data2 =data;operation=2'b01;A_invert=1'b0;B_invert=1'b0;Carry_in=1'b0;
    #10;
    #5 en_write=1;address=13;idata=ans;$display("data1=%b\ndata2=%b\nOR   =%b\n",data1,data2,ans);
    #10;
    #5 en_write=0; address=7;
    #10;
    #5 data1=data;
    #10;
    #5 en_write=0; address=8;
    #10;
    #5 data2 =data;operation=2'b11;A_invert=1'b0;B_invert=1'b1;Carry_in=1'b1;
    #10;
    #5 en_write=1;address=14;idata=ans;$display("data1=%d,data2=%d,DIFF=%d,set=%d,overflow=%d\n",data1,data2,ans,slt,overflow);
    #10;
    #5 en_write=0; address=9;
    #10;
    #5 data1=data;
    #10;
    #5 en_write=0; address=10;
    #10;
    #5 data2 =data;operation=2'b10;A_invert=1'b0;B_invert=1'b1;Carry_in=1'b1;
    #10;
    #5 en_write=1;address=15;idata=ans;$display("data1=%d,data2=%d,DIFF=%d,overflow=%d\n",data1,data2,ans,overflow);
    #10;

    $finish;
end

    initial begin
        clock = 0;
        forever
        #5 clock = ~clock;
    end

    initial begin
        #205;
        $monitor("time=%d,operation=%d",$time,operation);
    end

endmodule
