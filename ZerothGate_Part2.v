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

module AddSub(inputA,inputB,mode,sum,carry,overflow);
    input [15:0] inputA;
	input [15:0] inputB;
    input mode;
    output [15:0] sum;
	output carry;
    output overflow;

	wire c0; //Mode assigned to C0

    wire b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15; //XOR Interfaces
	wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16; //Carry Interfaces

	assign c0=mode;//Mode=0, Addition; Mode=1, Subtraction

    assign b0 = inputB[0] ^ mode;//Flip the Bit if Subtraction
    assign b1 = inputB[1] ^ mode;//Flip the Bit if Subtraction
    assign b2 = inputB[2] ^ mode;//Flip the Bit if Subtraction
    assign b3 = inputB[3] ^ mode;//Flip the Bit if Subtraction
	assign b4 = inputB[4] ^ mode;//Flip the Bit if Subtraction
    assign b5 = inputB[5] ^ mode;//Flip the Bit if Subtraction
    assign b6 = inputB[6] ^ mode;//Flip the Bit if Subtraction
    assign b7 = inputB[7] ^ mode;//Flip the Bit if Subtraction
	assign b8 = inputB[8] ^ mode;//Flip the Bit if Subtraction
    assign b9 = inputB[9] ^ mode;//Flip the Bit if Subtraction
    assign b10 = inputB[10] ^ mode;//Flip the Bit if Subtraction
    assign b11 = inputB[11] ^ mode;//Flip the Bit if Subtraction
	assign b12 = inputB[12] ^ mode;//Flip the Bit if Subtraction
    assign b13 = inputB[13] ^ mode;//Flip the Bit if Subtraction
    assign b14 = inputB[14] ^ mode;//Flip the Bit if Subtraction
    assign b15 = inputB[15] ^ mode;//Flip the Bit if Subtraction



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




	assign carry=c16;
	assign overflow=c16^ c15;

endmodule

module Mux16Bit(channels, select, b);
input [31:0][15:0] channels;
input      [31:0] select;
output     [15:0] b;


	assign b = ({16{select[31]}} & channels[31]) | 
               ({16{select[30]}} & channels[30]) |
			   ({16{select[29]}} & channels[29]) |
			   ({16{select[28]}} & channels[28]) |
			   ({16{select[27]}} & channels[27]) |
			   ({16{select[26]}} & channels[26]) |
			   ({16{select[25]}} & channels[25]) |
			   ({16{select[24]}} & channels[24]) |
			   ({16{select[23]}} & channels[23]) |
			   ({16{select[22]}} & channels[22]) |
			   ({16{select[21]}} & channels[21]) |
			   ({16{select[20]}} & channels[20]) |
			   ({16{select[19]}} & channels[19]) |
			   ({16{select[18]}} & channels[18]) |
               ({16{select[17]}} & channels[17]) |
               ({16{select[16]}} & channels[16]) |
			   ({16{select[15]}} & channels[15]) | 
               ({16{select[14]}} & channels[14]) |
			   ({16{select[13]}} & channels[13]) |
			   ({16{select[12]}} & channels[12]) |
			   ({16{select[11]}} & channels[11]) |
			   ({16{select[10]}} & channels[10]) |
			   ({16{select[ 9]}} & channels[ 9]) |
			   ({16{select[ 8]}} & channels[ 8]) |
			   ({16{select[ 7]}} & channels[ 7]) |
			   ({16{select[ 6]}} & channels[ 6]) |
			   ({16{select[ 5]}} & channels[ 5]) |
			   ({16{select[ 4]}} & channels[ 4]) |
			   ({16{select[ 3]}} & channels[ 3]) |
			   ({16{select[ 2]}} & channels[ 2]) |
               ({16{select[ 1]}} & channels[ 1]) |
               ({16{select[ 0]}} & channels[ 0]) ;

endmodule

//----------------------------------------------------------------------                              //Module End
module Bit16Mult(A,B,C);
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

wire [15:0] overflow;

AddSub add0(Augend0,Addend0,1'b0,Sum0,Carry0,overflow);
AddSub add1(Augend1,Addend1,1'b0,Sum1,Carry1,overflow);
AddSub add2(Augend2,Addend2,1'b0,Sum2,Carry2,overflow);
AddSub add3(Augend3,Addend3,1'b0,Sum3,Carry3,overflow);

AddSub add4(Augend4,Addend4,1'b0,Sum4,Carry4,overflow);
AddSub add5(Augend5,Addend5,1'b0,Sum5,Carry5,overflow);
AddSub add6(Augend6,Addend6,1'b0,Sum6,Carry6,overflow);
AddSub add7(Augend7,Addend7,1'b0,Sum7,Carry7,overflow);

AddSub add8(Augend8,Addend8,1'b0,Sum8,Carry8,overflow);
AddSub add9(Augend9,Addend9,1'b0,Sum9,Carry9,overflow);
AddSub add10(Augend10,Addend10,1'b0,Sum10,Carry10,overflow);
AddSub add11(Augend11,Addend11,1'b0,Sum11,Carry11,overflow);

AddSub add12(Augend12,Addend12,1'b0,Sum12,Carry12,overflow);
AddSub add13(Augend13,Addend13,1'b0,Sum13,Carry13,overflow);
AddSub add14(Augend14,Addend14,1'b0,Sum14,Carry14,overflow);
AddSub add15(Augend15,Addend15,1'b0,Sum15,Carry15,overflow);

Addend0= { A[0]&B[15], A[0]&B[14], A[0]&B[13], A[0]&B[12], A[0]&B[11], A[0]&B[10], A[0]&B[9], A[0]&B[8], A[0]&B[7], A[0]&B[6], A[0]&B[5], A[0]&B[4], A[0]&B[3], A[0]&B[2], A[0]&B[1], A[0]&B[0]};


Augend1= { Carry0[15], Sum0[15], Sum0[14], Sum0[13], Sum0[12], Sum0[11], Sum0[10], Sum0[9], Sum0[8], Sum0[7], Sum0[6], Sum0[5], Sum0[4], Sum0[3], Sum0[2], Sum0[1]};
Addend1= { A[1]&B[15], A[1]&B[14], A[1]&B[13], A[1]&B[12], A[1]&B[11], A[1]&B[10], A[1]&B[9], A[1]&B[8], A[1]&B[7], A[1]&B[6], A[1]&B[5], A[1]&B[4], A[1]&B[3], A[1]&B[2], A[1]&B[1], A[1]&B[0]};


augend2= { Carry1[15], Sum1[15], Sum1[14], Sum1[13], Sum1[12], Sum1[11], Sum1[10], Sum1[9], Sum1[8], Sum1[7], Sum1[6], Sum1[5], Sum1[4], Sum1[3], Sum1[2], Sum1[1]};
addend2= { A[2]&B[15], A[2]&B[14], A[2]&B[13], A[2]&B[12], A[2]&B[11], A[2]&B[10], A[2]&B[9], A[2]&B[8], A[2]&B[7], A[2]&B[6], A[2]&B[5], A[2]&B[4], A[2]&B[3], A[2]&B[2], A[2]&B[1], A[2]&B[0]};


augend3= { Carry2[15], Sum2[15], Sum2[14], Sum2[13], Sum2[12], Sum2[11], Sum2[10], Sum2[9], Sum2[8], Sum2[7], Sum2[6], Sum2[5], Sum2[4], Sum2[3], Sum2[2], Sum2[1]};
addend3= { A[3]&B[15], A[3]&B[14], A[3]&B[13], A[3]&B[12], A[3]&B[11], A[3]&B[10], A[3]&B[9], A[3]&B[8], A[3]&B[7], A[3]&B[6], A[3]&B[5], A[3]&B[4], A[3]&B[3], A[3]&B[2], A[3]&B[1], A[3]&B[0]};


augend4= { Carry3[15], Sum3[15], Sum3[14], Sum3[13], Sum3[12], Sum3[11], Sum3[10], Sum3[9], Sum3[8], Sum3[7], Sum3[6], Sum3[5], Sum3[4], Sum3[3], Sum3[2], Sum3[1]};
addend4= { A[4]&B[15], A[4]&B[14], A[4]&B[13], A[4]&B[12], A[4]&B[11], A[4]&B[10], A[4]&B[9], A[4]&B[8], A[4]&B[7], A[4]&B[6], A[4]&B[5], A[4]&B[4], A[4]&B[3], A[4]&B[2], A[4]&B[1], A[4]&B[0]};


augend5= { Carry4[15], Sum4[15], Sum4[14], Sum4[13], Sum4[12], Sum4[11], Sum4[10], Sum4[9], Sum4[8], Sum4[7], Sum4[6], Sum4[5], Sum4[4], Sum4[3], Sum4[2], Sum4[1]};
addend5= { A[5]&B[15], A[5]&B[14], A[5]&B[13], A[5]&B[12], A[5]&B[11], A[5]&B[10], A[5]&B[9], A[5]&B[8], A[5]&B[7], A[5]&B[6], A[5]&B[5], A[5]&B[4], A[5]&B[3], A[5]&B[2], A[5]&B[1], A[5]&B[0]};


augend6= { Carry5[15], Sum5[15], Sum5[14], Sum5[13], Sum5[12], Sum5[11], Sum5[10], Sum5[9], Sum5[8], Sum5[7], Sum5[6], Sum5[5], Sum5[4], Sum5[3], Sum5[2], Sum5[1]};
addend6= { A[6]&B[15], A[6]&B[14], A[6]&B[13], A[6]&B[12], A[6]&B[11], A[6]&B[10], A[6]&B[9], A[6]&B[8], A[6]&B[7], A[6]&B[6], A[6]&B[5], A[6]&B[4], A[6]&B[3], A[6]&B[2], A[6]&B[1], A[6]&B[0]};


augend7= { Carry6[15], Sum6[15], Sum6[14], Sum6[13], Sum6[12], Sum6[11], Sum6[10], Sum6[9], Sum6[8], Sum6[7], Sum6[6], Sum6[5], Sum6[4], Sum6[3], Sum6[2], Sum6[1]};
addend7= { A[7]&B[15], A[7]&B[14], A[7]&B[13], A[7]&B[12], A[7]&B[11], A[7]&B[10], A[7]&B[9], A[7]&B[8], A[7]&B[7], A[7]&B[6], A[7]&B[5], A[7]&B[4], A[7]&B[3], A[7]&B[2], A[7]&B[1], A[7]&B[0]};


augend8= { Carry7[15], Sum7[15], Sum7[14], Sum7[13], Sum7[12], Sum7[11], Sum7[10], Sum7[9], Sum7[8], Sum7[7], Sum7[6], Sum7[5], Sum7[4], Sum7[3], Sum7[2], Sum7[1]};
addend8= { A[8]&B[15], A[8]&B[14], A[8]&B[13], A[8]&B[12], A[8]&B[11], A[8]&B[10], A[8]&B[9], A[8]&B[8], A[8]&B[7], A[8]&B[6], A[8]&B[5], A[8]&B[4], A[8]&B[3], A[8]&B[2], A[8]&B[1], A[8]&B[0]};


augend9= { Carry8[15], Sum8[15], Sum8[14], Sum8[13], Sum8[12], Sum8[11], Sum8[10], Sum8[9], Sum8[8], Sum8[7], Sum8[6], Sum8[5], Sum8[4], Sum8[3], Sum8[2], Sum8[1]};
addend9= { A[9]&B[15], A[9]&B[14], A[9]&B[13], A[9]&B[12], A[9]&B[11], A[9]&B[10], A[9]&B[9], A[9]&B[8], A[9]&B[7], A[9]&B[6], A[9]&B[5], A[9]&B[4], A[9]&B[3], A[9]&B[2], A[9]&B[1], A[9]&B[0]};


augend10= { Carry9[15], Sum9[15], Sum9[14], Sum9[13], Sum9[12], Sum9[11], Sum9[10], Sum9[9], Sum9[8], Sum9[7], Sum9[6], Sum9[5], Sum9[4], Sum9[3], Sum9[2], Sum9[1]};
addend10= { A[10]&B[15], A[10]&B[14], A[10]&B[13], A[10]&B[12], A[10]&B[11], A[10]&B[10], A[10]&B[9], A[10]&B[8], A[10]&B[7], A[10]&B[6], A[10]&B[5], A[10]&B[4], A[10]&B[3], A[10]&B[2], A[10]&B[1], A[10]&B[0]};


augend11= { Carry10[15], Sum10[15], Sum10[14], Sum10[13], Sum10[12], Sum10[11], Sum10[10], Sum10[9], Sum10[8], Sum10[7], Sum10[6], Sum10[5], Sum10[4], Sum10[3], Sum10[2], Sum10[1]};
addend11= { A[11]&B[15], A[11]&B[14], A[11]&B[13], A[11]&B[12], A[11]&B[11], A[11]&B[10], A[11]&B[9], A[11]&B[8], A[11]&B[7], A[11]&B[6], A[11]&B[5], A[11]&B[4], A[11]&B[3], A[11]&B[2], A[11]&B[1], A[11]&B[0]};


augend12= { Carry11[15], Sum11[15], Sum11[14], Sum11[13], Sum11[12], Sum11[11], Sum11[10], Sum11[9], Sum11[8], Sum11[7], Sum11[6], Sum11[5], Sum11[4], Sum11[3], Sum11[2], Sum11[1]};
addend12= { A[12]&B[15], A[12]&B[14], A[12]&B[13], A[12]&B[12], A[12]&B[11], A[12]&B[10], A[12]&B[9], A[12]&B[8], A[12]&B[7], A[12]&B[6], A[12]&B[5], A[12]&B[4], A[12]&B[3], A[12]&B[2], A[12]&B[1], A[12]&B[0]};


augend13= { Carry12[15], Sum12[15], Sum12[14], Sum12[13], Sum12[12], Sum12[11], Sum12[10], Sum12[9], Sum12[8], Sum12[7], Sum12[6], Sum12[5], Sum12[4], Sum12[3], Sum12[2], Sum12[1]};
addend13= { A[13]&B[15], A[13]&B[14], A[13]&B[13], A[13]&B[12], A[13]&B[11], A[13]&B[10], A[13]&B[9], A[13]&B[8], A[13]&B[7], A[13]&B[6], A[13]&B[5], A[13]&B[4], A[13]&B[3], A[13]&B[2], A[13]&B[1], A[13]&B[0]};


augend14= { Carry13[15], Sum13[15], Sum13[14], Sum13[13], Sum13[12], Sum13[11], Sum13[10], Sum13[9], Sum13[8], Sum13[7], Sum13[6], Sum13[5], Sum13[4], Sum13[3], Sum13[2], Sum13[1]};
addend14= { A[14]&B[15], A[14]&B[14], A[14]&B[13], A[14]&B[12], A[14]&B[11], A[14]&B[10], A[14]&B[9], A[14]&B[8], A[14]&B[7], A[14]&B[6], A[14]&B[5], A[14]&B[4], A[14]&B[3], A[14]&B[2], A[14]&B[1], A[14]&B[0]};


augend15= { Carry14[15], Sum14[15], Sum14[14], Sum14[13], Sum14[12], Sum14[11], Sum14[10], Sum14[9], Sum14[8], Sum14[7], Sum14[6], Sum14[5], Sum14[4], Sum14[3], Sum14[2], Sum14[1]};
addend15= { A[15]&B[15], A[15]&B[14], A[15]&B[13], A[15]&B[12], A[15]&B[11], A[15]&B[10], A[15]&B[9], A[15]&B[8], A[15]&B[7], A[15]&B[6], A[15]&B[5], A[15]&B[4], A[15]&B[3], A[15]&B[2], A[15]&B[1], A[15]&B[0]};

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
  c[8] = Sum7[0];
  C[9] = Sum8[0];

  C[15] = Carry15[15]
endmodule
//----------------------------------------------------------------------

module testbench();


//Data Inputs
reg [15:0]dataA;
reg [15:0]dataB;
reg [0:0]mode;
reg [3:0]opcode;

//Outputs
wire [31:0]result; //32 bits
wire carry;
wire err; //2 bits

//Instantiate the Modules
AddSub addsub(dataA,dataB,mode,result,carry,err);


initial
begin
//        0123456789ABCDEF
$display("Addition");
mode=0;
dataA=16'b1111111111111111;
dataB=16'b1111111111111111;
#100;
$write("mode=%b; ",mode);
$write("%b+%b=[%b][%b]; ",dataA,dataB,carry,result);
$write("%d+%d=[%d][%d]; ",dataA,dataB,carry,result);
$display("err=%b",err);

end




endmodule
