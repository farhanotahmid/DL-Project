//=============================================
// D Flip Flop
//=============================================
module DFF(clk,in,out);
	input          clk;
	input   in;
	output  out;
	reg     out;

	always @(posedge clk)
	out = in;
endmodule

//=============================================
// Half Adder
//=============================================
module HalfAdder(A,B,carry,sum);
	input A;
	input B;
	output carry;
	output sum;
	reg carry;
	reg sum;
//---------------------------------------------	
	always @(*) 
	  begin
	    sum= A ^ B;
	    carry= A & B;
	  end
//---------------------------------------------
endmodule


//=============================================
// Full Adder
//=============================================
module FullAdder(A,B,C,carry,sum);
	input A;
	input B;
	input C;
	output carry;
	output sum;
	reg carry;
	reg sum;
//---------------------------------------------	
	wire c0;
	wire s0;
	wire c1;
	wire s1;
//---------------------------------------------
	HalfAdder ha1(A ,B,c0,s0);
	HalfAdder ha2(s0,C,c1,s1);
//---------------------------------------------
	always @(*) 
	  begin
	    sum=s1; 
		sum= A^B^C; 
	    carry=c1|c0; 
		carry= ((A^B)&C)|(A&B);  
	  end
//---------------------------------------------
	
endmodule

//ADDITION OPCODE = 0010
//SUBTRACTION OPCODE = 0011
module AddSub(inputA,inputB,mode,sum,overflow);
    input [15:0] inputA;
	input [15:0] inputB;
    input mode;
    output [15:0] sum;
    output overflow;

	wire c0; //MOde assigned to C0

    wire b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15; //XOR Interfaces
	wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16; //Carry Interfaces
	
	assign c0=mode;//Mode=0, Addition; Mode=1, Subtraction
	
    assign b0 = inputB[0] ^ mode;//Flip the Bit if Subtraction
    assign b1 = inputB[1] ^ mode;//Flip the Bit if Subtraction
    assign b2 = inputB[2] ^ mode;//Flip the Bit if Subtraction
    assign b3 = inputB[3] ^ mode;//Flip the Bit if Subtraction
	assign b4 = inputB[4] ^ mode;//Flip the Bit if Subtraction
	assign b5 = inputB[5] ^ mode;
	assign b6 = inputB[6] ^ mode;
	assign b7 = inputB[7] ^ mode;

	assign b8 = inputB[8] ^ mode;
	assign b9 = inputB[9] ^ mode;
	assign b10 = inputB[10] ^ mode;
	assign b11 = inputB[11] ^ mode;
	assign b12 = inputB[12] ^ mode;
	assign b13 = inputB[13] ^ mode;
	assign b14 = inputB[14] ^ mode;
	assign b15 = inputB[15] ^ mode;

	
 
	FullAdder FA0(inputA[0],b0,  c0,c1,sum[0]);
	FullAdder FA1(inputA[1],b1,  c1,c2,sum[1]);
	FullAdder FA2(inputA[2],b2,  c2,c3,sum[2]);
	FullAdder FA3(inputA[3],b3,  c3,c4,sum[3]);
	FullAdder FA4(inputA[4],b4,  c4,c5,sum[4]);
	FullAdder FA5(inputA[5],b5,  c5,c6,sum[5]);
	FullAdder FA6(inputA[6],b6,  c6,c7,sum[6]);
	FullAdder FA7(inputA[7],b7,  c7,c8,sum[7]);

	FullAdder FA8(inputA[8],b8,  c8,c9,sum[8]);
	FullAdder FA9(inputA[9],b9,  c9,c10,sum[9]);
	FullAdder FA10(inputA[10],b10,  c10,c11,sum[10]);
	FullAdder FA11(inputA[11],b11,  c11,c12,sum[11]);
	FullAdder FA12(inputA[12],b12,  c12,c13,sum[12]);
	FullAdder FA13(inputA[13],b13,  c13,c14,sum[13]);
	FullAdder FA14(inputA[14],b14,  c14,c15,sum[14]);
	FullAdder FA15(inputA[15],b15,  c15,c16,sum[15]);

	//assign carry=c16;
	assign overflow=c16;
	always@(*)
	begin
		//$display("%b %b %b",c15, c16, overflow);
	end
 
endmodule

module SixteenBitFullAdder(A,B,C,Carry,Sum);
	
	input [15:0] A;
	input [15:0] B;
	input C;
	output [15:0] Carry;
	output [15:0] Sum;
	FullAdder FA0(A[0],B[0],C       ,Carry[0],Sum[0]);
	FullAdder FA1(A[1],B[1],Carry[0],Carry[1],Sum[1]);
	FullAdder FA2(A[2],B[2],Carry[1],Carry[2],Sum[2]);
	FullAdder FA3(A[3],B[3],Carry[2],Carry[3],Sum[3]);

	FullAdder FA4(A[4],B[4],Carry[3],Carry[4],Sum[4]);
	FullAdder FA5(A[5],B[5],Carry[4],Carry[5],Sum[5]);
	FullAdder FA6(A[6],B[6],Carry[5],Carry[6],Sum[6]);
	FullAdder FA7(A[7],B[7],Carry[6],Carry[7],Sum[7]);

	FullAdder FA8(A[8],B[8],Carry[7],Carry[8],Sum[8]);
	FullAdder FA9(A[9],B[9],Carry[8],Carry[9],Sum[9]);
	FullAdder FA10(A[10],B[10],Carry[9],Carry[10],Sum[10]);
	FullAdder FA11(A[11],B[11],Carry[10],Carry[11],Sum[11]);

	FullAdder FA12(A[12],B[12],Carry[11],Carry[12],Sum[12]);
	FullAdder FA13(A[13],B[13],Carry[12],Carry[13],Sum[13]);
	FullAdder FA14(A[14],B[14],Carry[13],Carry[14],Sum[14]);
	FullAdder FA15(A[15],B[15],Carry[14],Carry[15],Sum[15]);
	
endmodule

module Dec4x16(binary,onehot);
	input [3:0] binary;
	output [15:0]onehot;
	
	assign onehot[ 0]=~binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign onehot[ 1]=~binary[3]&~binary[2]&~binary[1]& binary[0];
	assign onehot[ 2]=~binary[3]&~binary[2]& binary[1]&~binary[0];
	assign onehot[ 3]=~binary[3]&~binary[2]& binary[1]& binary[0];
	assign onehot[ 4]=~binary[3]& binary[2]&~binary[1]&~binary[0];
	assign onehot[ 5]=~binary[3]& binary[2]&~binary[1]& binary[0];
	assign onehot[ 6]=~binary[3]& binary[2]& binary[1]&~binary[0];
	assign onehot[ 7]=~binary[3]& binary[2]& binary[1]& binary[0];
	assign onehot[ 8]= binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign onehot[ 9]= binary[3]&~binary[2]&~binary[1]& binary[0];
	assign onehot[10]= binary[3]&~binary[2]& binary[1]&~binary[0];
	assign onehot[11]= binary[3]&~binary[2]& binary[1]& binary[0];
	assign onehot[12]= binary[3]& binary[2]&~binary[1]&~binary[0];
	assign onehot[13]= binary[3]& binary[2]&~binary[1]& binary[0];
	assign onehot[14]= binary[3]& binary[2]& binary[1]&~binary[0];
	assign onehot[15]= binary[3]& binary[2]& binary[1]& binary[0];
	
endmodule

//OPCODE = 0100
module Multiplier(A,B,C);
input  [15:0] A;
input  [15:0] B;
output [31:0] C;

reg [31:0] C;

//Local Variables
reg  [15:0] Augend0;
reg  [15:0] Addend0;
wire [15:0] Sum0;
wire [15:0]Carry0;

reg  [15:0] Augend1;
reg  [15:0] Addend1;
wire [15:0] Sum1;
wire [15:0]Carry1;

reg  [15:0] Augend2;
reg  [15:0] Addend2;
wire [15:0] Sum2;
wire [15:0]Carry2;

reg  [15:0] Augend3;
reg  [15:0] Addend3;
wire [15:0] Sum3;
wire [15:0]Carry3;

reg  [15:0] Augend4;
reg  [15:0] Addend4;
wire [15:0] Sum4;
wire [15:0]Carry4;

reg  [15:0] Augend5;
reg  [15:0] Addend5;
wire [15:0] Sum5;
wire [15:0]Carry5;

reg  [15:0] Augend6;
reg  [15:0] Addend6;
wire [15:0] Sum6;
wire [15:0]Carry6;

reg  [15:0] Augend7;
reg  [15:0] Addend7;
wire [15:0] Sum7;
wire [15:0]Carry7;

reg  [15:0] Augend8;
reg  [15:0] Addend8;
wire [15:0] Sum8;
wire [15:0]Carry8;

reg  [15:0] Augend9;
reg  [15:0] Addend9;
wire [15:0] Sum9;
wire [15:0]Carry9;

reg  [15:0] Augend10;
reg  [15:0] Addend10;
wire [15:0] Sum10;
wire [15:0]Carry10;

reg  [15:0] Augend11;
reg  [15:0] Addend11;
wire [15:0] Sum11;
wire [15:0]Carry11;

reg  [15:0] Augend12;
reg  [15:0] Addend12;
wire [15:0] Sum12;
wire [15:0]Carry12;

reg  [15:0] Augend13;
reg  [15:0] Addend13;
wire [15:0] Sum13;
wire [15:0]Carry13;

reg  [15:0] Augend14;
reg  [15:0] Addend14;
wire [15:0] Sum14;
wire [15:0]Carry14;

reg  [15:0] Augend15;
reg  [15:0] Addend15;
wire [15:0] Sum15;
wire [15:0]Carry15;

SixteenBitFullAdder add0(Augend0,Addend0,1'b0,Carry0, Sum0);
SixteenBitFullAdder add1(Augend1,Addend1,1'b0,Carry1, Sum1);
SixteenBitFullAdder add2(Augend2,Addend2,1'b0,Carry2, Sum2);
SixteenBitFullAdder add3(Augend3,Addend3,1'b0,Carry3, Sum3);

SixteenBitFullAdder add4(Augend4,Addend4,1'b0,Carry4, Sum4);
SixteenBitFullAdder add5(Augend5,Addend5,1'b0,Carry5, Sum5);
SixteenBitFullAdder add6(Augend6,Addend6,1'b0,Carry6, Sum6);
SixteenBitFullAdder add7(Augend7,Addend7,1'b0,Carry7, Sum7);

SixteenBitFullAdder add8(Augend8,Addend8,1'b0,Carry8, Sum8);
SixteenBitFullAdder add9(Augend9,Addend9,1'b0,Carry9, Sum9);
SixteenBitFullAdder add10(Augend10,Addend10,1'b0,Carry10, Sum10);
SixteenBitFullAdder add11(Augend11,Addend11,1'b0,Carry11, Sum11);

SixteenBitFullAdder add12(Augend12,Addend12,1'b0,Carry12, Sum12);
SixteenBitFullAdder add13(Augend13,Addend13,1'b0,Carry13, Sum13);
SixteenBitFullAdder add14(Augend14,Addend14,1'b0,Carry14, Sum14);
SixteenBitFullAdder add15(Augend15,Addend15,1'b0,Carry15, Sum15);


always@(*)
begin
Augend0={     1'b0,A[0]&B[15], A[0]&B[14], A[0]&B[13], A[0]&B[12], A[0]&B[11], A[0]&B[10], A[0]&B[9], A[0]&B[8], A[0]&B[7], A[0]&B[6], A[0]&B[5], A[0]&B[4], A[0]&B[3], A[0]&B[2], A[0]&B[1]};
Addend0= { A[1]&B[15], A[1]&B[14], A[1]&B[13], A[1]&B[12], A[1]&B[11], A[1]&B[10], A[1]&B[9], A[1]&B[8], A[1]&B[7], A[1]&B[6], A[1]&B[5], A[1]&B[4], A[1]&B[3], A[1]&B[2], A[1]&B[1], A[1]&B[0]};

Augend1= { Carry0[15], Sum0[15], Sum0[14], Sum0[13], Sum0[12], Sum0[11], Sum0[10], Sum0[9], Sum0[8], Sum0[7], Sum0[6], Sum0[5], Sum0[4], Sum0[3], Sum0[2], Sum0[1]};
Addend1= { A[2]&B[15], A[2]&B[14], A[2]&B[13], A[2]&B[12], A[2]&B[11], A[2]&B[10], A[2]&B[9], A[2]&B[8], A[2]&B[7], A[2]&B[6], A[2]&B[5], A[2]&B[4], A[2]&B[3], A[2]&B[2], A[2]&B[1], A[2]&B[0]};

Augend2= { Carry1[15], Sum1[15], Sum1[14], Sum1[13], Sum1[12], Sum1[11], Sum1[10], Sum1[9], Sum1[8], Sum1[7], Sum1[6], Sum1[5], Sum1[4], Sum1[3], Sum1[2], Sum1[1]};
Addend2= { A[3]&B[15], A[3]&B[14], A[3]&B[13], A[3]&B[12], A[3]&B[11], A[3]&B[10], A[3]&B[9], A[3]&B[8], A[3]&B[7], A[3]&B[6], A[3]&B[5], A[3]&B[4], A[3]&B[3], A[3]&B[2], A[3]&B[1], A[3]&B[0]};


Augend3= { Carry2[15], Sum2[15], Sum2[14], Sum2[13], Sum2[12], Sum2[11], Sum2[10], Sum2[9], Sum2[8], Sum2[7], Sum2[6], Sum2[5], Sum2[4], Sum2[3], Sum2[2], Sum2[1]};
Addend3= { A[4]&B[15], A[4]&B[14], A[4]&B[13], A[4]&B[12], A[4]&B[11], A[4]&B[10], A[4]&B[9], A[4]&B[8], A[4]&B[7], A[4]&B[6], A[4]&B[5], A[4]&B[4], A[4]&B[3], A[4]&B[2], A[4]&B[1], A[4]&B[0]};

Augend4= { Carry3[15], Sum3[15], Sum3[14], Sum3[13], Sum3[12], Sum3[11], Sum3[10], Sum3[9], Sum3[8], Sum3[7], Sum3[6], Sum3[5], Sum3[4], Sum3[3], Sum3[2], Sum3[1]};
Addend4= { A[5]&B[15], A[5]&B[14], A[5]&B[13], A[5]&B[12], A[5]&B[11], A[5]&B[10], A[5]&B[9], A[5]&B[8], A[5]&B[7], A[5]&B[6], A[5]&B[5], A[5]&B[4], A[5]&B[3], A[5]&B[2], A[5]&B[1], A[5]&B[0]};


Augend5= { Carry4[15], Sum4[15], Sum4[14], Sum4[13], Sum4[12], Sum4[11], Sum4[10], Sum4[9], Sum4[8], Sum4[7], Sum4[6], Sum4[5], Sum4[4], Sum4[3], Sum4[2], Sum4[1]};
Addend5= { A[6]&B[15], A[6]&B[14], A[6]&B[13], A[6]&B[12], A[6]&B[11], A[6]&B[10], A[6]&B[9], A[6]&B[8], A[6]&B[7], A[6]&B[6], A[6]&B[5], A[6]&B[4], A[6]&B[3], A[6]&B[2], A[6]&B[1], A[6]&B[0]};


Augend6= { Carry5[15], Sum5[15], Sum5[14], Sum5[13], Sum5[12], Sum5[11], Sum5[10], Sum5[9], Sum5[8], Sum5[7], Sum5[6], Sum5[5], Sum5[4], Sum5[3], Sum5[2], Sum5[1]};
Addend6= { A[7]&B[15], A[7]&B[14], A[7]&B[13], A[7]&B[12], A[7]&B[11], A[7]&B[10], A[7]&B[9], A[7]&B[8], A[7]&B[7], A[7]&B[6], A[7]&B[5], A[7]&B[4], A[7]&B[3], A[7]&B[2], A[7]&B[1], A[7]&B[0]};


Augend7= { Carry6[15], Sum6[15], Sum6[14], Sum6[13], Sum6[12], Sum6[11], Sum6[10], Sum6[9], Sum6[8], Sum6[7], Sum6[6], Sum6[5], Sum6[4], Sum6[3], Sum6[2], Sum6[1]};
Addend7= { A[8]&B[15], A[8]&B[14], A[8]&B[13], A[8]&B[12], A[8]&B[11], A[8]&B[10], A[8]&B[9], A[8]&B[8], A[8]&B[7], A[8]&B[6], A[8]&B[5], A[8]&B[4], A[8]&B[3], A[8]&B[2], A[8]&B[1], A[8]&B[0]};


Augend8= { Carry7[15], Sum7[15], Sum7[14], Sum7[13], Sum7[12], Sum7[11], Sum7[10], Sum7[9], Sum7[8], Sum7[7], Sum7[6], Sum7[5], Sum7[4], Sum7[3], Sum7[2], Sum7[1]};
Addend8= { A[9]&B[15], A[9]&B[14], A[9]&B[13], A[9]&B[12], A[9]&B[11], A[9]&B[10], A[9]&B[9], A[9]&B[8], A[9]&B[7], A[9]&B[6], A[9]&B[5], A[9]&B[4], A[9]&B[3], A[9]&B[2], A[9]&B[1], A[9]&B[0]};


Augend9= { Carry8[15], Sum8[15], Sum8[14], Sum8[13], Sum8[12], Sum8[11], Sum8[10], Sum8[9], Sum8[8], Sum8[7], Sum8[6], Sum8[5], Sum8[4], Sum8[3], Sum8[2], Sum8[1]};
Addend9= { A[10]&B[15], A[10]&B[14], A[10]&B[13], A[10]&B[12], A[10]&B[11], A[10]&B[10], A[10]&B[9], A[10]&B[8], A[10]&B[7], A[10]&B[6], A[10]&B[5], A[10]&B[4], A[10]&B[3], A[10]&B[2], A[10]&B[1], A[10]&B[0]};


Augend10= { Carry9[15], Sum9[15], Sum9[14], Sum9[13], Sum9[12], Sum9[11], Sum9[10], Sum9[9], Sum9[8], Sum9[7], Sum9[6], Sum9[5], Sum9[4], Sum9[3], Sum9[2], Sum9[1]};
Addend10= { A[11]&B[15], A[11]&B[14], A[11]&B[13], A[11]&B[12], A[11]&B[11], A[11]&B[10], A[11]&B[9], A[11]&B[8], A[11]&B[7], A[11]&B[6], A[11]&B[5], A[11]&B[4], A[11]&B[3], A[11]&B[2], A[11]&B[1], A[11]&B[0]};


Augend11= { Carry10[15], Sum10[15], Sum10[14], Sum10[13], Sum10[12], Sum10[11], Sum10[10], Sum10[9], Sum10[8], Sum10[7], Sum10[6], Sum10[5], Sum10[4], Sum10[3], Sum10[2], Sum10[1]};
Addend11= { A[12]&B[15], A[12]&B[14], A[12]&B[13], A[12]&B[12], A[12]&B[11], A[12]&B[10], A[12]&B[9], A[12]&B[8], A[12]&B[7], A[12]&B[6], A[12]&B[5], A[12]&B[4], A[12]&B[3], A[12]&B[2], A[12]&B[1], A[12]&B[0]};


Augend12= { Carry11[15], Sum11[15], Sum11[14], Sum11[13], Sum11[12], Sum11[11], Sum11[10], Sum11[9], Sum11[8], Sum11[7], Sum11[6], Sum11[5], Sum11[4], Sum11[3], Sum11[2], Sum11[1]};
Addend12= { A[13]&B[15], A[13]&B[14], A[13]&B[13], A[13]&B[12], A[13]&B[11], A[13]&B[10], A[13]&B[9], A[13]&B[8], A[13]&B[7], A[13]&B[6], A[13]&B[5], A[13]&B[4], A[13]&B[3], A[13]&B[2], A[13]&B[1], A[13]&B[0]};


Augend13= { Carry12[15], Sum12[15], Sum12[14], Sum12[13], Sum12[12], Sum12[11], Sum12[10], Sum12[9], Sum12[8], Sum12[7], Sum12[6], Sum12[5], Sum12[4], Sum12[3], Sum12[2], Sum12[1]};
Addend13= { A[14]&B[15], A[14]&B[14], A[14]&B[13], A[14]&B[12], A[14]&B[11], A[14]&B[10], A[14]&B[9], A[14]&B[8], A[14]&B[7], A[14]&B[6], A[14]&B[5], A[14]&B[4], A[14]&B[3], A[14]&B[2], A[14]&B[1], A[14]&B[0]};


Augend14= { Carry13[15], Sum13[15], Sum13[14], Sum13[13], Sum13[12], Sum13[11], Sum13[10], Sum13[9], Sum13[8], Sum13[7], Sum13[6], Sum13[5], Sum13[4], Sum13[3], Sum13[2], Sum13[1]};
Addend14= { A[15]&B[15], A[15]&B[14], A[15]&B[13], A[15]&B[12], A[15]&B[11], A[15]&B[10], A[15]&B[9], A[15]&B[8], A[15]&B[7], A[15]&B[6], A[15]&B[5], A[15]&B[4], A[15]&B[3], A[15]&B[2], A[15]&B[1], A[15]&B[0]};

//$display("%b %b", C[2], C[1]);
C[0]=  A[0]&B[0];//From Gates
//=================================  
C[1]=  Sum0[0];//From Adder0
//=================================
C[2]=  Sum1[0];//From Adder1
//=================================
C[3] = Sum2[0];//From Adder2
C[4] = Sum3[0];//From Adder3
C[5] = Sum4[0];//From Adder4
C[6] = Sum5[0];//From Adder5
C[7] = Sum6[0];//From Adder2
C[8] = Sum7[0];
C[9] = Sum8[0];
C[10] = Sum9[0];
C[11] = Sum10[0];
C[12] = Sum11[0];
C[13] = Sum12[0];
C[14] = Sum13[0];
//---------------------------------
C[15] = Sum14[0];
C[16] = Sum14[1];
C[17] = Sum14[2];
C[18] = Sum14[3];
C[19] = Sum14[4];
C[20] = Sum14[5];
C[21] = Sum14[6];
C[22] = Sum14[7];
C[23] = Sum14[8];
C[24] = Sum14[9];
C[25] = Sum14[10];
C[26] = Sum14[11];
C[27] = Sum14[12];
C[28] = Sum14[13];
C[29] = Sum14[14];
C[30] = Sum14[15];
C[31] = Carry14[15];
end
endmodule

//OPCODE = 0101
module Divider(A, B, C, err);
input [15:0] A;
input [15:0] B;
output[15:0] C;
output err;

wire [15:0] A;
wire [15:0] B;
reg [15:0] C;
reg err;

always@(*)
begin
	err = 0;

	if (B==0)
		begin
			err = 1;
			//$write("ERROR DIVIDE %b", err);
		end
	else
		begin
			C = A / B;
		end
end

endmodule

//OPCODE = 0110
module Modder(A, B, C, err);
input [15:0] A;
input [15:0] B;
output[15:0] C;
output err;

wire [15:0] A;
wire [15:0] B;
reg [15:0] C;
reg err;

always@(*)
begin
	assign err = 0;

	if (B==0)
		begin
			assign err = 1;
		end
	else
		begin
			C = A % B;
		end
end

endmodule

module StructMux(channels, select, b);
input [15:0][31:0] channels;
input      [15:0] select;
output      [31:0] b;


	assign b = ({32{select[15]}} & channels[15]) | //PRESET
               ({32{select[14]}} & channels[14]) |
			   ({32{select[13]}} & channels[13]) | //XOR
			   ({32{select[12]}} & channels[12]) | //XNOR
			   ({32{select[11]}} & channels[11]) | //OR
			   ({32{select[10]}} & channels[10]) | //NOT
			   ({32{select[ 9]}} & channels[ 9]) | //NOR
			   ({32{select[ 8]}} & channels[ 8]) | //NAND
			   ({32{select[ 7]}} & channels[ 7]) | //AND
			   ({32{select[ 6]}} & channels[ 6]) | //MOD
			   ({32{select[ 5]}} & channels[ 5]) | //DIVIDE
			   ({32{select[ 4]}} & channels[ 4]) | //MULTIPLY
			   ({32{select[ 3]}} & channels[ 3]) | //SUBTRACT
			   ({32{select[ 2]}} & channels[ 2]) | //ADD
               ({32{select[ 1]}} & channels[ 1]) | //RESET
               ({32{select[ 0]}} & channels[ 0]) ; //NO-OP

endmodule

module breadboard(clk, A, C, opcode, error);
input clk;
input [15:0] A;
input [3:0] opcode;
wire [15:0] A;
wire [3:0] opcode;

output [1:0]error;
reg [1:0]error;
//----------------------------------
output [31:0] C;
reg [31:0] C;
//----------------------------------
wire [15:0][31:0] channels;
wire [15:0] select;
wire [31:0] b;

wire[15:0] outputADD;
wire[31:0] outputMULT;
wire[15:0] outputDIV;
wire[15:0] outputMOD;
wire addError;
wire divError;

wire [15:0] unknown;

reg [15:0] regA;
reg [15:0] regB;

reg [31:0] next;
wire [31:0] cur;

Dec4x16 dec1(opcode, select);
StructMux mux1(channels, select, b);
AddSub adder(A, B, opcode[0], outputADD, addError);
Multiplier mult(A, B, outputMULT);
Divider div(A, B, outputDIV, divError);
Modder mod(A, B, outputMOD, divError);

DFF ACC1 [31:0] (clk, next, cur);


assign channels[ 0]=cur; //NO-OP
assign channels[ 1]={32'b0}; //RESET
assign channels[ 2]={16'b0000,outputADD};
assign channels[ 3]={16'b0000,outputADD};
assign channels[ 4]=outputMULT;
assign channels[ 5]={16'b0000,outputDIV};
assign channels[ 6]={16'b0000,outputMOD};
assign channels[ 7]={16'b0000,unknown}; //AND
assign channels[ 8]={16'b0000,unknown}; //NAND
assign channels[ 9]={16'b0000,unknown}; //NOR
assign channels[10]={16'b0000,unknown}; //NOT
assign channels[11]={16'b0000,unknown}; //OR
assign channels[12]={16'b0000,unknown}; //XNOR
assign channels[13]={16'b0000,unknown}; //XOR
assign channels[14]={16'b0000,unknown};
assign channels[15]={32'b1}; //PRESET


always@(*)
begin
	regA= A;
	regB= cur[15:0]; //to get the lower two bytes...
	//high bytes=cur[31:16]
	//low bytes=cur[15:0]
	
	if (opcode==4'b1)
	begin
		error=0;
	end

	assign next=b;
	assign error = {divError, addError};
	assign C=b;
end

endmodule

module testbench();
	reg clk;

	//Data Inputs
	reg [15:0]dataA;
	reg [15:0]dataB;
	reg [3:0]op;
	wire [1:0]err;

	//Outputs
	wire[31:0]result;



	//Instantiate the Modules
	breadboard m (clk, dataA, dataB, result, op, err);


//=================================================
 //CLOCK Thread
 //=================================================
   initial begin //Start Clock Thread
     forever //While TRUE
        begin //Do Clock Procedural
          clk=0; //square wave is low
          #5; //half a wave is 5 time units
          clk=1;//square wave is high
          #5; //half a wave is 5 time units
		  $display("Tick");
        end
    end

//=================================================
// Display Thread
//=================================================

    initial begin //Start Output Thread
	forever
         begin
 
		 
		 case (opcode)
		 0: $display("%16b ==> %32b         , NO-OP",bb8.cur,bb8.b);
		 1: $display("%16b ==> %32b         , RESET",16'b0000,bb8.b);
		 5: $display("%16b  +  %16b = %16b  , ADD"  ,bb8.cur,inputA,bb8.b);
		 9: $display("%16b AND %16b = %16b  , AND"  ,bb8.cur,inputA,bb8.b);
		 endcase
		 
		 #10;
		 end
	end

//=================================================
//STIMULOUS Thread
//=================================================
initial begin
#6;
inputA=16'b0000000000000000;


end
endmodule
