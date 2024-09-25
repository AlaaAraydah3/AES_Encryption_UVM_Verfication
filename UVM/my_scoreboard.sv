class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)

  my_sequence_item seq_item;
  // Declare analysis imp to directly receive transactions
  uvm_analysis_imp#(my_sequence_item, my_scoreboard) my_analysis_imp;

  int    file;
  int    total_Data_valid;
  int    total_reset;
  reg   [127:0] expected_out;
  string line;
   
  bit[127:0] plain_text_read;   // Size depends on my plain_text width
  bit[127:0] cipher_key_read;   // Size depends on my cipher_key width

  
  function new(string name = "my_scoreboard", uvm_component parent);
  super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    // Create analysis imp to write method
    my_analysis_imp = new("my_analysis_imp", this);
    
    seq_item = my_sequence_item::type_id::create("seq_item");
  endfunction 
  
function void write(my_sequence_item seq_item);
    this.seq_item = seq_item;

    if (!seq_item.reset) begin
        total_reset++;
        $display("RESET");
    end else 
    if(seq_item.valid_in) begin
        total_Data_valid++;
        $display("Data_valid");

        file = $fopen("data_key.txt", "w");
        if (file == 0) begin
            $display("Error: cannot open data_key.txt for writing");
        end
     
        // Write plain text and cipher key inside file
        $fwrite(file, "%h\n", seq_item.plain_text);
        $fwrite(file, "%h\n", seq_item.cipher_key);
      //  $display("Plain text written to file: %h", seq_item.plain_text);
      //  $display("Cipher key written to file: %h", seq_item.cipher_key);
        // Close the file after writing
        $fclose(file);

        // Open file to read plain text and cipher key
        file = $fopen("data_key.txt", "r");
        if (file == 0) begin
            $display("Error: cannot open data_key.txt for reading");
        end
        // Read plain text and cipher key from the file 
        $fscanf(file, "%h\n", plain_text_read); 
        $fscanf(file, "%h\n", cipher_key_read);
        // we store data and key in cipher_key_read / plain_text_read

        // Display the read values
      //  $display("Plain text read from file: %h", plain_text_read);
      //  $display("Cipher key read from file: %h", cipher_key_read);

        // Close the file after reading
        $fclose(file);
     end
      // This line runs the Python script ref_module.py using Python 3 
      $system("python3 ref_module.py");

      file = $fopen("output.txt", "r");
      if (file == 0) begin
          $display("Error: Unable to open output.txt");
      end
      // $fgets() returns 0 if the end if there is an error.
      if (!$fgets(line, file)) begin
          $display("Error: Unable to read from output.txt");
          $fclose(file);
      end
      // Store the hexadecimal value into the 'expected_out' variable.
      $sscanf(line, "%h", expected_out);
      $fclose(file);

    // Compare expected and actual values (after reading the output)
    if ((expected_out == seq_item.cipher_text) && (seq_item.valid_out == 1'b1)) begin
        `uvm_info("[CHECK] ", $sformatf("[PASS] : \n Expected = %h  \n Actual   = %h", expected_out, seq_item.cipher_text), UVM_MEDIUM);
    end else begin                                
        `uvm_info("[CHECK] ", $sformatf("[ERROR]: \n Expected = %h  \n Actual   = %h", expected_out, seq_item.cipher_text), UVM_MEDIUM);
    end

endfunction

function void report_phase(uvm_phase phase);
super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("total  reset  = %0d", total_reset), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("total  Data_v = %0d", total_Data_valid), UVM_LOW)
endfunction
endclass
