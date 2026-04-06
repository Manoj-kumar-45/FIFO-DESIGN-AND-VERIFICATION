class fifo_sequencer extends uvm_sequencer #(fifo_seq_item);
  `uvm_component(fifo_sequencer)
  
  function new(string name ,uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

