vlib work
vdel -all
vlib work

vlog -f $1 +acc -sv 
vsim work.tb
#add wave -r *  //to be un-commented for first time simulation and line 8 to be commented then.
do wavehw26.do
run -all
