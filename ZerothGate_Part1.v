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

  //Registers act like local variables
  reg [4:0] i; //A loop control for 16 rows of a truth table.
  reg  a;//Value of 2^3
  reg  b;//Value of 2^2
  reg  c;//Value of 2^1
  reg  d;//Value of 2^0
  
  //A wire can hold the return of a function
  wire  f0,f1,f2,f3,f4,f5,f6,f7,f8,f9;
  
  //Modules can be either functions, or model chips. 
  //They are instantiated like an object of a class, 
  //with a constructor with parameters.  They are not invoked,
  //but operate like a thread.
  Breadboard zap(a,b,c,d,f0,f1,f2, f3, f4, f5, f6, f7, f8, f9);
 
     
	 
  //Initial means "start," like a Main() function.
  //Begin denotes the start of a block of code.	
  initial begin
   	
  //$display acts like a java System.println command.
  $display ("|##|A|B|C|D|F0|F1|F2|F3|F4|F5|F6|F7|F8|F9|");
  $display ("|==+=+=+=+=+==+==+==+==+==+==+==+==+==+==|");
  
    //A for loop, with register i being the loop control variable.
	for (i = 0; i < 16; i = i + 1) 
	begin//Open the code blook of the for loop
		a=(i/8)%2;//High bit
		b=(i/4)%2;
		c=(i/2)%2;
		d=(i/1)%2;//Low bit	
		 
		//Oh, Dr. Becker, do you remember what belongs here? 
	    #60; //Need a delay to let the calcuation/circuit complete.
		 	
		$display ("|%2d|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d|",i,a,b,c,d,f0,f1,f2, f3, f4, f5, f6, f7, f8, f9);
		if(i%4==3) //Every fourth row of the table, put in a marker for easier reading.
		 $write ("|--+-+-+-+-+--+--+--+--+--+--+--+--+--+--|\n");//Write acts a bit like a java System.print

	end//End of the for loop code block
 
	#10; //A time delay of 10 time units. Hashtag Delay
	$finish;//A command, not unlike System.exit(0) in Java.
  end  //End the code block of the main (initial)
  
endmodule //Close the testbench module