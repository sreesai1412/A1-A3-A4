//Names: 
//Sai Sree Harsha: 181CO146
//Krishna Swaroop: 181CO125
//Aditya Sohoni:   181CO203
//Videh Raj Nema:  181CO158

//Date:12/06/2020
//Question No.:6
//Program:Implements the Load Instructions

`timescale 1ns/1ns
//REGISTER FILE
module regfile(input clock,input reset, input [4:0] addressin,input [4:0] addressout,
               input en_write, input [31:0]idata,output [31:0]data,input [31:0]datamem,input offset);


// Register file storage
reg [31:0] registers;
reg print_val;
//output reg printval;

// Read and write from register file
always @(addressin)
    if(!reset) begin
        if (en_write)
                //idata<=datamem[registers[addressin]+offset];
                registers[addressout] <= datamem[registers[addressin]+offset];
                print_val = registers[addressout];
                $monitor("input regno=%b\toutput regno=%b\t\n",addressin,addressout);
    end

endmodule



module tb;
    

    reg clock;
    reg reset;
    reg [4:0] addressin;
    reg [4:0] addressout;
    reg en_write;
    reg offset;
    reg finalval;
    reg print_val;
    reg [31:0] idata;
    reg [31:0] datamem;
    reg [31:0] instr;
    wire [31:0] data;
    wire [4:0]rs;
    wire [4:0]rt;
    wire [4:0]rd;
    wire [5:0]funct;
    integer data1,data2,data3;

    regfile r1(
        .clock(clock),
        .reset(reset),
        .addressin(addressin),
        .addressout(addressout),
        .en_write(en_write),
        .idata(idata),
        .data(data),
        .datamem(datamem),
        .offset(offset)//, 
        //.print_val(print_val)
    );

   

    initial begin
        $dumpfile("LW.vcd");
        $dumpvars(0,tb);
    end

    initial begin
    reset = 0;
    #5;
    #5;
    en_write=1;reset=0;  
    addressin=1;addressout=1;offset=3;

    #5;
    en_write=1;reset=0;  
    addressin=3;addressout=2;offset=3;

    #5;
    en_write=1;reset=0;  
    addressin=12;addressout=5;offset=3;

    #5;
    en_write=1;reset=0;  
    addressin=4;addressout=12;offset=3;

    #5;
    en_write=1;reset=0;  
    addressin=4;addressout=31;offset=3;

    #5;
    en_write=1;reset=0;  
    addressin=22;addressout=19;offset=3;

    #5;
    en_write=1;reset=0;  
    addressin=12;addressout=16;offset=3;
   

    #10;
    end


endmodule