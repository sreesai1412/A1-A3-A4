//Name: 
//Sai Sree Harsha: 181CO146
//Krishna Swaroop: 181CO125
//Aditya Sohoni:   181CO203
//Videh Raj Nema:  181CO158

//Date:16/05/2020
//Question No.:2
//Program:Implements the uPower-ALU-CONTROL

`define AND 4'b0000
`define OR  4'b0001
`define ADD 4'b0010
`define SUB 4'b0110
`define AND_FUNCT 10'd28
`define OR_FUNCT  10'd444
`define ADD_FUNCT 10'd266
`define SUB_FUNCT 10'd40
`define LW  6'd32 //lw || sw || addi
`define SW  6'd36
`define ADDI 6'd14
`define BEQ  6'd19
`define ORI  6'd15 
`define ANDI 6'd28

module alu_control (
  input [9:0] funct,
  input [5:0] alu_op,
  output [3:0] aluctrl );

  reg [3:0] funct_val;
  
  reg [3:0] aluctrl_val;
  
  always @(*) begin
    case(funct)
      `AND_FUNCT  : funct_val =  `AND;
      `OR_FUNCT   : funct_val =  `OR ;
      `ADD_FUNCT  : funct_val =  `ADD;
      `SUB_FUNCT  : funct_val =  `SUB;
      default: funct_val= 0;
    endcase
  end  
  
  always @(*) begin
    
    aluctrl_val <= 0;
    
    case (alu_op)
      `LW  : aluctrl_val <= 4'd2;//lw 
      `SW  : aluctrl_val <= 4'd2;//sw
      `ADDI  : aluctrl_val <= 4'd2;//addi
      `BEQ : aluctrl_val <= 4'd6;//branch
      `ORI : aluctrl_val <= 4'd1;//ori
      `ANDI: aluctrl_val <= 4'd0;//andi
      6'd31 : aluctrl_val <= funct_val;//r type
      default: aluctrl_val <= 0;
    endcase
  end

  assign aluctrl = aluctrl_val;

endmodule

//test bench
module tb;
    reg [9:0] funct;
    reg [5:0] alu_op;
    wire [3:0] aluctrl;

    alu_control a1(
        .funct(funct),
        .alu_op(alu_op),
        .aluctrl(aluctrl)
    );

    initial begin
        $dumpfile("ALUControl.vcd");
        $dumpvars(0,tb);
    end

    initial begin 
        funct=10'd28;alu_op=6'd31;
        #10;
        funct=10'd444;alu_op=6'd31;
        #10;
        funct=10'd266;alu_op=6'd31;
        #10;
        funct=10'd40;alu_op=6'd31;
        #10;
        funct=6'bxxxxxx;alu_op=6'd32;
        #10;
        funct=6'bxxxxxx;alu_op=6'd36;
        #10;
        funct=6'bxxxxxx;alu_op=6'd14;
        #10;
        funct=6'bxxxxxx;alu_op=6'd15;
        #10;
        funct=6'bxxxxxx;alu_op=6'd28;
        #10;
        funct=6'bxxxxxx;alu_op=6'd19;
        #10;
    end

    initial begin
        $monitor("Funct=%b\tALUOp=%b\tALUControl=%b\n",funct,alu_op,aluctrl);
    end

endmodule