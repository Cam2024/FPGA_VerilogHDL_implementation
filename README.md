# FPGA_VerilogHDL_implementation

The pulse logic of the baud pulse generator can be changed externally.1 is generated immediately. hex 28A is generating baud pulses in the middle of the data points (in case of 38400 baud rate) for serial digital signal sampling. This means that each sampling pulse is in the middle of the signal, which can effectively reduce the sampling error caused by signal interference.

UART RTL view:
![UART_RTL](https://github.com/Cam2024/FPGA_VerilogHDL_implementation/assets/89662823/fb842d54-03b6-4127-b4bc-fdaa96b84f5e)

BDF Block view:
![UART_BDF](https://github.com/Cam2024/FPGA_VerilogHDL_implementation/assets/89662823/6ff96c0c-2fd2-48f7-8ef5-9e670f5c398e)

See file for detailed design drawings
