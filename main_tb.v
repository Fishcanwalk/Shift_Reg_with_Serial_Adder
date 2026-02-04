`timescale 1ns / 1ps

module main_tb();

    reg clk;
    reg reset;
    reg load;
    reg [3:0] data_a_in;
    reg [3:0] data_b_in;
    wire [3:0] result;

    main uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .data_a(data_a_in),
        .data_b(data_b_in),
        .out_sum(result)
    );

    always #5 clk = ~clk;

    initial begin
       $monitor("Time=%3t | Load=%b | A_in=%b B_in=%b | A_curr=%b B_curr=%b | Adder_Sum=%b | Result=%b", 
                 $time, 
                 load, 
                 data_a_in,
                 data_b_in,
                 uut.reg_A.q,   
                 uut.reg_B.q,   
                 uut.sum_bit,   
                 result         
        );

        clk = 0;
        reset = 1;
        load = 0;
        data_a_in = 4'b0000;
        data_b_in = 4'b0000;
        #20 reset = 0; 

        #10 data_a_in = 4'b0001; data_b_in = 4'b0000;
        load = 1;   

        $display("--------------Test 1 Start--------------");
        #10 load = 0;
        #60;   
        #10 data_a_in = 4'b0000; data_b_in = 4'b0001;
        $display("----------=----Test 1 End---------------");   
            
        load = 1;   
        $display("--------------Test 2 Start--------------");
        #10 load = 0; 
        #50;  
        
        #10 data_a_in = 4'b0001; data_b_in = 4'b0001;
        $display("----------=----Test 2 End---------------");    

        load = 1;   
        $display("--------------Test 3 Start--------------");
        #10 load = 0; 
        #60;
        $display("----------=----Test 3 End---------------");

        $display("Final Result Analysis: %d", result);
        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, main_tb);
    end

endmodule