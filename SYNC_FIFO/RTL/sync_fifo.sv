module sync_fifo #(
    parameter int DATA_WIDTH          = 8,
    parameter int DEPTH               = 16,
    parameter int ALMOST_FULL_THRESH  = DEPTH - 2,
    parameter int ALMOST_EMPTY_THRESH = 2
)(
    input  logic                   clk,
    input  logic                   rst,         // synchronous, active-high

    // Write port
    input  logic                   wr_en,
    input  logic [DATA_WIDTH-1:0]  wr_data,

    // Read port
    input  logic                   rd_en,
    output logic [DATA_WIDTH-1:0]  rd_data,

    // Status flags
    output logic                   full,
    output logic                   empty,
    output logic                   almost_full,
    output logic                   almost_empty,
    output logic                   overflow,    
    output logic                   underflow,    
    output logic [$clog2(DEPTH):0] fifo_count    
);


    localparam int PTR_WIDTH = $clog2(DEPTH);

    // Memory
  
    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

  
    // Pointers (extra MSB for wrap detection)
  
    logic [PTR_WIDTH:0] wr_ptr;
    logic [PTR_WIDTH:0] rd_ptr;


    // Qualified enables

    logic wr_en_q, rd_en_q;

    assign wr_en_q = wr_en & ~full;
    assign rd_en_q = rd_en & ~empty;


    // WRITE LOGIC
  
    always_ff @(posedge clk) begin
        if (rst) begin
            wr_ptr <= '0;
        end 
        else if (wr_en_q) begin
            mem[wr_ptr[PTR_WIDTH-1:0]] <= wr_data;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end


    // READ LOGIC (REGISTERED OUTPUT FIFO)

    always_ff @(posedge clk) begin
        if (rst) begin
            rd_ptr  <= '0;
            rd_data <= '0;   // avoid X
        end 
        else begin
            if (rd_en_q) begin
                rd_data <= mem[rd_ptr[PTR_WIDTH-1:0]];
                rd_ptr  <= rd_ptr + 1'b1;
            end
        end
    end

  
    // STATUS FLAGS
   

    // Empty: pointers equal
    assign empty = (wr_ptr == rd_ptr);

    // Full: same index but wrap bit different
    assign full  = (wr_ptr[PTR_WIDTH-1:0] == rd_ptr[PTR_WIDTH-1:0]) &&
                   (wr_ptr[PTR_WIDTH]     != rd_ptr[PTR_WIDTH]);

    // Count
    assign fifo_count = wr_ptr - rd_ptr;

    // Almost flags
    assign almost_full  = (fifo_count >= ALMOST_FULL_THRESH);
    assign almost_empty = (fifo_count <= ALMOST_EMPTY_THRESH);

    // ----------------------------------------
    // ERROR FLAGS
    // ----------------------------------------
    assign overflow  = wr_en & full;
    assign underflow = rd_en & empty;

endmodule : sync_fifo