module reg_8 (
	input  logic 		  Clk, 
	input  logic 		  Reset, 
	input  logic 		  Shift_En,
	input  logic          Yes_Add,
	input  logic          Yes_Sub,
	input  logic          Load_B,
	input  logic [7:0]  	A_in,
	input  logic [7:0]  	B_in,
	input  logic			X,

	output logic [15:0]   Data_Out,
	output logic 		  Mval
	
);



	//logic [16:0] Data_Out_d;
	//logic X;

	always_ff @(posedge Clk)
	begin
		if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
		begin
		Data_Out[15:8] <= 8'h0;
		end

		else if (Shift_En)
		begin
			Data_Out <= { X, Data_Out[15:1] };
			//Mval <= Data_Out[0];
		end
		
		if ((Yes_Add | Yes_Sub)) // load A
		begin
			Data_Out[15:8] <= A_in;
		end
		
		if (Load_B)
		begin
			Data_Out[7:0] <= B_in;
			
		end
//	    Mval <= Data_Out[0];	
	end
    
	//assign Shift_Out = Data_Out[0];

endmodule


/*
module reg_X (
	input  logic 		  Clk, 
	input  logic 		  Reset, 
	input  logic 		  Load, 
	input  logic 		  Shift_En,
	input  logic    D,
	
	//output logic 		  Shift_Out,
	output logic  	  Data_Out
);



	logic  Data_Out_d;

	always_comb
	begin

		if (Load) 
		begin
			Data_Out_d = D;
		end
		else
		begin
			Data_Out_d = Data_Out; // Required to avoid synthesis inferring a latch
		end

	end

	always_ff @(posedge Clk)
	begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
		 begin
			Data_Out <= 1'h0;
		 end
		 else 
		 begin
			Data_Out <= Data_Out_d;
		 end
	end

	//assign Shift_Out = Data_Out[0];

endmodule

*/