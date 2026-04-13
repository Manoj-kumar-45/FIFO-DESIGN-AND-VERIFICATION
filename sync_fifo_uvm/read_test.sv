import uvm_pkg::*;
`include "uvm_macros.svh"

  fifo_read_seq rd_seq;

class read_test extends test;
  
  `uvm_component_utils(read_test)
  
  function new (string name="read_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    rd_seq=fifo_read_seq::type_id::create("rd_seq");
    rd_seq.start(env.agt.seqr);
    
    phase.drop_objection(this);
  endtask
endclass



    