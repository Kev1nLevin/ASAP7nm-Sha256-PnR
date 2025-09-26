# SHA-256 ASIC Physical Design Flow (ASAP7)

This repository provides a complete **RTL-to-GDSII digital design flow** for the **SHA-256 cryptographic hash function**, targeting the **ASAP7 7nm Predictive PDK**. The flow uses **Cadence Genus** for synthesis and **Cadence Innovus** for place-and-route (P&R), along with a **multi-mode multi-corner (MMMC)** setup for timing closure.

---

# Snapshot

<img width="2560" height="1440" alt="Screenshot from 2025-09-26 17-11-22" src="https://github.com/user-attachments/assets/b969a012-2a9c-4044-8c30-c051122c7a70" />


---

## 📂 Repository Structure

```
├── scripts/
│   ├── genus.tcl         # Genus synthesis script
│   ├── innovus.tcl       # Innovus place-and-route script
│   ├── sha256.mmmc       # MMMC timing configuration
├── sources/              # RTL sources for SHA-256
│   ├── sha256.v
│   ├── sha256_core.v
│   ├── sha256_k_constants.v
│   └── sha256_w_mem.v
├── lib/                  # Standard cell libraries (ASAP7)
├── lef/                  # Library Exchange Format files
├── techlef/              # Technology LEF
├── qrc/                  # QRC technology files
├── db/                   # Innovus database outputs
├── sdc/                  # Design constraints (sha256.sdc)
└── run/                  # Netlist and run outputs
```

---

## 🚀 Flow Overview

### 1. **Logic Synthesis (Genus)**
- Script: [`genus.tcl`](scripts/genus.tcl)
- Key features:
  - Loads **RTL sources** for the SHA-256 design:
    - `sha256.v`, `sha256_core.v`, `sha256_k_constants.v`, `sha256_w_mem.v`
  - Uses **ASAP7 standard cell libraries**:
    - Low-Vt (LVT) and super-low-Vt (SLVT) AO, INVBUF, OA, SEQ, SIMPLE cells
  - Reads LEF and technology LEF files
  - Outputs synthesized **gate-level netlist**

Command to run:
```tcl
genus -files scripts/genus.tcl | tee genus.log
```

---

### 2. **Place & Route (Innovus)**
- Script: [`innovus.tcl`](scripts/innovus.tcl)
- Key features:
  - Sets **top module**: `sha256`
  - Loads **netlist from Genus**
  - Reads technology LEF (`asap7_tech_4x_201209.lef`) and standard cell LEFs
  - Defines power/ground nets (`VDD`, `VSS`)
  - Loads MMMC file for timing closure
  - Initializes floorplan, placement, CTS, routing

Command to run:
```tcl
innovus -files scripts/innovus.tcl | tee innovus.log
```

---

### 3. **MMMC (Timing Closure)**
- Script: [`sha256.mmmc`](scripts/sha256.mmmc)
- Key features:
  - Defines **library sets** using ASAP7 Liberty timing files
  - Sets **constraint mode** from SDC (`sha256.sdc`)
  - Creates **RC corner** using QRC tech file
  - Defines **delay corners**
  - Configures **setup and hold analysis views**

---

## 📊 Design Target

- **Design**: SHA-256 Cryptographic Core  
- **PDK**: ASAP7 (Predictive 7nm, scaled)  
- **Tools**:  
  - Cadence **Genus** (RTL synthesis)  
  - Cadence **Innovus** (place-and-route)  
- **Objectives**:
  - Perform RTL → Netlist → P&R → Timing Closure
  - Generate **final GDSII** for fabrication-ready layout

---

## 📝 Notes

- The scripts are configured for **ASAP7** libraries. Modify paths (`LIB_PATH`, `LEF_PATH`, etc.) in `genus.tcl` and `innovus.tcl` to point to your installation.  
- Ensure **QRC technology files** and **SDC constraints** are correctly set.  
- The flow assumes **Linux environment** with proper tool licenses.  

---

## ✅ Future Improvements
- Add power intent support with **CPF/UPF**  
- Include multiple process-voltage-temperature (PVT) corners  
- Automate DRC/LVS with **Cadence Pegasus/Calibre**  
- Add reports for area, timing, and power  

---

🔒 *This project is for research and educational purposes using the ASAP7 predictive PDK. It is not intended for commercial use.*  
