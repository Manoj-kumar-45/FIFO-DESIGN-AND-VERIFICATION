import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_empty_test extends test;
  `uvm_component_utils(fifo_empty_test)
  
  function new(string name="fifo_empty_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  fifo_empty_seq seq;
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    seq=fifo_empty_seq::type_id::create("seq");
    seq.start(env.agt.seqr);
    
    phase.drop_objection(this);
  endtask
endclass