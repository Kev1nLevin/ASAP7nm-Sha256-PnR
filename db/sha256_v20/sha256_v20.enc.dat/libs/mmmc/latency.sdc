set_clock_latency -source -early -max -rise  -70.3249 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -70.4237 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -70.3249 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -70.4237 [get_ports {clk}] -clock clk 
