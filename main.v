module main (
    input wire clk,
    input wire reset,
    input wire load,          
    input wire [3:0] data_a,  
    input wire [3:0] data_b,  
    output wire [3:0] out_sum 
);

    wire bit_a, bit_b, sum_bit;
    wire [3:0] q_a, q_b;

    //เรียกใช้ Shift Register A
    shift_register_4bit reg_A (
        .clk(clk),
        .reset(reset),
        .bit_in(load ? data_a[0] : 1'b0), 
        .q(q_a)
    );
    assign bit_a = q_a[3]; // ดึงบิตสุดท้ายออกมา

    //เรียกใช้ Shift Register B
    shift_register_4bit reg_B (
        .clk(clk),
        .reset(reset),
        .bit_in(load ? data_b[0] : 1'b0),
        .q(q_b)
    );
    assign bit_b = q_b[3]; // ดึงบิตสุดท้ายออกมา

    serial_adder adder_inst (
        .clk(clk),
        .reset(reset || load), 
        .a(bit_a),
        .b(bit_b),
        .sum(sum_bit)          
    );

    shift_register_4bit reg_Sum (
        .clk(clk),
        .reset(reset || load),
        .bit_in(sum_bit),     
        .q(out_sum)
    );

endmodule