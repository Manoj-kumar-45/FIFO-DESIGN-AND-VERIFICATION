class fifo_driver extends uvm_driver #(fifo_seq_item);
  
  `uvm_component_utils(fifo_driver)
   virtual fifo_if.driver_mp vif;  
  
  function new(string name ,uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(virtual fifo_if.driver_mp)::get(this ,"","vif",vif))
      `uvm_fatal("NO_VIF","drivwer,virtual interface not found");
  endfunction
  
  
  task run_phase(uvm_phase phase);
    fifo_seq_item item;
    vif.driver_cb.rst<=1;
    vif.driver_cb.wr_en<=0;
    vif.driver_cb.rd_en<=0;
    vif.driver_cb.wr_data<=0;
    
    
    repeat(3)@(vif.driver_cb);
    vif.driver_cb.rst<=0;
    
    forever begin
      seq_item_port.get_next_item(item);
      
      @(vif.driver_cb);
      
      vif.driver_cb.wr_en<=item.wr_en;
      vif.driver_cb.rd_en<=item.rd_en;
      vif.driver_cb.wr_data<=item.wr_data;
    end
  endtask
endclass
