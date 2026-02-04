module shift_register_4bit (
    input wire clk,      
    input wire reset,    
    input wire bit_in,  
    output reg [3:0] q   
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end else begin
            q[0] <= bit_in; 
            q[1] <= q[0];    
            q[2] <= q[1];    
            q[3] <= q[2];    
        end
    end

endmodule