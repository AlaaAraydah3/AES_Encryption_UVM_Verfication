**AES Encryption UVM Verification**
This project implements Advanced Encryption Standard (AES) encryption in hardware and verifies it using the Universal Verification Methodology (UVM). The goal is to create a comprehensive testbench that thoroughly validates the functionality and correctness of the AES encryption module.

**Key Features**
--------------------------------------------------------------------------------------------------------------------------------------------------------------
AES Encryption Module: Implements the AES algorithm in SystemVerilog with a focus on 128-bit encryption, following the NIST standard.
UVM-Based Testbench: Leverages UVM to create a reusable, scalable, and robust verification environment.
Functional Coverage: Employs covergroups to ensure all critical functional scenarios of AES (e.g., different data and key combinations) are exercised.
Randomized Testing: Uses constrained random stimulus to stress-test the AES module across various edge cases.
Assertions: Built-in assertions ensure real-time checks for encryption correctness.
Scoreboard and Monitor: A scoreboard compares encrypted outputs against a reference model, while a monitor observes and logs transactions to ensure accuracy.
______________________________________________________________________________________________________________________________________________________________

**Components**
--------------------------------------------------------------------------------------------------------------------------------------------------------------
AES Encryption Module: A SystemVerilog implementation of the AES encryption algorithm.
UVM Testbench: Includes a sequencer, driver, monitor, subscriber, and scoreboard for comprehensive coverage and correctness checks.
Python Reference Model: A Python script using PyCryptodome to generate reference AES outputs for verification purposes.
Coverage Model: Covergroups capturing edge cases in AES operation, including key transitions and various data patterns.
Test Scenarios: Includes directed and randomized tests for functional and stress verification.
______________________________________________________________________________________________________________________________________________________________

**How It Works**
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Stimulus Generation: The UVM sequencer generates a sequence of transactions with random plaintext and keys, which are sent to the AES module for encryption.
Reference Model Comparison: The AES output is compared against the reference model (Python-based) to validate encryption correctness.
Coverage Reporting: After simulation, functional coverage is reported, ensuring all relevant AES scenarios are covered.
Debugging: The UVM environment logs detailed information for each transaction, helping identify mismatches or functional issues.
______________________________________________________________________________________________________________________________________________________________

**Tools & Technologies**
--------------------------------------------------------------------------------------------------------------------------------------------------------------
SystemVerilog: For AES encryption and the UVM-based testbench.
UVM (Universal Verification Methodology): For building a reusable and scalable verification environment.
PyCryptodome: For the Python-based AES reference model.
ModelSim/QuestaSim: For simulation and debugging.
______________________________________________________________________________________________________________________________________________________________
