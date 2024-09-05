# Alarm clock

Introduction

The Alarm Clock project in verilog is a digital design that replicates the functionality of an alarm clock. It allows users to set alarm times, enable alarms, and stop them when triggered. This project is implemented in verilog and can be synthesized and run on an FPGA or simulated using a simulator.

Features

1. Set custom alarm times.
2. Enable and disable alarms.
3. Stop alarms when they trigger.
4. Suitable for FPGA implementation or simulation.

Prerequisite

The repository contains the main verilog code and its test bench. Compile and run both of them in a verilog-compatible FPGA development environment (e.g., Xilinx Vivado, EDA playground).

Main code: alarm.v

This module emulates a digital alarm clock with alarm-setting and stopping functionality. It keeps track of hours, minutes, and seconds based on an external clock signal, allowing the user to set a custom time and date. When set, it counts time; otherwise, it increments time based on the clock signal. Users can set an alarm time and enable or disable the alarm. When the current time matches the set alarm time and the alarm is enabled, it triggers an alarm signal. The alarm can be stopped by a control signal called stop.  

Test bench

The testbench (t_Alarm) simulates the "AlarmClock" module by providing clock, control, and input signals. It sets and tests alarm functionality, capturing simulation data, and finishes the simulation after a defined duration.
