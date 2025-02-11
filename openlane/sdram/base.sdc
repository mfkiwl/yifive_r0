# SPDX-FileCopyrightText:  2021 , Dinesh Annayya
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileContributor: Modified by Dinesh Annayya <dinesha@opencores.org>


set_units -time ns
set ::env(WB_CLOCK_PERIOD) "10"
set ::env(WB_CLOCK_PORT)   "wb_clk_i"
set ::env(WB_CLOCK_NAME)   "wb_clk"

set ::env(SDRAM_CLOCK_PERIOD) "20"
set ::env(SDRAM_CLOCK_PORT)   "sdram_clk"
set ::env(SDRAM_CLOCK_NAME)   "sdram_clk"

set ::env(PAD_SDRAM_CLOCK_PERIOD) "20"
set ::env(PAD_SDRAM_CLOCK_PORT)   "io_in\[29\]"
set ::env(PAD_SDRAM_CLOCK_NAME)   "pad_sdram_clk"
######################################
# WB Clock domain input output
######################################
create_clock [get_ports $::env(WB_CLOCK_PORT)]  -name $::env(WB_CLOCK_NAME)  -period $::env(WB_CLOCK_PERIOD)
set wb_input_delay_value [expr $::env(WB_CLOCK_PERIOD) * 0.6]
set wb_output_delay_value [expr $::env(WB_CLOCK_PERIOD) * 0.6]
puts "\[INFO\]: Setting wb output delay to:$wb_output_delay_value"
puts "\[INFO\]: Setting wb input delay to: $wb_input_delay_value"


set_input_delay 2.0 -clock [get_clocks $::env(WB_CLOCK_NAME)] {wb_rst_n}

set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port wb_stb_i*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port wb_addr_i*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port wb_we_i*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port wb_dat_i*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port wb_sel_i*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port wb_cyc_i*]

set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_tras_d*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_trp_d*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_trcd_d*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_en*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_req_depth*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_mode_reg*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_cas*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_trcar_d*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_twr_d*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_rfsh*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_rfmax*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_colbits*]
set_input_delay  $wb_input_delay_value   -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port cfg_sdr_width*]

set_output_delay $wb_output_delay_value  -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port wb_dat_o*]
set_output_delay $wb_output_delay_value  -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port wb_ack_o*]
set_output_delay $wb_output_delay_value  -clock [get_clocks $::env(WB_CLOCK_NAME)] [get_port sdr_init_done*]

######################################
# SDRAM Clock domain input output
######################################
create_clock [get_ports $::env(SDRAM_CLOCK_PORT)]  -name $::env(SDRAM_CLOCK_NAME)  -period $::env(SDRAM_CLOCK_PERIOD)
set sdram_input_delay_value [expr $::env(SDRAM_CLOCK_PERIOD) * 0.6]
set sdram_output_delay_value [expr $::env(SDRAM_CLOCK_PERIOD) * 0.6]
puts "\[INFO\]: Setting wb output delay to:$wb_output_delay_value"
puts "\[INFO\]: Setting wb input delay to: $wb_input_delay_value"

set_input_delay 2.0 -clock [get_clocks $::env(SDRAM_CLOCK_NAME)] {sdram_resetn}

set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[0]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[1]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[2]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[3]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[4]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[5]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[6]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[7]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[8]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[9]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[10]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[11]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[12]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[13]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[14]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[15]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[16]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[17]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[18]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[19]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[20]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[21]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[22]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[23]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[24]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[25]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[26]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[27]]
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[28]]
#set_output_delay $sdram_output_delay_value  -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[29]] Masked SDRAM clock
set_output_delay $sdram_output_delay_value  -max -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_oeb*]

set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[0]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[1]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[2]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[3]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[4]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[5]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[6]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[7]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[8]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[9]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[10]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[11]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[12]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[13]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[14]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[15]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[16]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[17]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[18]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[19]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[20]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[21]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[22]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[23]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[24]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[25]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[26]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[27]]
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_out[28]]
#set_output_delay $sdram_output_delay_value  -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_outp 29]] Masked SDRAM clock
set_output_delay -0.5  -min -clock [get_clocks $::env(SDRAM_CLOCK_PORT)] [get_port io_oeb*]

################################################
# PAD SDRAM Clock domain input output
# Note: PAD SDRAM clock is same as SDRAM clock
#       it's a feedback clock through pads
################################################

create_clock [get_ports $::env(PAD_SDRAM_CLOCK_PORT)]  -name $::env(PAD_SDRAM_CLOCK_NAME)  -period $::env(SDRAM_CLOCK_PERIOD)
set_input_delay  $sdram_input_delay_value -max  -clock [get_clocks $::env(PAD_SDRAM_CLOCK_NAME)] [get_port io_in*]
set_input_delay  1                        -min -clock [get_clocks $::env(PAD_SDRAM_CLOCK_NAME)] [get_port io_in*]


set_clock_groups -name async_clock -asynchronous -comment "Async Clock group" -group [get_clocks $::env(WB_CLOCK_NAME)] -group [get_clocks $::env(SDRAM_CLOCK_NAME)]

## Add clock uncertainty
#Note: We have PAD_SDRAM_CLOCK_NAME => SDRAM_CLOCK_NAME path only
set_clock_uncertainty -from $::env(WB_CLOCK_NAME)        -to $::env(WB_CLOCK_NAME)    -setup 0.400
set_clock_uncertainty -from $::env(SDRAM_CLOCK_NAME)     -to $::env(SDRAM_CLOCK_NAME) -setup 0.400
set_clock_uncertainty -from $::env(PAD_SDRAM_CLOCK_NAME) -to $::env(SDRAM_CLOCK_NAME) -setup 0.400

set_clock_uncertainty -from $::env(WB_CLOCK_NAME)        -to $::env(WB_CLOCK_NAME)    -hold 0.050
set_clock_uncertainty -from $::env(SDRAM_CLOCK_NAME)     -to $::env(SDRAM_CLOCK_NAME) -hold 0.050
set_clock_uncertainty -from $::env(PAD_SDRAM_CLOCK_NAME) -to $::env(SDRAM_CLOCK_NAME) -hold 0.050 

# TODO set this as parameter
set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]
set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]

