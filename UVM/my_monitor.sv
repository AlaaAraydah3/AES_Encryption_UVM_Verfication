class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)

  my_sequence_item seq_item;
  uvm_analysis_port#(my_sequence_item) my_analysis_port; // 1 inst port
  virtual intf my_vif;
  

  function new (string name = "my_monitor", uvm_component parent);
  super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    
    if(!uvm_config_db#(virtual intf)::get(this,"", "my_vif", my_vif))
      `uvm_fatal(get_full_name(), "Error")
      
      my_analysis_port = new("my_analysis_port", this); // 2 handle
    
      seq_item = my_sequence_item::type_id::create("seq_item");
    
  endfunction
  
 task  run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  forever begin
    #10;
    @(my_vif.cb);

      seq_item.cipher_text = my_vif.cipher_text; 
      seq_item.valid_out   = my_vif.valid_out  ;    
      seq_item.valid_in    = my_vif.valid_in   ;    
      seq_item.cipher_key  = my_vif.cipher_key ;  
      seq_item.plain_text  = my_vif.plain_text ; 
      seq_item.reset       = my_vif.reset      ;
   
      my_analysis_port.write(seq_item);
  end
endtask
endclass
