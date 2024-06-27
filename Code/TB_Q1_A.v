module TB_Q1_A();
    reg clk;
    wire overflow4;
    reg [2:0] opcode4;
    reg [3:0] input_data4;
    wire [3:0] output_data4;
    wire overflow8;
    reg [2:0] opcode8;
    reg [7:0] input_data8;
    wire [7:0] output_data8;
    wire overflow16;
    reg [2:0] opcode16;
    reg [15:0] input_data16;
    wire [15:0] output_data16;
    wire overflow32;
    reg [2:0] opcode32;
    reg [31:0] input_data32;
    wire [31:0] output_data32;
    STACK_BASED_ALU #(4) sba1(clk, input_data4, opcode4, overflow4, output_data4);
    STACK_BASED_ALU #(8) sba2(clk, input_data8, opcode8, overflow8, output_data8);
    STACK_BASED_ALU #(16) sba3(clk, input_data16, opcode16, overflow16, output_data16);
    STACK_BASED_ALU #(32) sba4(clk, input_data32, opcode32, overflow32, output_data32);

  always
    #1 clk = ~clk;
  initial
     clk <= 0;
 

  initial begin
    $display ("for 4 bit: ");
    $monitor("time:%d | clk=%b | opcode=%b | input_data=%b | output_data=%b | overflow4=%b", $time, clk, opcode4, input_data4, output_data4, overflow4);
    opcode4 = 3'b110;            
    input_data4 = 4'b1100;                                                      //push 1100
    #2 opcode4 = 3'b110;         
    input_data4 = 4'b0001;                                                      //push 0001
    #2 opcode4 = 3'b100;                                                        //add 1100, 0001
    #2 opcode4 = 3'b101;                                                        //mult 1100, 0001
    #2 opcode4 = 3'b111;                                                        //pop 0001
    #2 opcode4 = 3'b110;         
    input_data4 = 4'b1000;                                                      //push 1000
    #2 opcode4 = 3'b100;                                                        //add 1100, 1000(overflow)
    #2 opcode4 = 3'b111;                                                        //pop 1000
    #2 opcode4 = 3'b110;         
    input_data4 = 4'b010;                                                       //push 0010
    #2 opcode4 = 3'b101;                                                        //mult 1100 , 0010(overflow)
    #2 opcode4 = 3'b111;                                                        //pop 0010
    #2 opcode4 = 3'b111;                                                        //pop 1100
    #2


    $display ("for 8 bit: ");
    $monitor("time:%d | clk=%b | opcode=%d | input_data=%b | output_data=%b | overflow4=%b", $time, clk, opcode8, input_data8, output_data8, overflow8);
    opcode8 = 3'b110;            
    input_data8 = 8'b01110000;                                                  //push 01110000
    #2 opcode8 = 3'b110;         
    input_data8 = 8'b00000010;                                                  //push 00000010
    #2 opcode8 = 3'b100;                                                        //add 01110000, 00000010
    #2 opcode8 = 3'b101;                                                        //mult 01110000, 00000010
    #2 opcode8 = 3'b111;                                                        //pop 00000010
    #2 opcode8 = 3'b110;         
    input_data8 = 8'b01110100;                                                  //push 01110100
    #2 opcode8 = 3'b100;                                                        //add 01110000, 01110100(overflow)
    #2 opcode8 = 3'b111;                                                        //pop 01110100
    #2 opcode8 = 3'b110;         
    input_data8 = 8'b00001000;                                                  //push 00001000
    #2 opcode8 = 3'b101;                                                        //mult 01110000 , 00001000(overflow)
    #2 opcode8 = 3'b111;                                                        //pop 00001000
    #2 opcode8 = 3'b111;                                                        //pop 01110000
    #2


    $display ("for 16 bit: ");
    $monitor("time:%d | clk=%b | opcode=%d | input_data=%b | output_data=%b | overflow4=%b", $time, clk, opcode16, input_data16, output_data16, overflow16);
    opcode16 = 3'b110;            
    input_data16 = 16'b0111000000000001;                                        //push 0111000000000001
    #2 opcode16 = 3'b110;         
    input_data16 = 16'b0000010000000001;                                        //push 0000010000000000
    #2 opcode16 = 3'b100;                                                       //add 0111000000000001, 0000010000000000
    #2 opcode16 = 3'b101;                                                       //mult 0111000000000001, 0000010000000000(overflow)
    #2 opcode16 = 3'b111;                                                       //pop 0000010000000000
    #2 opcode16 = 3'b110;         
    input_data16 = 16'b0111010000000010;                                        //push 0111010000000010
    #2 opcode16 = 3'b100;                                                       //add 0111000000000001, 0111010000000010(overflow)
    #2 opcode16 = 3'b111;                                                       //pop 0111010000000010
    #2 opcode16 = 3'b110;         
    input_data16 = 16'b0000000000000001;                                        //push 0000000000000001
    #2 opcode16 = 3'b101;                                                       //mult 0111000000000001 , 0000000000000001
    #2 opcode16 = 3'b111;                                                       //pop 0000000000000001
    #2 opcode16 = 3'b111;                                                       //pop 0011000000000001
    #2

    $display ("for 32 bit: ");
    $monitor("time:%d | clk=%b | opcode=%d | input_data=%b | output_data=%b | overflow4=%b", $time, clk, opcode32, input_data32, output_data32, overflow32);
    opcode32 = 3'b110;            
    input_data32 = 32'b00000000000000001110000000000000;                        //push 00000000000000001110000000000000
    #2 opcode32 = 3'b110;         
    input_data32 = 32'b00000000000000000000000000000010;                        //push 00000000000000000000000000000010
    #2 opcode32 = 3'b100;                                                       //add 00000000000000001110000000000000, b00000000000000000000000000000010
    #2 opcode32 = 3'b101;                                                       //mult 00000000000000001110000000000000, b00000000000000000000000000000010
    #2 opcode32 = 3'b111;                                                       //pop b00000000000000000000000000000010
    #2 opcode32 = 3'b110;         
    input_data32 = 32'b11111111111111111111111111001111;                        //push 11111111111111111111111111001111
    #2 opcode32 = 3'b100;                                                       //add 00000000000000001110000000000000, 11111111111111111111111111001111(overflow)
    #2 opcode32 = 3'b111;                                                       //pop 111101000111111111111111111111111110011110000010
    #2 opcode32 = 3'b110;           
    input_data32 = 32'b00000000000000100000000000000000;                        //push 00000000000000100000000000000000
    #2 opcode32 = 3'b101;                                                       //mult 00000000000000001110000000000000 , 00000000000000100000000000000000
    #2 opcode32 = 3'b111;                                                       //pop 00000000000000100000000000000000
    #2 opcode32 = 3'b111;                                                       //pop 00000000000000001110000000000000
    #2  

    $stop();
  end


endmodule

