module t_Alarm;

 reg t_reset;
 reg t_clk;
 reg [1:0] t_hour_in1;
 reg [3:0] t_hour_in0;
 reg [3:0] t_min_in1;
 reg [3:0] t_min_in0;
 reg t_time_set;
 reg t_alarm_set;
 reg t_alarm_on;
 reg t_stop;


 wire t_alarm;
 wire [1:0] t_hour_out1;
 wire [3:0] t_hour_out0;
 wire [3:0] t_min_out1;
 wire [3:0] t_min_out0;
 wire [3:0] t_sec_out1;
 wire [3:0] t_sec_out0;
 
 parameter stop_time = 100000000;
 initial #stop_time $finish;
 
 
  Alarm m(t_reset, t_clk, t_hour_in1,t_hour_in0, t_min_in1, t_min_in0, t_time_set, t_alarm_set, t_alarm_on, t_stop, t_alarm, t_hour_out1, t_hour_out0, t_min_out1, t_min_out0, t_sec_out1, t_sec_out0);
 
 initial
  begin
    $dumpfile("dump_clock.vcd");
    $dumpvars(1,t_Alarm);
  end
  
initial
  begin
    t_clk = 0;
    forever #100 t_clk = ~t_clk;
  end
  
  
initial 
  begin
	t_reset = 1;
    t_hour_in1 = 1;
    t_hour_in0 = 7;
    t_min_in1 = 2;
    t_min_in0 = 2;
    t_time_set = 0;
    t_alarm_set = 0;
    t_alarm_on = 0;
    t_stop = 0;
    #1000;
    
	t_reset = 0;
    t_hour_in1 = 1;
    t_hour_in0 = 7;
    t_min_in1 = 2;
    t_min_in0 = 7;
    t_alarm_set = 1;
    t_alarm_on = 1;
    #1000;
    
    t_alarm_set = 0;
    
    wait(t_alarm);
    #1000;
    
    t_stop = 1;
    #1000;
    
	t_hour_in1 = 2;
    t_hour_in0 = 1;
    t_min_in1 = 2;
    t_min_in0 = 5;
    t_time_set = 1;
	t_stop = 0;
	#1000;
    
	t_hour_in1 = 2;
	t_hour_in0 = 1;
	t_min_in1 = 4;
	t_min_in0 = 5;
	t_time_set = 0;
	t_alarm_set = 1;
	t_stop = 0;
 
    wait(t_alarm);
    #1000;
    
    t_stop = 1;
  end
  
endmodule