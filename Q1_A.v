module STACK_BASED_ALU#(parameter n = 4)(input clk, input signed [n - 1:0]input_data, input [2:0]opcode, output reg overflow, output reg signed[n - 1:0]output_data);
  reg[n - 1:0] stack[511:0];
  integer pc = -1, i = 0;
  reg signed [2 * n - 1:0] temp_output;
  always @(posedge clk) begin
    overflow = 0;
    case(opcode)
        3'b100: begin
            if(pc >= 1) begin
                output_data = stack[pc] + stack[pc - 1];
                if((stack[pc][n - 1] == 0 && stack[pc - 1][n - 1] == 0 && output_data[n - 1] == 1) || 
                (stack[pc][n - 1] == 1 && stack[pc - 1][n - 1] == 1 && output_data[n - 1] == 0)) overflow = 1;
            end
        end
        3'b101: begin
            if(pc >= 1) begin
                temp_output = stack[pc] * stack[pc - 1];
                output_data = temp_output;
                if((stack[pc][n - 1] == 0 && stack[pc - 1][n - 1] == 0 && output_data[n - 1] == 1)) overflow = 1;
                for(i = n; i < 2 * n; i = i + 1) begin
                    if(temp_output[i] == 1) overflow <= 1;
                end
            end
        end
        3'b110: begin
            if(pc < 511)begin
                pc = pc + 1;
                stack[pc] <= input_data;
            end
        end
        3'b111: begin
            if(pc > 0)begin
                output_data <= stack[pc];
                pc = pc - 1;
            end
        end
    endcase
    end
endmodule