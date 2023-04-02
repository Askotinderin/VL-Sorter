module even_odd_merge_sorter_wrapper #(parameter PIPELINE = 1)
(
    input   logic clk,
    input   logic rst,
    input   logic [7:0] A,
    input   logic [7:0] B,
    input   logic [7:0] C,
    input   logic [7:0] D,
    output  logic [7:0] max,
    output  logic [7:0] second_max,
    output  logic [7:0] second_min,
    output  logic [7:0] min
);

    logic [7:0] regA, regB, regC, regD;
    logic [7:0] reg_max, reg_second_max, reg_second_min, reg_min;

    // Register Input
    always_ff@(posedge clk) begin
        if (rst) begin
            regA <= 8'b0;
            regB <= 8'b0;
            regC <= 8'b0;
            regD <= 8'b0;
        end else begin
            regA <= A;
            regB <= B;
            regC <= C;
            regD <= D;
        end
    end

    // intsantiate even_odd_merge_sorter circuit
    generate
        if(PIPELINE == 0) begin
            even_odd_merge_sorter sorter_0
            (
                // Inputs
                regA, regB, regC, regD,
                // Outputs
                reg_max, reg_second_max, reg_second_min, reg_min
            );
        end else begin
            even_odd_merge_sorter_pipeline sorter_0
            (
                // Inputs
                clk, rst, regA, regB, regC, regD,
                // Outputs
                reg_max, reg_second_max, reg_second_min, reg_min
            );
        end
    endgenerate


    // Register Output
    always_ff@(posedge clk) begin
        if (rst) begin
            max        <= 8'b0;
            second_max <= 8'b0;
            second_min <= 8'b0;
            min        <= 8'b0;
        end else begin
            max        <= reg_max;
            second_max <= reg_second_max;
            second_min <= reg_second_min;
            min        <= reg_min;
        end
    end
endmodule