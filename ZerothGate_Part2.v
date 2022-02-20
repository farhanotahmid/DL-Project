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
module AddSub(inputA,inputB,mode,sum,carry,overflow);
    input [15:0] inputA;
	input [15:0] inputB;
    input mode;
    output [31:0] sum;
	output carry;
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
endmodule
//----------------------------------------------------------------------
module Breadboard	(w,x,y,z,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9);  //Module Header
input w,x,y,z;                           //Specify inputs
output r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;                       //Specify outputs
reg r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;                            //Output is a memory area.
wire w,x,y,z;

always @ (w,x,y,z,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9) begin

//All function minterm equations
r0= (~w&~x&~y&z)|(~w&x&~y&z)|(~w&x&y&~z)|(w&~x&~y&~z)|(w&~x&~y&z)|(w&~x&y&~z)|(w&~x&y&z)|(w&x&~y&z)|(w&x&y&~z);

r1= (~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&y&~z)|(~w&x&y&z)|(w&~x&y&z)|(w&x&~y&~z)|(w&x&~y&z)|(w&x&y&~z)|(w&x&y&z);

r2= (~w&~x&~y&~z)|(~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&~y&z)|(~w&x&y&z)|(w&~x&~y&z)|(w&~x&y&~z)|(w&~x&y&z)|(w&x&~y&~z)|(w&x&y&z);

r3= (~w&~x&~y&z)|(~w&~x&y&~z)|(~w&~x&y&z)|(~w&x&~y&~z)|(w&~x&~y&~z)|(w&~x&~y&z)|(w&~x&y&z)|(w&x&~y&z);

r4 = (~w&~x&~y&~z)|(~w&~x&y&~z)|(~w&~x&y&z)|(~w&x&~y&z)|(~w&x&y&~z)|(~w&x&y&z)|(w&x&~y&~z)|(w&x&~y&z);

r5 = (~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&~y&z)|(~w&x&y&~z)|(~w&x&y&z)|(w&~x&~y&~z)|(w&x&~y&~z)|(w&x&y&~z)|(w&x&y&z);

r6 = (~w&~x&~y&z)|(~w&x&~y&~z)|(w&~x&~y&~z)|(w&~x&y&z)|(w&x&~y&~z)|(w&x&~y&z)|(w&x&y&~z)|(w&x&y&z);

r7 = (~w&~x&~y&~z)|(~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&y&z)|(w&~x&~y&~z)|(w&~x&~y&z)|(w&~x&y&z)|(w&x&y&~z);

r8= (~w&~x&~y&~z)|(~w&~x&y&~z)|(~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&~y&z)|(~w&x&y&~z)|(~w&x&y&z)|(w&~x&~y&z)|(w&x&~y&~z)|(w&x&~y&z);

r9 = (~w&~x&y&~z)|(~w&x&~y&z)|(~w&x&y&z)|(w&~x&~y&z)|(w&~x&y&~z)|(w&x&~y&~z)|(w&x&~y&z)|(w&x&y&z);

end                                       // Finish the Always block

endmodule                                 //Module End

//----------------------------------------------------------------------

module testbench();


//Data Inputs
reg [15:0]dataA;
reg [15:0]dataB;
reg [3:0]opcode;

//Outputs
wire result; //32 bits
wire carry;
wire err; //2 bits

//Instantiate the Modules
AddSub addsub(dataA,dataB,mode,result,carry,err);


initial
begin
//        0123456789ABCDEF
$display("Addition");
mode=0;
dataA=4'b0100;
dataB=4'b0010;
#100;
$write("mode=%b;",mode);
$write("%b+%b=[%b][%b];",dataA,dataB,carry,result);
$write("%d+%d=[%d][%d];",dataA,dataB,carry,result);
$display("err=%b",err);

end




endmodule
