class fifo_driver extends uvm_driver #(fifo_seq_item);
  
  `uvm_component_utils(fifo_driver)
   virtual fifo_if.driver_mp vif;  
  
  function new(string name ,uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    