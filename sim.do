quit -sim
file delete -force work

vlib work
vlog -f files.f

vsim even_odd_merge_sorter_tb
log -r /*

add wave -position end -label clock -color #ff0000 sim:/even_odd_merge_sorter_tb/clk
add wave -position end -label reset -color #ff0000 sim:/even_odd_merge_sorter_tb/rst

add wave -position end -radix unsigned -group inputs -label A -color #00ff00 sim:/even_odd_merge_sorter_tb/A
add wave -position end -radix unsigned -group inputs -label B -color #00ff00 sim:/even_odd_merge_sorter_tb/B
add wave -position end -radix unsigned -group inputs -label C -color #00ff00 sim:/even_odd_merge_sorter_tb/C
add wave -position end -radix unsigned -group inputs -label D -color #00ff00 sim:/even_odd_merge_sorter_tb/D

add wave -position end -radix unsigned -group outputs -color #0000ff -label Max sim:/even_odd_merge_sorter_tb/max
add wave -position end -radix unsigned -group outputs -color #0000ff -label Max2 sim:/even_odd_merge_sorter_tb/second_max
add wave -position end -radix unsigned -group outputs -color #0000ff -label Min2 sim:/even_odd_merge_sorter_tb/second_min
add wave -position end -radix unsigned -group outputs -color #0000ff -label Min sim:/even_odd_merge_sorter_tb/min



run -all

wave zoom range 0ps 120000ps