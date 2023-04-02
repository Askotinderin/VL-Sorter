module sorter
(
    input   logic [7:0] A,
    input   logic [7:0] B,
    output  logic [7:0] max,
    output  logic [7:0] min
);

always_comb begin
    if (A > B) begin
        max = A;
        min = B;
    end else begin
        max = B;
        min = A;
    end
end

endmodule