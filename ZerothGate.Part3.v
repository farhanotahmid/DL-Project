//=============================================
// D Flip Flop
//=============================================
module DFF(clk,in,out);
	input   clk;
	input   in;
	output  out;
	reg     out;

	always @(posedge clk)
	begin
		out = in;
	end
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

    assign b0 = inputA[0] ^ mode;//Flip the Bit if Subtraction
    assign b1 = inputA[1] ^ mode;//Flip the Bit if Subtraction
    assign b2 = inputA[2] ^ mode;//Flip the Bit if Subtraction
    assign b3 = inputA[3] ^ mode;//Flip the Bit if Subtraction
	assign b4 = inputA[4] ^ mode;//Flip the Bit if Subtraction
	assign b5 = inputA[5] ^ mode;
	assign b6 = inputA[6] ^ mode;
	assign b7 = inputA[7] ^ mode;

	assign b8 = inputA[8] ^ mode;
	assign b9 = inputA[9] ^ mode;
	assign b10 = inputA[10] ^ mode;
	assign b11 = inputA[11] ^ mode;
	assign b12 = inputA[12] ^ mode;
	assign b13 = inputA[13] ^ mode;
	assign b14 = inputA[14] ^ mode;
	assign b15 = inputB[15] ^ mode;



	FullAdder FA0(inputB[0],b0,  c0,c1,sum[0]);
	FullAdder FA1(inputB[1],b1,  c1,c2,sum[1]);
	FullAdder FA2(inputB[2],b2,  c2,c3,sum[2]);
	FullAdder FA3(inputB[3],b3,  c3,c4,sum[3]);
	FullAdder FA4(inputB[4],b4,  c4,c5,sum[4]);
	FullAdder FA5(inputB[5],b5,  c5,c6,sum[5]);
	FullAdder FA6(inputB[6],b6,  c6,c7,sum[6]);
	FullAdder FA7(inputB[7],b7,  c7,c8,sum[7]);

	FullAdder FA8(inputB[8],b8,  c8,c9,sum[8]);
	FullAdder FA9(inputB[9],b9,  c9,c10,sum[9]);
	FullAdder FA10(inputB[10],b10,  c10,c11,sum[10]);
	FullAdder FA11(inputB[11],b11,  c11,c12,sum[11]);
	FullAdder FA12(inputB[12],b12,  c12,c13,sum[12]);
	FullAdder FA13(inputB[13],b13,  c13,c14,sum[13]);
	FullAdder FA14(inputB[14],b14,  c14,c15,sum[14]);
	FullAdder FA15(inputB[15],b15,  c15,c16,sum[15]);

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

wire [31:0] C;
// TO TEAM: Algorithm used: https://en.wikipedia.org/wiki/Binary_multiplier#Unsigned_integers PLEASE CHECK IF YOU DONT UNDERSTAND
//Local Variables
wire [15:0] p0 = {16{A[0]}} & B;
wire [15:0] p1 = {16{A[1]}} & B;
wire [15:0] p2 = {16{A[2]}} & B;
wire [15:0] p3 = {16{A[3]}} & B;
wire [15:0] p4 = {16{A[4]}} & B;
wire [15:0] p5 = {16{A[5]}} & B;
wire [15:0] p6 = {16{A[6]}} & B;
wire [15:0] p7 = {16{A[7]}} & B;
wire [15:0] p8 = {16{A[8]}} & B;
wire [15:0] p9 = {16{A[9]}} & B;
wire [15:0] p10 = {16{A[10]}} & B;
wire [15:0] p11 = {16{A[11]}} & B;
wire [15:0] p12 = {16{A[12]}} & B;
wire [15:0] p13 = {16{A[13]}} & B;
wire [15:0] p14 = {16{A[14]}} & B;
wire [15:0] p15 = {16{A[15]}} & B;

wire [15:0][31:0] sums;
wire [15:0] carrys;


SixteenBitFullAdder add0({1'b0,p0[15:1]}, 		p1,	1'b0,	carrys[0], 		sums[0]);
SixteenBitFullAdder add1({1'b0,sums[0][15:1]},	p2,	1'b0,	carrys[1],  	sums[1]);
SixteenBitFullAdder add2({1'b0,sums[1][15:1]},	p3,	1'b0,	carrys[2],  	sums[2]);
SixteenBitFullAdder add3({1'b0,sums[2][15:1]},	p4,	1'b0,	carrys[3],  	sums[3]);

SixteenBitFullAdder add4({1'b0,sums[3][15:1]},	p5,	1'b0,	carrys[4],  	sums[4]);
SixteenBitFullAdder add5({1'b0,sums[4][15:1]},	p6,	1'b0,	carrys[5],  	sums[5]);
SixteenBitFullAdder add6({1'b0,sums[5][15:1]},	p7,	1'b0,	carrys[6],  	sums[6]);
SixteenBitFullAdder add7({1'b0,sums[6][15:1]},	p8,	1'b0,	carrys[7],  	sums[7]);

SixteenBitFullAdder add8({1'b0,sums[7][15:1]},	p9,	1'b0,	carrys[8],  	sums[8]);
SixteenBitFullAdder add9({1'b0,sums[8][15:1]},	p10,1'b0,	carrys[9],  	sums[9]);
SixteenBitFullAdder add10({1'b0,sums[9][15:1]},	p11,1'b0,	carrys[10],  	sums[10]);
SixteenBitFullAdder add11({1'b0,sums[10][15:1]},p12,1'b0,	carrys[11],  	sums[11]);

SixteenBitFullAdder add12({1'b0,sums[11][15:1]},p13,1'b0,	carrys[12],  	sums[12]);
SixteenBitFullAdder add13({1'b0,sums[12][15:1]},p14,1'b0,	carrys[13],  	sums[13]);
SixteenBitFullAdder add14({1'b0,sums[13][15:1]},p15,1'b0,	carrys[14],  	sums[14]);

//$display("%b %b", C[2], C[1]);
assign C[0]=  p0[0];
//=================================
assign C[1]=  sums[0][0];
//=================================
assign C[2]=  sums[1][0];//From Adder1
//=================================
assign C[3] = sums[2][0];
assign C[4] = sums[3][0];
assign C[5] = sums[4][0];
assign C[6] = sums[5][0];
assign C[7] = sums[6][0];
assign C[8] = sums[7][0];
assign C[9] = sums[8][0];
assign C[10] = sums[9][0];
assign C[11] = sums[10][0];
assign C[12] = sums[11][0];
assign C[13] = sums[12][0];
assign C[14] = sums[13][0];
//---------------------------------
assign C[15] = sums[14][0];
assign C[16] = sums[14][1];
assign C[17] = sums[14][2];
assign C[18] = sums[14][3];
assign C[19] = sums[14][4];
assign C[20] = sums[14][5];
assign C[21] = sums[14][6];
assign C[22] = sums[14][7];
assign C[23] = sums[14][8];
assign C[24] = sums[14][9];
assign C[25] = sums[14][10];
assign C[26] = sums[14][11];
assign C[27] = sums[14][12];
assign C[28] = sums[14][13];
assign C[29] = sums[14][14];
assign C[30] = sums[14][15];
assign C[31] = sums[14][16];
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
			C = B / A;
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
			C = B % A;
		end
end

endmodule

//OPCODE 0111
module And16(A, B, C);
input [15:0] A;
input [15:0] B;
output[15:0] C;

wire [15:0] A;
wire [15:0] B;
reg [15:0] C;

always@(*)
	begin
		assign C = B & A;
	end
endmodule

//OPCODE 1000
module Nand16(A, B, C);
input [15:0] A;
input [15:0] B;
output[15:0] C;

wire [15:0] A;
wire [15:0] B;
reg [15:0] C;

always@(*)
	begin
		assign C = ~(B & A);
	end
endmodule

//OPCODE 1001
module Nor16(A, B, C);
input [15:0] A;
input [15:0] B;
output[15:0] C;

wire [15:0] A;
wire [15:0] B;
reg [15:0] C;

always@(*)
	begin
		assign C = ~(B | C);
	end
endmodule

//OPCODE 1010
module Not16(B, C);
input [15:0] B;
output[15:0] C;

wire [15:0] B;
reg [15:0] C;

always@(*)
	begin
		assign C =~ B;
	end
endmodule


//OPCODE 1011
module Or16(A, B, C);
input [15:0] A;
input [15:0] B;
output[15:0] C;

wire [15:0] A;
wire [15:0] B;
reg [15:0] C;

always@(*)
	begin
		assign C = B | A;
	end
endmodule

//OPCODE 1100
module Xnor16(A, B, C);
input [15:0] A;
input [15:0] B;
output[15:0] C;

wire [15:0] A;
wire [15:0] B;
reg [15:0] C;

always@(*)
	begin
		assign C = ~(A ^ B);
	end
endmodule

//OPCODE 1101
module Xor16(A, B, C);
input [15:0] A;
input [15:0] B;
output[15:0] C;

wire [15:0] A;
wire [15:0] B;
reg [15:0] C;

always@(*)
	begin
		assign C = B ^ A;
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

//Arithmetic Results
wire[15:0] outputADD;
wire[31:0] outputMULT;
wire[15:0] outputDIV;
wire[15:0] outputMOD;

//Logic Results
wire[15:0] outputAND;
wire[15:0] outputNAND;
wire[15:0] outputNOR;
wire[15:0] outputNOT;
wire[15:0] outputOR;
wire[15:0] outputXNOR;
wire[15:0] outputXOR;

wire addError;
wire divError;

wire [15:0] unknown;

reg [15:0] regA;
reg [15:0] regB;

reg [31:0] next;
wire [31:0] cur;

Dec4x16 dec1(opcode, select);
StructMux mux1(channels, select, b);
AddSub adder(regA, regB, opcode[0], outputADD, addError);
Multiplier mult(regA, regB, outputMULT);
Divider div(regA, regB, outputDIV, divError);
Modder mod(regA, regB, outputMOD, divError);

And16 ander(regA, regB, outputAND);
Nand16 nander(regA, regB, outputNAND);
Nor16 norer(regA, regB, outputNOR);
Not16 noter(regB, outputNOT);
Or16 orer(regA, regB, outputOR);
Xor16 xorer(regA, regB, outputXOR);
Xnor16 xnorer(regA, regB, outputXNOR);

//Register
DFF ACC1 [31:0] (clk, next, cur);


assign channels[ 0]=regB; //NO-OP
assign channels[ 1]={32'b0}; //RESET
assign channels[ 2]={16'b0000,outputADD};
assign channels[ 3]={16'b0000,outputADD};
assign channels[ 4]=outputMULT;
assign channels[ 5]={16'b0000,outputDIV};
assign channels[ 6]={16'b0000,outputMOD};
assign channels[ 7]={16'b0000,outputAND}; //AND
assign channels[ 8]={16'b0000,outputNAND}; //NAND
assign channels[ 9]={16'b0000,outputNOR}; //NOR
assign channels[10]={16'b0000,outputNOT}; //NOT
assign channels[11]={16'b0000,outputOR}; //OR
assign channels[12]={16'b0000,outputXNOR}; //XNOR
assign channels[13]={16'b0000,outputXOR}; //XOR
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
	reg [15:0]inputA;
	reg [15:0]dataB;
	reg [3:0]op;
	wire [1:0]err;

	//Outputs
	wire[31:0]result;

	reg [31:0] fraction;
	reg [31:0] whole;
	reg [31:0] hold;


	//Instantiate the Modules
	breadboard board (clk, inputA, result, op, err);


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


		 case (op)
		 0: $display("Input:%16b Feedback:%16b NO-OP Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 1: $display("Input:%16b Feedback:%16b RESET Opcode:%4b Output %32b Err:%2b",16'b0000,board.regB, op, board.b, err);
		 2: $display("Input:%16b Feedback:%16b ADD Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 3: $display("Input:%16b Feedback:%16b SUB Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 4: $display("Input:%16b Feedback:%16b MUL Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 5: $display("Input:%16b Feedback:%16b DIV Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 6: $display("Input:%16b Feedback:%16b MOD Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 7: $display("Input:%16b Feedback:%16b AND Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 8: $display("Input:%16b Feedback:%16b NAND Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 9: $display("Input:%16b Feedback:%16b NOR Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 10: $display("Input:%16b Feedback:%16b NOT Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 11: $display("Input:%16b Feedback:%16b OR Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 12: $display("Input:%16b Feedback:%16b XNOR Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 13: $display("Input:%16b Feedback:%16b XOR Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);
		 15: $display("Input:%16b Feedback:%16b PRESET Opcode:%4b Output:%32b Err:%2b",inputA, board.regB, op, board.b, err);

		 endcase

		 #10;
		 end
	end

//=================================================
//STIMULOUS Thread
//=================================================
initial begin

//=================================================
//STIMULOUS Thread
//=================================================

	#6;
	$display("Volume of a square pyramid: a^2 * (h/3)");
	//RESET
	inputA=16'b0000000000000000;
	op=4'b0001;
	#10;
	$display("result: %2d", result);
	//---------------------------------
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b0000;//NO-OP
	#10;
	//---------------------------------
	//Add 221
	inputA=16'b0000000011011101;
	op=4'b0010;
	#10;
	$display("result: %2d", result);
	//---------------------------------
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b0000;
	#10;
	//---------------------------------
	//Multiply by 221/ square
	inputA=16'b0000000011011101;
	op=4'b0100;
	#10;
	$display("result: %2d", result);
	//---------------------------------
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b0000;
	#10;
	//---------------------------------
	//Multiply by 57
	inputA=16'b0000000000111001;
	op=4'b0100;
	#10;
	$display("result: %2d", result);
	//---------------------------------
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b0000;
	#10;
	hold = result;
	//---------------------------------
	//Divide by 30
	inputA=16'b0000000000011110;
	op=4'b1011;
	#10;
	whole = result;
	$display("result: %2d", result);
	//---------------------------------
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b0000;
	#10;
	//---------------------------------
	//Reset
	inputA = 16'b0000000000000000;
	op = 4'b0001;
	#10;
	$display("result: %2d", result);
	//---------------------------------
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b0000;//NOT
	#10;
	//---------------------------------
	//Add hold var
	inputA = hold;
	op = 4'b0010;
	#10;
	$display("result: %2d", result);
	//---------------------------------
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b1010;//NOT
	#10;
	$display("result: %2d", result);
	//---------------------------------
	//Mod by 30
	inputA = 16'b0000000000011110;
	op = 4'b0010;
	#10;
	fraction = result;
	$display("result: %2d", result);
	//---------------------------------
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b1010;//NOT
	#10;
	$display("height 5.7 and side length 22.1 is %3d.%-2d.\n\n\n\n",whole,fraction);
	//dfgihuwefpoihsfd
	//
	//
	//
	//
	inputA=16'b0000000000000000;
	op=4'b0001;
	#10;
	$display("result: %2d", result);
	//---------------------------------
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b0000;//NO-OP
	#10;
	$display("result: %2d", result);
	//---------------------------------
	//Add 2
	inputA=16'd2;
	op=4'b0010;
	#10;
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b0000;//NO-OP
	#10;
	$display("result: %2d", result);
	//Multiply by 57
	inputA=16'b0000000000000010;
	op=4'b0100;
	#10;
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b0000;//NO-OP
	#10;
	$display("result: %2d", result);
	//Add 2
	inputA=16'd1;
	op=4'b0010;
	#10;
	//NO-OP
	inputA=16'b0000000000000000;
	op=4'b0000;//NO-OP
	#10;

//1100

	$finish;

end
endmodule
