# 4-bit Logic Comparator | VHDL / Basys 3 FPGA

## Overview

An academic digital-design project developed in **VHDL** using **Xilinx Vivado** and implemented for the **Digilent Basys 3 FPGA** board. The circuit compares three unsigned 4-bit inputs: **A is compared independently with B and C**, and a priority-based indication of the comparison results is shown on a seven-segment display.

## Technologies

- VHDL (`IEEE.STD_LOGIC_1164` and `IEEE.NUMERIC_STD`)
- Xilinx Vivado (synthesis and FPGA implementation)
- Digilent Basys 3 FPGA board

## Design and Functionality

- Implements combinational logic for the relationships `A < B`, `A = B`, `A > B`, `A < C`, `A = C`, and `A > C`.
- Converts the 4-bit input vectors to `unsigned` for numeric comparisons.
- Maps the input values to the Basys 3 switches:
  - **A:** SW0–SW3
  - **B:** SW4–SW7
  - **C:** SW8–SW11
- Drives the active-low seven-segment outputs (`seg`) and digit enables (`an`). In the current implementation, **only AN0 is enabled** (`an = "1110"`); the digits are **not multiplexed**.

### Display Logic

The two comparisons are evaluated separately, but the display presents **one combined, priority-based result**, rather than showing both outcomes independently:

| Priority | Condition | Display indication |
| --- | --- | --- |
| 1 (highest) | `A < B` **or** `A < C` | Less-than pattern |
| 2 | `A = B` **or** `A = C` | Equality pattern |
| 3 | `A > B` **or** `A > C` | Greater-than pattern |

The priority order matters when the two comparisons produce different outcomes. The design is combinational and does not require a clock.

## Hardware Testing and Verification

The design was tested directly on the Basys 3 FPGA board. Input values were set using switches SW0–SW11, and the resulting comparison indication was observed on the seven-segment display.
This approach allowed the implemented combinational logic and the FPGA input/output connections to be checked on physical hardware.

## How to Open and Run

1. Open [`project_final.xpr`](project_final.xpr) in Xilinx Vivado.
2. Check that `Comparator` is the top-level design and that the supplied `.xdc` constraints are enabled.
3. Run synthesis, implementation, and bitstream generation.
4. Program a Basys 3 board and adjust SW0–SW11 to observe the seven-segment output.

