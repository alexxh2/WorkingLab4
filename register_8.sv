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

	always_ff @(posedge Clk)
	begin
		if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
		begin
		Data_Out[15:8] <= 8'h0;
		end

		else if (Shift_En)
		begin
			Data_Out <= { X, Data_Out[15:1] };
		end
		
		if ((Yes_Add | Yes_Sub))
		begin
			Data_Out[15:8] <= A_in;
		end
		
		if (Load_B)
		begin
			Data_Out[7:0] <= B_in;
			
		end
	end
    

endmodule