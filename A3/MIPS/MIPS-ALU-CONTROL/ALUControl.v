//Name: 
//Sai Sree Harsha: 181CO146
//Krishna Swaroop: 181CO125
//Aditya Sohoni:   181CO203
//Videh Raj Nema:  181CO158

//Date:16/05/2020
//Question No.:2
//Program:Implements the MIPS-ALU-CONTROL

`define AND 4'b0000
`define OR  4'b0001
`define ADD 4'b0010
`define SUB 4'b0110
`define SLT 4'b0111
`define NOR 4'b1100
`define AND_FUNCT 6'b100100
`define OR_FUNCT  6'b100101
`define ADD_FUNCT 6'b100000
`define SUB_FUNCT 6'b100010
`define SLT_FUNCT 6'b101010
`define NOR_FUNCT 6'b100111
`define LW   3'b000 //lw || sw || addi
`define BEQ  3'b001
`define ORI  3'b100 
`define ANDI 3'b011

module alu_control (
  input [5:0] funct,
  input [2:0] alu_op,
  output [3:0] aluctrl );

  reg [3:0] funct_val;
  
  reg [3:0] aluctrl_val;
  
  always @(*) begin
    case(funct)
      `AND_FUNCT  : funct_val =  `AND;
      `OR_FUNCT   : funct_val =  `OR ;
      `ADD_FUNCT  : funct_val =  `ADD;
      `SUB_FUNCT  : funct_val =  `SUB;
      `SLT_FUNCT  : funct_val =  `SLT;
      `NOR_FUNCT  : funct_val =  `NOR;
      default: funct_val= 0;
    endcase
  end  
  
  always @(*) begin
    
    aluctrl_val <= 0;
    
    case (alu_op)
      `LW  : aluctrl_val <= 4'd2;//lw sw addi
      `BEQ : aluctrl_val <= 4'd6;//branch
      `ORI : aluctrl_val <= 4'd1;//ori
      `ANDI: aluctrl_val <= 4'd0;//andi
      3'b010 : aluctrl_val <= funct_val;//r type
      default: aluctrl_val <= 0;
    endcase
  end

  assign aluctrl = aluctrl_val;

endmodule

//test bench
module tb;
    reg [5:0] funct;
    reg [2:0] alu_op;
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
        funct=6'b100000;alu_op=3'b010;
        #10;
        funct=6'b100010;alu_op=3'b010;
        #10;
        funct=6'b100100;alu_op=3'b010;
        #10;
        funct=6'b100101;alu_op=3'b010;
        #10;
        funct=6'b101010;alu_op=3'b010;
        #10;
        funct=6'b100111;alu_op=3'b010;
        #10;
        funct=6'bxxxxxx;alu_op=3'b000;
        #10;
        funct=6'bxxxxxx;alu_op=3'b010;
        #10;
        funct=6'bxxxxxx;alu_op=3'b100;
        #10;
        funct=6'bxxxxxx;alu_op=3'b011;
        #10;
    end

    initial begin
        $monitor("Funct=%b\tALUOp=%b\tALUControl=%b\n",funct,alu_op,aluctrl);
    end

endmodule