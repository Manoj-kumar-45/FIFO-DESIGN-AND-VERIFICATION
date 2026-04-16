import uvm_pkg::*;
`include "uvm_macros.svh"


class fifo_overflow_test extends test;
  `uvm_component_utils(fifo_overflow_test)

 fifo_overflow_seq seq;

  function new(string name="fifo_overflow_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    seq = fifo_overflow_seq::type_id::create("seq");
    seq.start(env.agt.seqr);

    phase.drop_objection(this);
  endtask
endclass
//end of class