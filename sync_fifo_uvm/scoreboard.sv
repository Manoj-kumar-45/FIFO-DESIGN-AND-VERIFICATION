class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)
  
  uvm_analysis_imp #(fifo_seq_item, fifo_scoreboard) analysis_export;
  
  function new(string name="fifo_scoreboard" uvm_component parent);
    super.new(name,parent);
    analysis_export = new("analysis_export",this);
  endfunction
  
  function void write(fifo_seq_item t);
  
  