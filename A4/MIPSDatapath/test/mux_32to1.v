`include "../lib/mux_32to1.v"

module test;

  reg  [4:0] s;
  reg  [31:0] i31, i30, i29, i28, i27, i26, i25, i24, i23,i22, i21, i20, i19, i18, i17, i16;
  reg  [31:0] i15, i14, i13, i12, i11, i10, i9, i8, i7,i6, i5, i4, i3, i2, i1, i0;
  wire [31:0] z;

  reg [31:0] val, expect;
  mux_32to1 mux(
    .s  (s ),
    .i31(i31),  
    .i30(i30),
    .i29(i29),
    .i28(i28),
    .i27(i27),
    .i26(i26),
    .i25(i25),
    .i24(i24),
    .i23(i23),
    .i22(i22),
    .i21(i21),
    .i20(i20),
    .i19(i19),
    .i18(i18),
    .i17(i17),
    .i16(i16),
    .i15(i15),   
    .i14(i14),
    .i13(i13),
    .i12(i12),
    .i11(i11),
    .i10(i10),
    .i9 (i9 ),
    .i8 (i8 ),
    .i7 (i7 ),
    .i6 (i6 ),
    .i5 (i5 ),
    .i4 (i4 ),
    .i3 (i3 ),
    .i2 (i2 ),
    .i1 (i1 ),
    .i0 (i0 ),
    .z  (z ));
  
  initial begin
    $monitor($time, ": %d expect=%d", val, expect);
    #5 i31 = 5; val = i31; s = 5'b11111;
    
  end

// 0000 0
// 0001 1
// 0010 2
// 0011 3
// 0100 4
// 0101 5
// 0110 6
// 0111 7
// 1000 8
// 1001 9
// 1010 10
// 1011 11
// 1100 12
// 1101 13
// 1110 14
// 1111 15
 
endmodule