module even_odd_merge_sorter
(
	input   logic [7:0] A,
	input   logic [7:0] B,
	input   logic [7:0] C,
	input   logic [7:0] D,
	output  logic [7:0] max,
	output  logic [7:0] second_max,
	output  logic [7:0] second_min,
	output  logic [7:0] min
);
	logic [7:0] sorter_1_max;
	logic [7:0] sorter_1_min;
	logic [7:0] sorter_2_max;
	logic [7:0] sorter_2_min;

	logic [7:0] sorter_3_min;
	logic [7:0] sorter_4_max;

	sorter sorter_1 (A, B, sorter_1_max, sorter_1_min);
	sorter sorter_2 (C, D, sorter_2_max, sorter_2_min);
	sorter sorter_3 (sorter_1_max, sorter_2_max, max, sorter_3_min);
	sorter sorter_4 (sorter_1_min, sorter_2_min, sorter_4_max, min);
	sorter sorter_5 (sorter_3_min, sorter_4_max, second_max, second_min);
endmodule


module even_odd_merge_sorter_pipeline
(
	input 	logic clk,
  	input 	logic rst,
	input   logic [7:0] A,
	input   logic [7:0] B,
	input   logic [7:0] C,
	input   logic [7:0] D,
	output  logic [7:0] max,
	output  logic [7:0] second_max,
	output  logic [7:0] second_min,
	output  logic [7:0] min
);
	logic [7:0] sorter_1_max [1:0];
	logic [7:0] sorter_1_min [1:0];
	logic [7:0] sorter_2_max [1:0];
	logic [7:0] sorter_2_min [1:0];

	logic [7:0] sorter_3_min [1:0];
	logic [7:0] sorter_4_max [1:0];

	logic [7:0] min_p;
	logic [7:0] max_p;

	sorter sorter_1 (A, B, sorter_1_max[0], sorter_1_min[0]);
	sorter sorter_2 (C, D, sorter_2_max[0], sorter_2_min[0]);
	sorter sorter_3 (sorter_1_max[1], sorter_2_max[1], max_p, sorter_3_min[0]);
	sorter sorter_4 (sorter_1_min[1], sorter_2_min[1], sorter_4_max[0], min_p);
	sorter sorter_5 (sorter_3_min[1], sorter_4_max[1], second_max, second_min);

	always_ff @(posedge clk) begin : Pipeline
		if (rst) begin
			sorter_1_max[1]	<= 0;
			sorter_1_min[1]	<= 0;
			sorter_2_max[1]	<= 0;
			sorter_2_min[1]	<= 0;
			sorter_3_min[1]	<= 0;
			sorter_4_max[1]	<= 0;
			max				<= 0;
			min				<= 0;
		end else begin
			sorter_1_max[1] <= sorter_1_max[0];
			sorter_1_min[1] <= sorter_1_min[0];
			sorter_2_max[1] <= sorter_2_max[0];
			sorter_2_min[1] <= sorter_2_min[0];
			sorter_3_min[1] <= sorter_3_min[0];
			sorter_4_max[1] <= sorter_4_max[0];
			max 			<= max_p;
			min 			<= min_p;
		end
	end
endmodule