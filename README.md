# FPGA_VerilogHDL_implementation

The receiver side of serial communication uses a special baud rate generator that starts generating the baud rate when the first falling edge signal is detected and the first baud rate is pulsed at half a baud cycle and each subsequent pulse is a full baud cycle. This means that each sampling pulse is in the middle of the signal, which can effectively reduce the sampling error caused by signal interference.

Transmitter RTL view:
![RTL](https://github.com/Cam2024/FPGA_VerilogHDL_implementation/assets/89662823/405feccd-7d3a-4fa1-a7ea-854421292f77)

Block view:
![block](https://github.com/Cam2024/FPGA_VerilogHDL_implementation/assets/89662823/a5edb079-d59c-482e-b7b8-99355abbab3f)

Controller RTL view:
![controller](https://github.com/Cam2024/FPGA_VerilogHDL_implementation/assets/89662823/f1557e92-1db5-49c3-b455-582f07bc125d)

Shift register view:
![register](https://github.com/Cam2024/FPGA_VerilogHDL_implementation/assets/89662823/1787ea36-a0cd-45a7-b1fd-b4afe5437f5f)

Receiver RTL view:
![rx_RTL](https://github.com/Cam2024/FPGA_VerilogHDL_implementation/assets/89662823/8a5e936d-82f1-4dcf-a25e-e35cd174b5d8)

Customized baud rate generator:
![baud_rx](https://github.com/Cam2024/FPGA_VerilogHDL_implementation/assets/89662823/793de947-5bdc-4b37-881c-3408073b161e)

See file for detailed design drawings
