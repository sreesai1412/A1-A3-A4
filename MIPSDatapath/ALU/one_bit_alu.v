`include "../lib/mux_16to1.v"
`include "../lib/full_adder.v"
`include "../lib/full_subtractor.v"

module one_bit_alu (
  input  [3:0] op,
  input  a, b, cin, less,
  output r, cout, bout, set
  );
 
wire int0, int1, int2, int3, addOP, subOP, addOP_cout, subOP_bout;
and (int0, a, b);
or  (int1, a, b);
xor (int2, a, b);
nor (int3, a, b);

xor (xorB, b, sub);

full_adder       add     (.sum(addOP), .a(a), .b(b), .cin   (cin), .cout   (addOP_cout));
full_subtractor  subtract(.d  (subOP), .a(b), .b(a), .Bor_in(cin), .Bor_out(subOP_bout));

buf(set, subOP);

mux_16to1 mux0(
  .s  (op    ),
  .i0 (int0  ), // and
  .i1 (int1  ), // or
  .i2 (addOP ), // add
  .i6 (subOP ), // sub
  .i7 (less  ), // less
  .i12(int3  ), // nor
  .z  (r    ));

mux_16to1 mux1(
  .s(op),
  .i2(addOP_cout),
  .i6(subOP_bout),
  .i7(subOP_bout),  
  .z(cout));
endmodule

