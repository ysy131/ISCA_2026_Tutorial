# ARTERY Feedback Tutorial

This repository contains the reproduced ARTERY feedback demo used for the ISCA tutorial presentation.

The project is organized into three parts:

```text
hardware/   Vivado 2024.2 FPGA project for the XCZU47DR board
software/   Python analysis library, API server, and demo scripts
ipynb/      Notebook tutorial entry for software-side feedback analysis
```

## Hardware Quick Start

```bash
cd hardware
vivado -mode batch -source run_synth.tcl
vivado -mode batch -source gen_bitstream.tcl
```

The generated bitstream is expected under the Vivado implementation run directory:

```text
hardware/custom_xczu47dr_rfdc.runs/impl_1/
```

For board testing, configure the host 10G NIC and run:

```bash
cd hardware
python3 tools/artery_ddr_latency_check.py \
  --interface enp225s0f0 \
  --iface-ip 192.168.1.3 \
  --fpga-ip 192.168.1.128 \
  --port 1234
```

## Software Quick Start

```bash
cd software
conda create -n qfeedback python=3.10
conda activate qfeedback
pip install -r requirements.txt
pip install -e .
```

Place `s21_data.mat` in `software/` before running the demo:

```bash
python example_library_usage.py
```

## API Demo

```bash
cd software
python3 api_server.py
```

The service runs at:

```text
http://localhost:5000
```

Main endpoints:

```text
POST /api/load
POST /api/cluster
POST /api/optimize
POST /api/predict
```

## GUI Demo

```bash
cd hardware/gui_demo
python3 artery_remote_control.py
```

The GUI can configure the bitstream, network parameters, S21 input file, FPGA programming command, UDP test command, and feedback waveform visualization.

## Repository Notes

Generated Vivado outputs are intentionally not included:

```text
*.bit
*.ltx
*.dcp
*.jou
*.log
*.wdb
custom_xczu47dr_rfdc.runs/
custom_xczu47dr_rfdc.gen/
custom_xczu47dr_rfdc.hw/
```

Rebuild them locally with Vivado 2024.2.
