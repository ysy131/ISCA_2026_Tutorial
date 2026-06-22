# Hardware: ARTERY Feedback on XCZU47DR

This directory contains the latest Vivado 2024.2 hardware project for the reproduced ARTERY feedback path.

The project receives S21/IQ data from the host through 10G UDP, writes the data into DDR, streams it into the ARTERY feedback logic, and returns the selected feedback result to the host.

## Directory Layout

```text
custom_xczu47dr_rfdc.xpr       Vivado project
custom_xczu47dr_rfdc.srcs/     RTL, block design, IP metadata, constraints
tools/                         UDP test and latency scripts
gui_demo/                      Remote-control GUI demo
run_synth.tcl                  Synthesis script
gen_bitstream.tcl              Implementation and bitstream script
program_fpga.sh                FPGA programming helper
```

## Build

```bash
vivado -mode batch -source run_synth.tcl
vivado -mode batch -source gen_bitstream.tcl
```

## Board Test

Default network parameters:

```text
Host NIC: enp225s0f0
Host IP: 192.168.1.3
FPGA IP: 192.168.1.128
UDP port: 1234
```

Run a latency and feedback test:

```bash
python3 tools/artery_ddr_latency_check.py \
  --interface enp225s0f0 \
  --iface-ip 192.168.1.3 \
  --fpga-ip 192.168.1.128 \
  --port 1234
```

Run a basic UDP check:

```bash
python3 tools/artery_udp_check.py \
  --interface enp225s0f0 \
  --iface-ip 192.168.1.3 \
  --fpga-ip 192.168.1.128 \
  --port 1234
```

## GUI

```bash
cd gui_demo
python3 artery_remote_control.py
```

The GUI provides bitstream/Tcl selection, FPGA programming, UDP testing, live metadata display, and feedback waveform visualization.

## Main Hardware Modules

```text
ARTERYTop.v                 ARTERY feedback core
artery_ddr_udp_feedback.v   DDR-to-ARTERY feedback datapath
udp_waveform_ddr_writer.v   UDP payload to DDR writer
waveform_system_top.v       Top-level waveform/feedback system
artery_network_top.v        Network integration top
feedback_branch0.mem        Feedback waveform branch 0
feedback_branch1.mem        Feedback waveform branch 1
s21_template_weights.vh     S21/template weights used by feedback logic
```

## Notes

Generated Vivado outputs are not committed. Recreate them locally with Vivado 2024.2.

<!-- Original project notes below. -->

This Vivado project connects the generated ARTERY RTL core to a 10G UDP datapath on the XCZU47DR board. Host software sends 1024 IQ samples over UDP, the FPGA runs one ARTERY window, and the FPGA replies with one 64-bit UDP result word.

## Current Status

- FPGA top: `artery_network_top`
- FPGA IP/port: `192.168.1.128:1234`
- Host test IP/port: `192.168.1.3:1234`
- Tested NIC: `enp225s0f0`
- Clock: differential PL clock through `IBUFDS`/`BUFG`, used as 100 MHz system clock
- Last board test: `artifacts/artery_udp_results_20260527_014940.csv`

The latest board test sent 20 repeated 1024-sample ramp windows. Window 0 starts from cold history and predicts incorrectly; windows 1-19 predict correctly. There are no contradictory rows where `pred_correct` disagrees with `pred_state == actual_state`.

## Important Files

- `custom_xczu47dr_rfdc.xpr`: Vivado project
- `custom_xczu47dr_rfdc.srcs/sources_1/imports/hardware/vivado/src/artery_network_top.v`: network + ARTERY integration top
- `custom_xczu47dr_rfdc.srcs/sources_1/imports/hardware/vivado/src/ARTERYTop.v`: generated ARTERY RTL with local fixes
- `custom_xczu47dr_rfdc.srcs/sources_1/imports/hardware/vivado/src/udp/`: 10G UDP stack
- `custom_xczu47dr_rfdc.srcs/constrs_1/imports/xdc/custom_xczu47dr_minimal.xdc`: board constraints
- `run_synth.tcl`: synthesis script
- `gen_bitstream.tcl`: implementation and bitstream script
- `tools/artery_udp_check.py`: send one window and print one FPGA reply
- `tools/artery_udp_visualize.py`: send repeated windows, save CSV and PNG

## Result Word Format

The FPGA UDP reply is one 64-bit little-endian word. Only the low 3 bits are currently used:

- bit 0: `pred_state`
- bit 1: `actual_state`
- bit 2: `pred_correct`

Example:

- `0x0000000000000002`: `pred_state=0`, `actual_state=1`, `pred_correct=0`
- `0x0000000000000007`: `pred_state=1`, `actual_state=1`, `pred_correct=1`

## Key RTL Fixes

The current RTL includes fixes for the issues seen during network testing:

- The demodulator accumulator is cleared at each network-fed window start, while keeping the first sample in the new window.
- `sample_index` wraps every 1024 samples so repeated UDP windows produce repeated ARTERY results.
- ARTERY status outputs are registered together on classifier-valid, so prediction, actual state, and correctness are one coherent snapshot.
- UDP TX packs `pred_correct` from the same returned `pred_state/actual_state` pair.
- The branch history table now updates from classifier results instead of staying fixed.
- When both classifier centers are left at the default zero value, classification falls back to the sign of demodulated I instead of relying on an equal-distance tie.

## Build

Run from this directory:

```bash
vivado -mode batch -source run_synth.tcl
vivado -mode batch -source gen_bitstream.tcl
```

Expected bitstream path:

```text
custom_xczu47dr_rfdc.runs/impl_1/artery_network_top.bit
```

The current implementation reports ARTERY logic timing as met. The remaining known timing warning is in the XXV Ethernet status/CDC path, not in the ARTERY datapath.

## Board Test

Make sure the host NIC has `192.168.1.3/24` and the 10G link is up:

```bash
ip addr show enp225s0f0
ethtool enp225s0f0
```

Send one 1024-sample window:

```bash
python3 tools/artery_udp_check.py \
  --interface enp225s0f0 \
  --iface-ip 192.168.1.3 \
  --fpga-ip 192.168.1.128 \
  --port 1234 \
  --samples 1024 \
  --mode ramp \
  --gap-us 100 \
  --timeout 5
```

Run a repeated-window test and save CSV/PNG:

```bash
python3 tools/artery_udp_visualize.py \
  --interface enp225s0f0 \
  --iface-ip 192.168.1.3 \
  --fpga-ip 192.168.1.128 \
  --port 1234 \
  --windows 20 \
  --samples 1024 \
  --mode ramp \
  --gap-us 100 \
  --timeout 3
```

To validate a CSV:

```bash
python3 - <<'PY'
import csv
p = "artifacts/artery_udp_results_20260527_014940.csv"
rows = list(csv.DictReader(open(p)))
bad = [r for r in rows if int(r["pred_correct"]) != int(int(r["pred_state"]) == int(r["actual_state"]))]
print("rows", len(rows), "bad_rows", len(bad), "correct_rows", sum(int(r["pred_correct"]) for r in rows))
PY
```

Expected for the included final CSV:

```text
rows 20 bad_rows 0 correct_rows 19
```
