module full_adder  (input logic x, y, z,
	                output logic S, c);
	assign S = x^y^z;
	assign c = (x&y) | (y&z) | (x&z);
endmodule

module ripple_adder (
	input  logic  [7:0] a, 
    input  logic  [7:0] b,
	input  logic         cin,
	output logic  [7:0] s,

	output logic         cout,
	output logic 		X
);

	logic [7:0] newB;

    always_comb begin
        if (cin) begin
            newB = ~b;  
        end else begin
            newB = b;  
        end
    end

	logic  c1, c2, c3, c4, c5, c6, c7, c8;
	full_adder FA0(.x(a[0]), .y(newB[0]), .z(cin), .S(s[0]), .c(c1));
	full_adder FA1(.x(a[1]), .y(newB[1]), .z(c1), .S(s[1]), .c(c2));	
	full_adder FA2(.x(a[2]), .y(newB[2]), .z(c2), .S(s[2]), .c(c3));
	full_adder FA3(.x(a[3]), .y(newB[3]), .z(c3), .S(s[3]), .c(c4));
	full_adder FA4(.x(a[4]), .y(newB[4]), .z(c4), .S(s[4]), .c(c5));
	full_adder FA5(.x(a[5]), .y(newB[5]), .z(c5), .S(s[5]), .c(c6));
	full_adder FA6(.x(a[6]), .y(newB[6]), .z(c6), .S(s[6]), .c(c7));
	full_adder FA7(.x(a[7]), .y(newB[7]), .z(c7), .S(s[7]), .c(c8));
	full_adder FA8(.x(a[7]), .y(newB[7]), .z(c8), .S(X), .c(cout)); // sign-extended

	
endmodule

