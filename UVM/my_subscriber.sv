
class my_subscriber extends uvm_subscriber#(my_sequence_item);
  `uvm_component_utils(my_subscriber)
   my_sequence_item seq_item;
   int final_cover;
  
  covergroup group_1 ;

    plain_text:  coverpoint seq_item.plain_text 
    {
      bins in1_low  = {128'h0};
      bins in2_high = {128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF };
      bins in3_mid  = {[128'h00000000000000000000000000000001 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE ]};
    }

		
    cipher_key: coverpoint seq_item.cipher_key
    {
      bins key_in1_L = {128'h0 };
      bins key_in2_H = {128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF};
      bins key_in3_M = {[128'h00000000000000000000000000000001 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE]};
    }
    
    reset: coverpoint seq_item.reset
    {
      bins reset_L = {1'h0 };
      bins reset_H = {1'h1} ;
    }
    
    valid_in: coverpoint seq_item.valid_in
    {
      bins valid_L = {1'h0 };
      bins valid_H = {1'h1} ;
    }
    
    
    valid_out: coverpoint seq_item.valid_out 
    {
      bins validO_L = {1'h0 };
      bins validO_H = {1'h1} ;
    }
    
    cipher_text: coverpoint seq_item.cipher_text
    {
      bins key_in1_L = {128'h0 };
      bins key_in2_H = {128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF};
      bins key_in3_M = {[128'h00000000000000000000000000000001 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE]};
    }
     
    cross1 :cross cipher_key,plain_text,cipher_text,valid_in;
	  
	  endgroup

  
  function new(string name, uvm_component parent);
  super.new(name, parent);
  group_1 = new();
  endfunction

  function void write(my_sequence_item t);
    this.seq_item = t; 
    // Sample the coverage group with the sequence item
    group_1.sample();
  endfunction
  
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    seq_item= my_sequence_item::type_id::create("seq_item");
  endfunction

  function void report_phase(uvm_phase phase);
  super.report_phase(phase);
     final_cover = group_1.get_coverage();
    `uvm_info(get_type_name(), $sformatf("Final Coverage is: %0f", final_cover), UVM_LOW);
  endfunction
 
endclass
