module serial_adder (
    input wire clk,      
    input wire reset,    
    input wire a,        
    input wire b,        
    output wire sum      
);

    reg  carry_reg;      
    wire carry_out;      

    assign sum = a ^ b ^ carry_reg;
    assign carry_out = (a & b) | (carry_reg & (a ^ b));

    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            carry_reg <= 1'b0;        // เริ่มต้นให้ตัวทดเป็น 0
        end else begin
            carry_reg <= carry_out;   // เก็บตัวทดปัจจุบันไว้ใช้ในจังหวะถัดไป
        end
    end

endmodule