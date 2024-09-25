
class my_test extends uvm_test;
  `uvm_component_utils(my_test)
   my_env env ;
   my_sequence seq_inst ;
   virtual intf my_vif ;
 
  
  function new(string name, uvm_component parent);
  super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    
    if(!uvm_config_db#(virtual intf)::get(this, "", "my_vif", my_vif))
      `uvm_fatal(get_full_name(), "Error")

       uvm_config_db#(virtual intf)::set(this, "env", "my_vif", my_vif);
    env      = my_env     ::type_id::create("env", this);
    seq_inst = my_sequence::type_id::create("seq_inst") ;
 
  endfunction
 
  task run_phase(uvm_phase phase);
  super.run_phase(phase);

    phase.raise_objection(this);
      seq_inst.start(env.agent.sequencer);
    phase.drop_objection(this) ;
  endtask
  
endclass 
