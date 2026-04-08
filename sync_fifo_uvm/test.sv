class test extends uvm_test;
  `uvm_components_utils(test)
  fifo_env env;
  virtual fifo _if vif;
  
  // constructor 
  function new(string=name,uvm_test parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    env = fifo_env::type_id:create("env" this);
    
    uvm_config_db#(virtual fifo_if)::set(this,"env","vif",vif);
    if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif))
      `uvm_error("TEST","vif is not found")
   endfunction
      
endclass
      
    
    
  
  
  
  