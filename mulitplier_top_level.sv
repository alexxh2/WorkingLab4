//Top level for ECE 385 adders lab
//modified for Spring 2024

//Note: lowest 2 HEX digits will reflect lower 8 bits of switch input
//Upper 4 HEX digits will reflect value in the accumulator


module multiplier_toplevel   (
	input  logic 		Clk, 
	input  logic		Reset_Load_Clear,
	input  logic 		Run,
	input  logic [7:0]  SW,

	output logic [7:0]  Aval,
	output logic [7:0]  Bval,
	output logic 		Xval,
	output logic [7:0]  hex_segA,
	output logic [3:0]  hex_gridA
);

	logic [7:0] Sum;
	logic [15:0] AB_Out;
	logic cout, Mval, Executing, Shift_En, Yes_Add, Yes_Sub, Load_B, X;
	logic Reset_Load_ClearSH, RunSH;
	logic [7:0] SW_SH;

	always_ff @ (posedge Clk)  
    begin
        Aval <= AB_Out[15:8];
        Bval <= AB_Out[7:0];
        if (Reset_Load_ClearSH)
            Xval <= 1'b0;
        else if (Executing == 0 & Shift_En == 0 & Yes_Add == 0 & Yes_Sub==0 & Load_B ==0)
            Xval <= 1'b0;
        else if (Yes_Add | Yes_Sub)
            Xval <= X;
    end

	ripple_adder adder (
		.a			(AB_Out[15:8]),
		.b			(SW_SH),
		.cin		(Yes_Sub),
		.s			(Sum),
		.cout		(cout),
		.X			(X)
	);

	
	register_unit reg_unit (
		.Clk        (Clk),
		.Reset      ((Load_B) |(Executing == 0 & Shift_En == 0 & Yes_Add == 0 & Yes_Sub==0 & Load_B ==0)),
		.Shift_En   (Shift_En),
		.Yes_Add    (Yes_Add),
		.Yes_Sub    (Yes_Sub),
		.Load_B     (Load_B),
		.A_in       (Sum),
		.B_in       (SW_SH),
		.X          (Xval),    
		.AB_Out     (AB_Out),
		.Mval       (AB_Out[0])
	);

	control control_unit (
		.Clk        (Clk),
		.Reset      (Reset_Load_ClearSH),
		.Execute    (RunSH),
		.Mval       (AB_Out[0]),
		.Executing  (Executing),
		.Shift_En   (Shift_En),
		.Yes_Add    (Yes_Add),
		.Yes_Sub    (Yes_Sub),
		.Load_B		(Load_B)
	);


	// Hex units that display contents of sw and sum register in hex
	hex_driver hex_a (
		.clk		(Clk),
		.reset		(Reset_Load_ClearSH),
		.in			({AB_Out[15:12], AB_Out[11:8], AB_Out[7:4], AB_Out[3:0]}),
		.hex_seg	(hex_segA),
		.hex_grid	(hex_gridA)
	);
	
	
	// Synchchronizers/debouncers
	sync_debounce button_sync [1:0] (
	   .clk    (Clk),
	   
	   .d      ({Reset_Load_Clear, Run}),
	   .q      ({Reset_Load_ClearSH, RunSH})
	);

	sync_debounce switch_sync [7:0] (
	   .clk    (Clk),
	   
	   .d      ({SW}),
	   .q      ({SW_SH})
	);

	
		
endmodule