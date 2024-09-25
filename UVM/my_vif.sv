
interface intf (input logic clk);
    logic reset    ;
    logic valid_in ;
    logic valid_out;
    logic [127:0] cipher_key ;
    logic [127:0] plain_text ; 
    logic [127:0] cipher_text;
    
  
  clocking cb @(posedge clk );
  default input #1step output #1step;
    input  valid_in   ;
    input  cipher_key ;
    input  plain_text ;
    output cipher_text;
    output valid_out  ;
  endclocking
endinterface




