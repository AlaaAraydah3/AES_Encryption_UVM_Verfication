vlog  my_pkg.sv top.sv +cover
vsim -batch top -coverage  
run -all
coverage report -codeAll -cvg -verbose -file coverage_report.txt
