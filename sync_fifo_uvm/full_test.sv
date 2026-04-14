import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_full_test extends test;
  `uvm_component_utils(fifo_full_test)
  
  fifo_full_seq seq;
  
  
  function new(string name="fifo-full_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    seq=fifo_full_seq::type_id::create("seq");
    seq.start(env.agt.seqr);
    
    phase.drop_objection(this);
  endtask
  
endclass