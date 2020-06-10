MIPS-Datapath

Supported instructions:

- Arithmetic: add, addi, sub
- Load/Store: lw, sw
- Logic: and, andi, or, ori, nor
- Control flow: beq, bne, jal, jr, j
- Comparison: slt

##Implementation

###Directories Structure:
 - test: Contains test benches for all modules
 - program: Contains test for different instructions types and the main program in test.txt file.
 - lib: Contains the common module that is used in other different modules.
 - Rest of dirs: Each contains its module.
 
###Code Structure:
  most of the code is designed in both structural and behavioral style, however instruction and data memory
  is designed in the behavioral code style.
  
  Each module of the mips processor is under its own directory and they are all included in cpu file.
  
  - **ALU**: the ALU unit is cascaded from 32 one_bit_alu 

  - **im**: Instruction memory is word addressable, It's initialized using `$readmemh` verilog operation,
  The default text file is `program/test.txt`.Maximum number of instructions that it can contain is 255. 

  - **dm**: Data memory is 32 bit with 256 entries.In the positive edge of the clock when the memWrite signal is 1,the input data is written in the address given from the ALU, otherwise the memRead signal is 1 and the output data is given form data saved from the ALU given address.

  - **RF**: Register File
  
  - **Control Signals**:

      | RegDst | ALUSrc | memToReg | regWrite | memRead | memWrite | branch | branch_ne | jump | aluOP
----- | ------ | ------ | -------- | -------- | ------- | -------- | ------ | --------- | ---- | -----
R Format | 01 | 0 | 00 | 1 | 0 | 0 | 0 | 0  | 0 | 010 
lw | 00 | 1 | 01 | 1 | 1 | 0| 0 | 0  | 0 | 000 
sw | 00 | 1 | 00 | 0 | 0 | 1 | 0 | 0  | 0 | 000 
beq | 00 | 0 | 00 | 0 | 0 | 0 | 1 | 0  | 0 | 001
bne | 00 | 0 | 00 | 0 | 0 | 0 | 0 | 1  | 0 | 001
J | 00 | 0 | 00 | 0 | 0 | 0 | 0 | 0  | 1 | 000
Jal | 10 | 0 | 10 | 1 | 0 | 0 | 0 | 0  | 1 | 000
addi | 00 | 1 | 00 | 1 | 0 | 0 | 0 | 0 | 0 | 000
andi | 00 | 1 | 00 | 1 | 0 | 0 | 0 | 0 | 0 | 011
ori | 00  | 1 | 00 | 1 | 0 | 0 | 0 | 0 | 0 | 100
  
##Running Tests

Each individual module have his own test under test sub-directory,
To run them change dir to test and compile&run the testbench, eg.
    
    $ iverlog -o alu_test alu_test.v
    $ vvp alu_test



To compile/run a full programme:

1)Place the programme in the `program/test.txt` file
2)cd into the `test` directory
3)then run this cmd

    $ iverilog -o cpu_test cpu_test.v 
    $ vvp cpu_test
    
Notice that it through a warning, but there no worries about that. the registers that is affected from this code is $t0 = 10, $t1 = 10 ,$s0 = 10 and $ra = 3.

You can also look at the output wave using gtkwave 
run this cmd

    $ gtkwave cpu.vcd


