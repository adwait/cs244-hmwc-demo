clear -all

# Disable some info messages and warning messages
# set_message -disable VERI-9033 ; # array automatically black-boxed
# set_message -disable WNL008 ; # module is undefined. All instances will be black-boxed
# set_message -disable VERI-1002 ; # Can't disable this error message (net does not have a driver)
# set_message -disable VERI-1407 ; # attribute target identifier not found in this scope
set_message -disable VERI-1018 ; # info
set_message -disable VERI-1328 ; # info
set_message -disable VERI-2571 ; # info
# set_message -disable VERI-2571 ; # info: disabling old hierarchical reference handler
set_message -disable INL011 ; # info: processing file
# set_message -disable VERI-1482 ; # analyzing verilog file
set_message -disable VERI-1141 ; # system task is not supported
set_message -disable VERI-1060 ; # 'initial' construct is ignored
set_message -disable VERI-1142 ; # system task is ignored for synthesis
# set_message -disable ISW003 ; # top module name
# set_message -disable HIER-8002 ; # disabling old hierarchical reference handler
set_message -disable WNL046 ; # renaming embedded assertions due to name conflicts
set_message -disable VERI-1995 ; # unique/priority if/case is not full
                                 # (we check these conditions with the elaborate
                                 #  option -extract_case_assertions)

set JASPER_FILES {
    demo1.v
}

set env(DESIGN_HOME) [pwd]
set err_status [catch {analyze -sv12 +define+INVARIANTS +define+JASPER +define+SYNTHESIS +libext+.v+.sv+.vh+.svh+ {*}$JASPER_FILES} err_msg]
if $err_status {error $err_msg}

elaborate     -top simple_state_machine_tb     -no_preconditions     -extract_case_assertions     -disable_auto_bbox

proc write_reset_seq {file} {
    puts $file "fvreset 1'b1"
    puts $file 1
    puts $file "fvreset 1'b0"
    puts $file {$}
    close $file
}

proc reset_formal {} {
    write_reset_seq  [open "reset.rseq" w]
    # reset -expression fvreset
    reset -sequence "reset.rseq"
}


clock clk

# Constrain primary inputs to only change on @(posedge eph1)
clock -rate -default clk

reset_formal

# Set default Jasper proof engines (overrides use_nb engine settings)
set_engine_mode {Ht}

set_max_trace_length 4

