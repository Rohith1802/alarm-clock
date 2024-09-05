module Alarm(input reset, input clk, input [1:0] hour_in1, input [3:0] hour_in0, input [3:0] min_in1, input [3:0] min_in0, input time_set, input alarm_set, input alarm_on, input stop, output reg alarm, output [1:0] hour_out1, output [3:0] hour_out0, output [3:0] min_out1, output [3:0] min_out0, output [3:0] sec_out1, output [3:0] sec_out0);

reg [5:0] temp_hour, temp_min, temp_sec;
reg [1:0] clock_hr1, alarm_hr1;
reg [3:0] clock_hr0, alarm_hr0;
reg [3:0] clock_min1, alarm_min1;
reg [3:0] clock_min0, alarm_min0;
reg [3:0] clock_sec1, alarm_sec1;
reg [3:0] clock_sec0, alarm_sec0;
  
function [3:0] modulo;
input [5:0] number;
begin
if(number >= 50)
  modulo = 5;
else if(number >= 40)
  modulo = 4;
else if(number >= 30)
  modulo = 3;
else if(number >= 20)
  modulo = 2;
else if(number >= 10)
  modulo = 1;
else
  modulo = 0;
end
endfunction
  
always @ (posedge clk or posedge reset)
begin
if(reset) begin
  alarm_hr1 <= 2'b00;
  alarm_hr0 <= 4'b0000;
  alarm_min1 <= 4'b0000;
  alarm_min0 <= 4'b0000;
  alarm_sec1 <= 4'b0000;
  alarm_sec0 <= 4'b0000;
    
  temp_hour <= 0;
  temp_min <= 0;
  temp_sec <= 0;
  end
else begin
  if(time_set) begin
      temp_hour <= 10*hour_in1 + hour_in0;
      temp_min <= 10*min_in1 + min_in0;
      temp_sec <= 0;
    end
    if(alarm_set)
      begin
        alarm_hr1 <= hour_in1;
        alarm_hr0 <= hour_in0;
        alarm_min1 <= min_in1;
        alarm_min0 <= min_in0;
        alarm_sec1 <= 4'b0000;
        alarm_sec0 <= 4'b0000;
      end
    else
      begin
        temp_sec <= temp_sec + 1;
        if(temp_sec >= 59)
          begin
            temp_min <= temp_min + 1;
            temp_sec <= 0;
          end
        if(temp_min >= 59)
          begin
            temp_hour <= temp_hour + 1;
            temp_min <= 0;
          end
        if(temp_hour >= 24)
          begin
            temp_hour <= 0;
          end
      end
  end
end
  
always @ (*)
  begin
    if(temp_hour >= 20)
      begin
        clock_hr1 = 2;
      end
	else begin
		if(temp_hour >= 10)
			clock_hr1 = 1;
		else
      clock_hr1 = 0;
  end
  
  clock_hr0 = temp_hour - 10*clock_hr1;
  clock_min1 = modulo(temp_min);
  clock_min0 = temp_min - 10*clock_min1;
  clock_sec1 = modulo(temp_sec);
  clock_sec0 = temp_sec - 10*clock_sec1;
  
end
  
assign hour_out1 = clock_hr1;
assign hour_out0 = clock_hr0;
assign min_out1 = clock_min1;
assign min_out0 = clock_min0;
assign sec_out1 = clock_sec1;
assign sec_out0 = clock_sec0;
  
always @ (posedge clk or posedge reset)
  begin
    if(reset)
      alarm <= 0;
    else
      begin
        if({alarm_hr1, alarm_hr0, alarm_min1, alarm_min0, alarm_sec1, alarm_sec0} == {clock_hr1, clock_hr0, clock_min1, clock_min0, clock_sec1, clock_sec0})
          begin
            if(alarm_on)
              alarm <= 1;
          end
        if(stop)
          alarm <= 0;
      end
  end

endmodule