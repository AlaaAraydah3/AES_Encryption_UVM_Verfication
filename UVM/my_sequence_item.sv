
class my_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(my_sequence_item)

  function new (string name = "my_sequence_item");
  super.new(name);
  endfunction
  
    rand bit valid_in;
    rand bit reset   ;
    rand bit [127:0] cipher_key, plain_text; 
    logic   valid_out;
    logic [127:0] cipher_text;

    // Constraints
    constraint valid_IN
     {
      valid_in dist {1 := 70, 0 := 30}; // 70% chance for valid_in to be 1, 30% chance for valid_in to be 0
     }
    constraint rst 
     {
      reset dist {1:=50,0:=50}; 
     }

    constraint cipher_key_c 
     {
      cipher_key dist { [128'h0 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD] :/ 100}; 
     }

    constraint plain_text_c 
     {
      plain_text dist { [128'h0 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD] :/ 100};
     }

endclass

