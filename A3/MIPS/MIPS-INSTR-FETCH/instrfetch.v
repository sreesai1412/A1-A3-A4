//Name: 
//Sai Sree Harsha: 181CO146
//Krishna Swaroop: 181CO125
//Aditya Sohoni:   181CO203
//Videh Raj Nema:  181CO158

//Date:16/05/2020
//Question No.:3
//Program:Implements the MIPS-INSTRUCTION-FETCH
module read_instructions(program_counter,instruction);

    input [31:0] program_counter;
    output reg [31:0] instruction;
	
    reg [31:0] instructions [255:0];  //set to the number of instructions in the file
    
    initial begin 
        $readmemb("instructions.mem", instructions, 0, 6); 
    end
	
    always @ (program_counter) begin
        instruction = instructions[program_counter];
    end

endmodule

module tb;
    reg[31:0] pc;
    wire[31:0] instr;

    read_instructions ri(
        .program_counter(pc),
        .instruction(instr)
    );

    initial begin
        $dumpfile("InstrFetch.vcd");
        $dumpvars(0,tb);
    end

    initial begin
        pc=0;
        #10;
        pc=1;
        #10
        pc=2;
        #10;
        pc=3;
        #10;
        pc=4;
        #10
        pc=5;
        #10;
    end

    initial begin
        $monitor("PC=%b\tInstruction=%b\n",pc,instr);
    end
endmodule