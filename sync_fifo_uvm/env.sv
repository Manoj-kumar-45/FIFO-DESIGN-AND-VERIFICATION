class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)
  
  fifo_agent agt;
  fifo_scoreboard sb;
  
  
  function new(string name ="fifo_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  //build phase //
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    agt=fifo_agent::type_id::create("agt",this);
    sb=fifo_scoreboard::type_id::create("sb",this);
    
  endfunction 
  
  ////connect phase ////
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    agt.mon.ap.connect(sb.analysis_export);
  endfunction
endclass


  