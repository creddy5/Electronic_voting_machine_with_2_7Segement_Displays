# Electronic_voting_machine_with_2_7Segement_Displays
Digital Electronic Voting Machine (EVM) that counts votes for multiple candidates and displays the results using two 7-segment displays per candidate.

## 📘 **Project Overview**

This project implements a **digital Electronic Voting Machine (EVM)** using **Verilog HDL**, capable of counting votes for multiple candidates and displaying results on **two 7-segment displays** (tens & ones) per candidate.

---

## ⚙️ **Features**

| Feature                  | Description                                             |
| ------------------------ | ------------------------------------------------------- |
| ✅ Multi-candidate voting | Supports 3 candidates (P1, P2, P3) and NOTA             |
| ✅ Dual 7-segment display | Each candidate’s vote count shown on two 7-seg displays |
| ✅ Reset Functionality    | Clear all votes with `CLEAR` input                      |
| ✅ Synchronous Design     | Vote counting based on clock edge                       |
| ✅ Modular Structure      | Separate decoder module for reusability                 |
| ✅ FPGA Compatible        | Fully synthesizable and testable on hardware            |

---

## 🧩 **Module Descriptions**

### 🧠 Main Module — `EVM_2_7SegmentDisplay.v`

| Category           | Details                                                            |
| ------------------ | ------------------------------------------------------------------ |
| **Function**       | Handles vote counting and sends BCD digits to 7-segment decoders   |
| **Logic Type**     | Sequential (for counting) + Combinational (for display conversion) |
| **Reset Type**     | Asynchronous (`CLEAR`)                                             |
| **Counting Range** | 00 to 99 votes per candidate                                       |

### **Inputs**

| Signal  | Type  | Description                             |
| ------- | ----- | --------------------------------------- |
| `P1`    | Input | Vote button for Candidate 1             |
| `P2`    | Input | Vote button for Candidate 2             |
| `P3`    | Input | Vote button for Candidate 3             |
| `NOTA`  | Input | Vote button for None of the Above       |
| `CLK`   | Input | System clock signal for synchronization |
| `CLEAR` | Input | Active-high reset to clear all votes    |

### **Outputs**

| Signal            | Type            | Description                |
| ----------------- | --------------- | -------------------------- |
| `P1_VOTES_tens`   | Output (7 bits) | Tens digit for Candidate 1 |
| `P1_VOTES_ones`   | Output (7 bits) | Ones digit for Candidate 1 |
| `P2_VOTES_tens`   | Output (7 bits) | Tens digit for Candidate 2 |
| `P2_VOTES_ones`   | Output (7 bits) | Ones digit for Candidate 2 |
| `P3_VOTES_tens`   | Output (7 bits) | Tens digit for Candidate 3 |
| `P3_VOTES_ones`   | Output (7 bits) | Ones digit for Candidate 3 |
| `NOTA_VOTES_tens` | Output (7 bits) | Tens digit for NOTA        |
| `NOTA_VOTES_ones` | Output (7 bits) | Ones digit for NOTA        |

---

### 💡 Internal Signals

| Signal               | Width  | Description                  |
| -------------------- | ------ | ---------------------------- |
| `P1_VOTES`           | 7 bits | Vote counter for Candidate 1 |
| `P2_VOTES`           | 7 bits | Vote counter for Candidate 2 |
| `P3_VOTES`           | 7 bits | Vote counter for Candidate 3 |
| `NOTA_VOTES`         | 7 bits | Vote counter for NOTA        |
| `P1_tens`, `P1_ones` | 4 bits | Split digits for Candidate 1 |
| `P2_tens`, `P2_ones` | 4 bits | Split digits for Candidate 2 |
| `P3_tens`, `P3_ones` | 4 bits | Split digits for Candidate 3 |
| `N_tens`, `N_ones`   | 4 bits | Split digits for NOTA        |

---

## 🔢 **Submodule — `DisplayDecoder.v`**

| Category        | Details                                                    |
| --------------- | ---------------------------------------------------------- |
| **Function**    | Converts a 4-bit binary digit (0–9) to a 7-segment pattern |
| **Logic Type**  | Pure combinational                                         |
| **Reusability** | Can be used for any numeric display project                |

### **Input & Output Ports**

| Signal | Type   | Width  | Description                  |
| ------ | ------ | ------ | ---------------------------- |
| `in`   | Input  | 4 bits | BCD input digit (0–9)        |
| `out`  | Output | 7 bits | Corresponding 7-segment code |

### **Decoder Table**

| Decimal | Binary Input | 7-Segment Output | Display |
| ------- | ------------ | ---------------- | ------- |
| 0       | 0000         | 0000001          | 0       |
| 1       | 0001         | 1001111          | 1       |
| 2       | 0010         | 0010010          | 2       |
| 3       | 0011         | 0000110          | 3       |
| 4       | 0100         | 1001100          | 4       |
| 5       | 0101         | 0100100          | 5       |
| 6       | 0110         | 0100000          | 6       |
| 7       | 0111         | 0001111          | 7       |
| 8       | 1000         | 0000000          | 8       |
| 9       | 1001         | 0000100          | 9       |

---

## 🧪 **Simulation and Testing**

| Requirement         | Description                                                    |
| ------------------- | -------------------------------------------------------------- |
| **Tool**            | Xilinx Vivado / ModelSim                                       |
| **Simulation File** | `EVM_2_7SegmentDisplay_tb.v`                                   |
| **Test Inputs**     | Clock, Clear, and Vote buttons (P1–NOTA)                       |
| **Expected Output** | Vote counts increment and display correctly on 7-segment pairs |

---

### 🧾 **Example Test Sequence**

| Time (ns) | Action              | Expected Output        |
| --------- | ------------------- | ---------------------- |
| 0         | `CLEAR = 1`         | All displays show “00” |
| 10        | `CLEAR = 0, P1 = 1` | P1 count → 01          |
| 20        | `P2 = 1`            | P2 count → 01          |
| 30        | `P3 = 1`            | P3 count → 01          |
| 40        | `NOTA = 1`          | NOTA count → 01        |
| 50        | `P1 = 1`            | P1 count → 02          |
| 60        | `CLEAR = 1`         | All reset to “00”      |

---

## 🧠 **Design Highlights**

| Feature              | Benefit                                            |
| -------------------- | -------------------------------------------------- |
| Modular Design       | Separate decoder logic for reusability             |
| Asynchronous Reset   | Instantly clears vote counts                       |
| Synchronous Counting | Eliminates metastability                           |
| Compact Logic        | Optimized for FPGA resource usage                  |
| Easily Extendable    | Add more candidates or digits with minimal changes |

---

## 🔍 **Example Output Snapshot**

| Candidate | Display (Tens) | Display (Ones) | Count |
| --------- | -------------- | -------------- | ----- |
| P1        | 0000001        | 0000110        | 03    |
| P2        | 0000001        | 0010010        | 12    |
| P3        | 0000000        | 0000001        | 01    |
| NOTA      | 0000000        | 0000000        | 00    |

---

## 📁 **Project Structure**

| File Name                    | Description                    |
| ---------------------------- | ------------------------------ |
| `EVM_2_7SegmentDisplay.v`    | Main voting and display module |
| `DisplayDecoder.v`           | 7-segment decoder logic        |
| `EVM_2_7SegmentDisplay_tb.v` | Testbench for simulation       |
| `README.md`                  | Project documentation          |

---

## 💡 **Future Enhancements**

| Improvement             | Description                                         |
| ----------------------- | --------------------------------------------------- |
| Add Debounce Circuit    | To avoid multiple counts per button press           |
| Add Winner Detection    | Automatically identify the candidate with max votes |
| Add LCD Interface       | Display results on an LCD screen                    |
| Add Buzzer/LED          | Indicate valid/invalid votes                        |
| Expand to 6+ Candidates | Modular design allows easy scaling                  |

---



