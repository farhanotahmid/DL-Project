//----------------------------------------------------------------------
module Breadboard	(w,x,y,z,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9);    // Module header (like a function) (assembles circuit)
input w,x,y,z;                           // Inputs
output r0, r1, r2,r3, r4,r5,r6,r7,r8,r9;                       // Outputs
reg r0,r1,r2,r3, r4,r5,r6,r7,r8,r9;                            // Reg elements used as outputs
wire w,x,y,z;

always @ (w,x,y,z,r0,r1,r2,r3, r4,r5,r6,r7,r8,r9) begin  // To ensure the below code block doesn't execute in parallel
                                         

// w'x'y'z + w'xy'z + w'xyz' + wx'y'z' + wx'y'z + wx'yz' + wx'yz + wxy'z + wxyz'
r0= (~w&~x&~y&z)|(~w&x&~y&z)|(~w&x&y&~z)|(w&~x&~y&~z)|(w&~x&~y&z)|(w&~x&y&~z)|(w&~x&y&z)|(w&x&~y&z)|(w&x&y&~z);

// w'x'yz + w'xy'z' + w'xyz' + w'xyz + wx'yz + wxy'z' + wxy'z + wxyz' + wxyz
r1= (~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&y&~z)|(~w&x&y&z)|(w&~x&y&z)|(w&x&~y&~z)|(w&x&~y&z)|(w&x&y&~z)|(w&x&y&z);

// w'x'y'z' + w'x'yz + w'xy'z' + w'xy'z + w'xyz + wx'y'z + wx'yz' + wx'yz + wxy'z' + wxyz
r2= (~w&~x&~y&~z)|(~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&~y&z)|(~w&x&y&z)|(w&~x&~y&z)|(w&~x&y&~z)|(w&~x&y&z)|(w&x&~y&~z)|(w&x&y&z);

// w'x'y'z + w'x'yz' + w'x'yz + w'xy'z' + wx'y'z' + wx'y'z + wx'yz + wxy'z
r3= (~w&~x&~y&z)|(~w&~x&y&~z)|(~w&~x&y&z)|(~w&x&~y&~z)|(w&~x&~y&~z)|(w&~x&~y&z)|(w&~x&y&z)|(w&x&~y&z);

// w'x'y'z' + w'x'yz' + w'x'yz + w'xy'z + w'xyz' + w'xyz + wxy'z' + wxy'z
r4 = (~w&~x&~y&~z)|(~w&~x&y&~z)|(~w&~x&y&z)|(~w&x&~y&z)|(~w&x&y&~z)|(~w&x&y&z)|(w&x&~y&~z)|(w&x&~y&z);

// w'x'yz + w'xy'z' + w'xy'z + w'xyz' + w'xyz + wx'y'z' + wxy'z' + wxyz' + wxyz
r5 = (~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&~y&z)|(~w&x&y&~z)|(~w&x&y&z)|(w&~x&~y&~z)|(w&x&~y&~z)|(w&x&y&~z)|(w&x&y&z);

// w'x'y'z + w'xy'z' + wx'y'z' + wx'yz + wxy'z' + wxy'z + wxyz' + wxyz
r6 = (~w&~x&~y&z)|(~w&x&~y&~z)|(w&~x&~y&~z)|(w&~x&y&z)|(w&x&~y&~z)|(w&x&~y&z)|(w&x&y&~z)|(w&x&y&z);

// w'x'y'z' + w'x'yz + w'xy'z' + w'xyz + wx'y'z' + wx'y'z + wx'yz + wxyz'
r7 = (~w&~x&~y&~z)|(~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&y&z)|(w&~x&~y&~z)|(w&~x&~y&z)|(w&~x&y&z)|(w&x&y&~z);

// w'x'y'z' + w'x'yz' + w'x'yz + w'xy'z' + w'xy'z + w'xyz' + w'xyz + wx'y'z + wxy'z' + wxy'z
r8= (~w&~x&~y&~z)|(~w&~x&y&~z)|(~w&~x&y&z)|(~w&x&~y&~z)|(~w&x&~y&z)|(~w&x&y&~z)|(~w&x&y&z)|(w&~x&~y&z)|(w&x&~y&~z)|(w&x&~y&z);

// w'x'yz' + w'xy'z + w'xyz + wx'y'z + wx'yz' + wxy'z' + wxy'z + wxyz
r9 = (~w&~x&y&~z)|(~w&x&~y&z)|(~w&x&y&z)|(w&~x&~y&z)|(w&~x&y&~z)|(w&x&~y&~z)|(w&x&~y&z)|(w&x&y&z);



end                                       //  End of always block

endmodule                                 // Module end

//----------------------------------------------------------------------

module testbench();     

  // Registers act like local variables (memory area variable)
  reg [4:0] i;  // A loop control for 16 rows of a truth table.
  reg  a;   // Value of 2^3
  reg  b;   // Value of 2^2
  reg  c;   // Value of 2^1
  reg  d;   // Value of 2^0
  
  // A wire can hold the return of a function
  wire  f0,f1,f2, f3, f4,f5,f6,f7,f8,f9;
  
  // Modules can be either functions, or model chips. They're instantiated like an object of a class, with a constructor with parameters. They are not invoked, but operate like a thread.
  
  Breadboard zap(a,b,c,d,f0,f1,f2, f3, f4,f5,f6,f7,f8,f9);  // Like constructor of the module and behaves like a function call of the module
 
     
  // Initial means "start," like a Main() function.
  // Begin denotes the start of a block of code. (like the first curly brace)
  initial begin
   	
  // Using $display to print the truth table header
  $display ("|##|W|X|Y|Z|F0|F1|F2|F3|F4|F5|F6|F7|F8|F9|");
  $display ("|==+=+=+=+=+==+==+==+==+==+==+==+==+==+==|");
  
    // A for loop, with register i being the loop control variable
	for (i = 0; i < 16; i = i + 1) 
	begin   // Denotes the start of the for loop's code block (like '{')
		a=(i/8)%2;// High bit
		b=(i/4)%2;
		c=(i/2)%2;
		d=(i/1)%2;// Low bit	
		 
	    #60; // A delay to let the calcuation/circuit complete
		 	
		// Use descriptor codes and $display to format table output
		
		if( i < 10)
		 $display ("|%2d|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d|",i,a,b,c,d,f0,f1,f2, f3, f4,f5,f6,f7,f8,f9);
		
		// To format rows A - F
		if(i>=10 && i<11)
		 $display ("| A|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d|",a,b,c,d,f0,f1,f2, f3, f4,f5,f6,f7,f8, f9);
		
		if(i>=11 && i<12)
		 $display ("| B|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d|",a,b,c,d,f0,f1,f2, f3, f4,f5,f6,f7,f8, f9);
		
		if(i>=12 && i<13)
		 $display ("| C|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d|",a,b,c,d,f0,f1,f2, f3, f4,f5,f6,f7,f8, f9);
		
		if(i>=13 && i<14)
		 $display ("| D|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d|",a,b,c,d,f0,f1,f2, f3, f4,f5,f6,f7,f8, f9);
		
		if(i>=14 && i<15)
		 $display ("| E|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d|",a,b,c,d,f0,f1,f2, f3, f4,f5,f6,f7,f8, f9);
		
		if(i>=15 && i<16)
		 $display ("| F|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d|",a,b,c,d,f0,f1,f2, f3, f4,f5,f6,f7,f8, f9);
		
		// If statement to add a marker to every fourth row of the table
		if(i%4==3) 
		 $write ("|--+-+-+-+-+--+--+--+--+--+--+--+--+--+--|\n");   // Using $write to print without a newline (a bit like System.print)

	end     // Denotes the end of the for loop's code block (like '}')
 
	#10;    // A time delay of 10 time units
	$finish;    // Behaves like System.exit(0) in Java.
  end       // End the code block of the main (initial)
  
endmodule // Close the testbench module
