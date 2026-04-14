import uvm_pkg::*;
`include "uvm_macros.svh"



class fifo_underflow_test extends base_test;
  `uvm_component_utils(fifo_underflow_test)

  fifo_underflow_seq seq;

  function new(string name="fifo_underflow_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq = fifo_underflow_seq::type_id::create("seq");
    seq.start(env.agt.seqr);

    phase.drop_objection(this);
  endtask

endclass