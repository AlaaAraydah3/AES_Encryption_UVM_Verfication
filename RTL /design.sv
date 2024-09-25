`include "AES_Encrypt.v"

module AES(
    input logic clk,
    input logic reset,
    input logic valid_in,
    input logic  [127:0] cipher_key,
    input logic  [127:0] plain_text,
    output logic [127:0] cipher_text,
    output logic valid_out
           );

logic [127:0] cipher_text_out; // From Encrypt output
 
AES_Encrypt AES_inst(.in (plain_text),.key (cipher_key),.out (cipher_text_out));

always @(posedge clk or negedge reset) begin
  if (!reset) begin

      cipher_text <= 128'h0;
      valid_out   <= 0;
                 
  end else if (valid_in) begin
 
      cipher_text <= cipher_text_out;
      valid_out   <= 1;
      
  end else begin 
      valid_out   <= 0; 
  end
end
endmodule
