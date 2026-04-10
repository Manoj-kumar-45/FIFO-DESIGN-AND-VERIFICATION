class write_test extends test;
  `uvm_component_utils(write_test)
  
  fifo_write_seq seq;
  
  function new(string name="write_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    seq=fifo_write_seq::type_id::create("seq");
    seq.start(env.agt.seqr);
    
    phase.drop_objection(this);
  endtask
endclass

  