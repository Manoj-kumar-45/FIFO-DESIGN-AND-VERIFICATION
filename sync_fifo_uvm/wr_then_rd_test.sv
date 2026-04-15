import uvm_pkg::*;
`include "uvm_macros.svh"


class wr_then_rd extends test;
  `uvm_component_utils(wr_then_rd)
  
  function new(string name="wr_then_rd",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  fifo_wr_then_rd_seq seq;
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    seq=fifo_wr_then_rd_seq::type_id::create("seq");
    seq.start(env.agt.seqr);
    
    phase.drop_objection(this);
  endtask
endclass
