module register_unit (
	input  logic 		  Clk, 
	input  logic 		  Reset, 
	input  logic 		  Shift_En,
	input  logic          Yes_Add,
	input  logic          Yes_Sub,
	input  logic          Load_B,
	input  logic [7:0]  	A_in,
	input  logic [7:0]  	B_in,
	input  logic			X,

	output logic [15:0]   AB_Out,
	output logic 		  Mval
	
);


	reg_8 reg_AB (
		.Clk            (Clk), 
		.Reset          (Reset),
		.Yes_Add		(Yes_Add),
		.Yes_Sub		(Yes_Sub),
		.Load_B			(Load_B),
		.Shift_En       (Shift_En),
		.A_in              (A_in),
		.B_in              (B_in),
		.X				(X),
		.Data_Out       (AB_Out),
		.Mval			(Mval)
	);

	

endmodule
