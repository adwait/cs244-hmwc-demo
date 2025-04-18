
// Parent module with a miter with different inputs
module miter (
    input wire clk
    , input wire rst
);

    
simple_state_machine a (
    .clk(clk)
);


    
simple_state_machine b (
    .clk(clk)
);



    default clocking cb @(posedge clk);
    endclocking // cb

    logic fvreset;

    `include "demo1.pyc.sv"

endmodule
