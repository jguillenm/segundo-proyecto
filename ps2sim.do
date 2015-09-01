vsim -gui -L unisim ps2sim unisim.glbl
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /ps2sim/reset
add wave -noupdate -radix binary /ps2sim/clk
add wave -noupdate -radix binary /ps2sim/ps2d
add wave -noupdate -radix binary /ps2sim/ps2c
add wave -noupdate -radix binary /ps2sim/datolisto
add wave -noupdate -radix binary /ps2sim/tempenable
add wave -noupdate -radix binary /ps2sim/humoenable
add wave -noupdate -radix binary /ps2sim/cor
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {45590035314 ps}
run -all