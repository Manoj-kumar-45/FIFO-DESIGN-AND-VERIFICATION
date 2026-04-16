class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)
  
  uvm_analysis_imp #(fifo_seq_item, fifo_scoreboard) analysis_export;
  
  //   reference model
  bit [7:0]model_q[$];
  int depth = 16;
  
  function new(string name="fifo_scoreboard",uvm_component parent);
    super.new(name,parent);
    analysis_export = new("analysis_export",this);
  endfunction
  
  function void write(fifo_seq_item t);
    `uvm_info("SCOREBOARD",t.convert2string(),UVM_MEDIUM)
    
    //write operation
    if(t.wr_en && !t.full)begin
      model_q.push_back(t.wr_data);
    end
    
    //read operation
    if(t.rd_en && !t.empty)begin
      if(model_q.size()==0)begin
        `uvm_error("SCBD","model empty but dut is reading")
      end
      else begin
        bit[7:0]expected;
        expected=model_q.pop_front();
        if(expected!=t.rd_data)begin
          `uvm_error("MISS-MATCH",
                     $sformatf("Expected=%0h Actual=%0h",
              expected, t.rd_data));
        end
        else begin
          `uvm_info("MATCH",
                    $sformatf("matched Data=%0h",t.rd_data),UVM_LOW)
        end
      end
    end
    
    //underflow check - detect when read from empty FIFO
    if(t.rd_en && t.empty)begin
      if(!t.underflow)begin
        `uvm_error("UNDERFLOW","UNDERFLOW IS NOT ASSERTED")
      end
    end
    
    //overflow check - detect when write to full FIFO
    if(t.wr_en && t.full)begin
      if(!t.overflow)begin
        `uvm_error("OVERFLOW","OVERFLOW IS NOT ASSERTED")
      end
    end
    
    //count check - skip during active operations to account for pipeline delay
    // Only check when no write/read pending (when DUT count has stabilized)
    if(!t.wr_en && !t.rd_en)begin
      if(model_q.size() != t.fifo_count)begin
        `uvm_warning("COUNT_MISMATCH",
                     $sformatf("Model=%0d DUT=%0d",model_q.size(),t.fifo_count))
      end
    end
    
  endfunction
endclass
    
    
    
 
  