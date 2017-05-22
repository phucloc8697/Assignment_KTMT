transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/ALU_CONTROL.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/ALU.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/IMEM.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/REG.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/MUX.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/DMEM.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/CONTROL.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/ADDER.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/SIGN_EXTEND.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/SHIFT_LEFT_2.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/REG_IF_ID.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/REG_ID_EXE.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/REG_EXE_MEM.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/REG_MEM_WB.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/EXCEPTION_HANDLE.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/SYSTEM.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/IMEM_BRAM.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/PC.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/mux_8.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/and_branch.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/epc.v}
vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/hexto7segment.v}

vlog -vlog01compat -work work +incdir+F:/Document/Study/Semester\ 4th/Computer\ Architecture/Assignment_KTMT/Assignment_2 {F:/Document/Study/Semester 4th/Computer Architecture/Assignment_KTMT/Assignment_2/t_SYSTEM.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  t_SYSTEM

add wave *
view structure
view signals
run -all
