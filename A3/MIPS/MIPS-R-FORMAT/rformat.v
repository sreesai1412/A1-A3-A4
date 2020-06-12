//Names: 
//Sai Sree Harsha: 181CO146
//Krishna Swaroop: 181CO125
//Aditya Sohoni:   181CO203
//Videh Raj Nema:  181CO158

//Date:02/06/2020
//Question No.:4
//Program:Implements the MIPS-R-Format Instructions

`timescale 1ns/1ns
//REGISTER FILE
module regfile(input clock,input reset, input [4:0] address,
               input en_write, input [31:0]idata,output [31:0]data);

// Register file storage
reg [31:0] registers[31:0];
reg [31:0] out_val;

// Read and write from register file
always @(posedge clock)
    if(!reset) begin
        if (en_write)
                registers[address] <= idata;
        else
                out_val <= registers[address];
    end

assign data = en_write ? 32'bx : out_val;

endmodule

module rformat(input[31:0] instr,output [4:0]rs,output[4:0] rt,output [4:0]rd,output [5:0]funct);

    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign funct = instr[5:0];

endmodule  

module tb;
    reg clock;
    reg reset;
    reg [4:0] address;
    reg en_write;
    reg [31:0] idata;
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
        .address(address),
        .en_write(en_write),
        .idata(idata),
        .data(data)
    );

    rformat f1(
        .instr(instr),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .funct(funct)
    );

    initial begin
        $dumpfile("RFormat.vcd");
        $dumpvars(0,tb);
    end

    initial begin
        clock = 0;
        forever
        #5 clock = ~clock;
    end

    initial begin
    reset = 0;
    #5;
    #5 en_write=1; address=1; idata= 212;
    #10;
    #5 en_write=1; address=2; idata= 32;
    #10;
    #5 instr = 32'b00000000001000100001100000010000;
    #10;
    #5 en_write=0; address=rs;
    #10;
    #5 data1=data;
    #10;
    #5 en_write=0; address=rt;
    #10;
    #5 data2=data;
    #10;
    #5 en_write=1; address=rd; idata= data1+data2;
    #10
    #5 en_write=0; address=rd;
    #10;
    #5 data3=data;
    #10;
    #5 instr = 32'b00000000001000100001100000010010;
    #10;
    #5 en_write=0; address=rs;
    #10;
    #5 data1=data;
    #10;
    #5 en_write=0; address=rt;
    #10;
    #5 data2=data;
    #10;
    #5 en_write=1; address=rd; idata= data1-data2;
    #10
    #5 en_write=0; address=rd;
    #10;
    #5 data3=data;
    #10;
    #5 instr = 32'b00000000001000100001100000010100;
    #10;
    #5 en_write=0; address=rs;
    #10;
    #5 data1=data;
    #10;
    #5 en_write=0; address=rt;
    #10;
    #5 data2=data;
    #10;
    #5 en_write=1; address=rd; idata= data1&data2;
    #10
    #5 en_write=0; address=rd;
    #10;
    #5 data3=data;
    #10;
    #5 instr = 32'b00000000001000100001100000010101;
    #10;
    #5 en_write=0; address=rs;
    #10;
    #5 data1=data;
    #10;
    #5 en_write=0; address=rt;
    #10;
    #5 data2=data;
    #10;
    #5 en_write=1; address=rd; idata= data1|data2;
    #10
    #5 en_write=0; address=rd;
    #10;
    #5 data3=data;
    #10;
    end

    initial begin
        $monitor("Instr=%b\tData1=%d\tData2=%d\tResult=%d\n",instr,data1,data2,data3);
    end

endmodule

