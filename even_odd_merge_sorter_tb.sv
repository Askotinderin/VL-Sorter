module even_odd_merge_sorter_tb;

parameter MEM_SIZE = 30;

parameter PIPELINE = 1;

logic clk, rst;

logic [7:0] A;
logic [7:0] B;
logic [7:0] C;
logic [7:0] D;
logic [7:0] max;
logic [7:0] second_max;
logic [7:0] second_min;
logic [7:0] min;

logic [63:0] test_memory[0:MEM_SIZE-1];
integer i;

always begin
    clk <= 1;
    #5ns;
    clk <=0;
    #5ns;
end

even_odd_merge_sorter_wrapper #(.PIPELINE(PIPELINE)) sorter_0
(
    clk, rst, A, B, C, D,
    max, second_max, second_min, min
);

initial begin
    $monitor($time, " max=%h, second_max=%h, second_min=%h, min=%h", max, second_max, second_min, min);
    $display("Loading test vectors");
    $readmemh("test.tv", test_memory);
    rst <= 1;
    repeat(2) @(posedge clk);
    rst <= 0;
    for (i=0; i<MEM_SIZE; i=i+1) begin
        {A, B, C, D} = test_memory[i];
        @(posedge clk);
    end

    repeat(5) @(posedge clk);
    $stop();
end
endmodule