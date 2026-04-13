import uvm_pkg::*;
`include "uvm_macros.svh"

class test extends uvm_test;
  `uvm_component_utils(test)
  fifo_env env;
  virtual fifo_if vif;
  
  // constructor 
  function new(string name="test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    env = fifo_env::type_id::create("env",this);
 // get vif from top
    if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif))
      `uvm_fatal("TEST","vif is not found")                                   
    
    // pass vif to env
    uvm_config_db#(virtual fifo_if)::set(this,"*","vif",vif);
   endfunction
      
endclass
      
    

  
  
  
  