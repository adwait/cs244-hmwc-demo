`default_nettype none
module demo_02_delay (input wire clock);
	wire reset;
	wire a, b;

	//     0123456789012345678901
	seq #("-_____-_______________") seq_r (clock, reset);
	seq #("_-____-_______-_______") seq_a (clock, a);
	seq #("___-__-__________-____") seq_b (clock, b);

	
	// 😔 Free SymbiYosys does not support this
	// default clocking @(posedge clock); endclocking
	// default disable iff (reset);

	// // in any cycle when a is high, b must be high 1 to 2 cycles later
	// assert property (a |-> ##[1:2] b);

	// 😀 How can we fix it??
	// ...

endmodule
















// reg a_p;
// 	reg a_pp;
// 	reg b_p;
// 	reg b_pp;
// 	reg res_p;
// 	reg res_pp;

// 	initial begin
// 		a_p = 0;
// 		a_pp = 0;
// 		b_p = 0;
// 		b_pp = 0;
// 		res_p = 1;
// 		res_pp = 1;
// 	end

// 	always @(posedge clock) begin

// 		a_p <= a;
// 		a_pp <= a_p;
// 		b_p <= b;
// 		b_pp <= b_p;
// 		res_p <= reset;
// 		res_pp <= res_p;	

// 		assert(res_pp || !a_pp || (b || b_p));
// 	end

