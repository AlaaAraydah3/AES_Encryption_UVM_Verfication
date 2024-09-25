

`include "uvm_macros.svh"
`include "my_vif.sv"
`include "design.sv"
import uvm_pkg::*;

module top;
  bit clk ;
  always #5 clk= ~clk;
  import my_pkg::*;

  intf in1 (clk);
  
  AES  aes_inst (
    .clk(in1.clk) ,
    .reset(in1.reset),
    .valid_in(in1.valid_in),
    .cipher_key(in1.cipher_key),
    .plain_text(in1.plain_text),
    .cipher_text(in1.cipher_text),
    .valid_out(in1.valid_out));
  
  initial 
    begin
      clk=0;
      uvm_config_db#(virtual intf)::set(null, "uvm_test_top", "my_vif", in1);
      run_test("my_test");
    end
endmodule
