module sync_fifo #(
    parameter int DATA_WIDTH          = 8,
    parameter int DEPTH               = 16,
    parameter int ALMOST_FULL  = DEPTH - 2,
    parameter int ALMOST_EMPTY = 2
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

   
    // Local parameters
 
    localparam int PTR_WIDTH = $clog2(DEPTH);


    // Memory array

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Pointers  (one extra MSB = wrap bit for full/empty discrimination)

    logic [PTR_WIDTH:0] wr_ptr;
    logic [PTR_WIDTH:0] rd_ptr;

    // Qualified enables  (hardware guard rails)
 
    logic wr_en_q, rd_en_q;

    assign wr_en_q = wr_en & ~full;
    assign rd_en_q = rd_en & ~empty;

    