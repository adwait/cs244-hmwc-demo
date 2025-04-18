module simple_state_machine (
    input logic clk,
    input logic reset,
    output logic [1:0] state
);
    typedef enum logic [1:0] {S0, S1, S2} state_t;
    state_t current_state, next_state;

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    assign state = current_state;

endmodule


module simple_state_machine_tb;
    logic clk;
    logic reset;
    logic [1:0] state;

    // State definitions
    typedef enum logic [1:0] {S0, S1, S2} state_t;


    // Instantiate the state machine
    simple_state_machine uut (
        .clk(clk),
        .reset(reset),
        .state(state)
    );


    // Property: Cyclic behavior through S0 -> S1 -> S2
    property cyclical_behavior;
        @(posedge clk)
        disable iff (reset) (state == S0) |=> (state == S1);
    endproperty

    // Assert the property
    assert property (cyclical_behavior) else $error("Sequence violation!");

endmodule