vlib work
vlog -sv bus_trans_v2_pkg.sv bus_trans_pkg.sv casting_trans_pkg.sv
vlog -sv bus_trans.sv derived_trans.sv bus_trans_v2.sv derived_trans_v2.sv
vlog -sv tb_oop.sv tb_constrained.sv tb_casting.sv
quit -force