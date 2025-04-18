// `default_nettype none
module demo_01_impl (input wire clock);
	wire reset;
	wire a, b;

	//     01234567890123456789
	seq #("-_____-____-________") seq_r (clock, reset);
	seq #("_--___-___-______-__") seq_a (clock, a);
	seq #("__--__-__________-__") seq_b (clock, b);

	
	// 😔 Free version of SymbiYosys does not support this
	// default clocking @(posedge clock); endclocking
	// default disable iff (reset);
	// // in the cycle after a, b must be high
	// assert property (a |=> b);

	// in the cycle after a, b must be high
	// 😀 How can we fix it??
	reg c;

	initial begin
		c = 0;
	end

	always @(posedge clk ) begin
		if (a && !reset) begin
			c <= 1;
		end else begin 
			c <= 0;
		end
		if (c && !b) begin
			assert(0);
		end

		// if (c) begin
		// 	assert(b);
		// end
	end

endmodule




















	// reg a_p;
	// reg a_pp;
	// reg b_p;
	// reg b_pp;
	// reg res_p;
	// reg res_pp;

	// initial begin
	// 	a_p = 0;
	// 	a_pp = 0;
	// 	b_p = 0;
	// 	b_pp = 0;
	// 	res_p = 1;
	// 	res_pp = 1;
	// end

	// always @(posedge clock) begin
	// 	a_p <= a;
	// 	a_pp <= a_p;
	// 	b_p <= b;
	// 	b_pp <= b_p;
	// 	res_p <= reset;
	// 	res_pp <= res_p;
	// end
	

	// always @(posedge clock) begin
	// 	assert(res_p || !a_p || b);
	// end