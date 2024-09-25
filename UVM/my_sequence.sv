
class my_sequence extends uvm_sequence;
  `uvm_object_utils(my_sequence)

   my_sequence_item seq_item;

  function new(string name = "my_sequence");
  super.new(name);
  endfunction
  
  task pre_body; // inested of build phase
  seq_item = my_sequence_item::type_id::create("seq_item");  // handle
  endtask
  
  task reset ;
    repeat(10) begin
      
    start_item(seq_item);
        assert (seq_item.randomize() with {seq_item.reset==0 ; seq_item.valid_in == 0;})
        else 
        $error(" reset error") ;
    finish_item(seq_item);
    end  
  endtask
 
  task valid ;
    repeat(100) begin
      
    start_item(seq_item);
       assert (seq_item.randomize() with {seq_item.valid_in == 1 ;seq_item.reset==1 ;})
        else 
        $error("error") ;
    finish_item(seq_item);
    end  
  endtask
  
  task body;
    reset;
    valid;
  endtask

endclass
