// This module implements a parameterized serial odd-parity checker using a Mealy FSM.
module lab1_parity_checker #(
  parameter int DATA_WIDTH = 8
) (
  input  logic clk,
  input  logic reset, // Synchronous, active-high reset
  input  logic start,
  input  logic data_in,
  output logic checking,
  output logic parity_error
);

  // State definitions for our FSM.
  typedef enum logic [1:0] { IDLE, CHECKING, DONE } state_t;
  
  // State variables for the FSM.
  state_t current_state, next_state;
  
  // Internal registers for counting bits and tracking parity.
  // We need a counter that can go up to DATA_WIDTH-1.
  logic [$clog2(DATA_WIDTH)-1:0] bit_counter; 
  logic running_parity; // 0 for even, 1 for odd

  // --- Sequential Logic Block ---
  // This block models all the registered elements: state, counter, and parity bit.
  always_ff @(posedge clk) begin
    if (reset) begin
      current_state <= IDLE;
      bit_counter   <= '0;
      running_parity <= 1'b0; // Start with even parity
    end else begin
      current_state <= next_state;

      // Logic for the bit counter register
      if (next_state == CHECKING && current_state != CHECKING) begin
        bit_counter <= '0; // Reset counter when entering CHECKING state
      end else if (current_state == CHECKING) begin
        bit_counter <= bit_counter + 1;
      end

      // Logic for the running parity register
      if (next_state != CHECKING) begin
        running_parity <= 1'b0; // Reset parity when not checking
      end else if (data_in) begin // Only flip if the input bit is 1
        running_parity <= ~running_parity;
      end
    end
  end

  // --- Combinational Logic Block ---
  // This block calculates the next state and all outputs based on
  // the current state and current inputs.
  always_comb begin
    // Default assignments
    next_state = current_state;
    
    // FSM next-state logic
    case (current_state)
      IDLE: begin
        if (start) next_state = CHECKING;
      end
      CHECKING: begin
        if (bit_counter == DATA_WIDTH - 1) begin
          next_state = DONE;
        end
      end
      DONE: begin
        // Automatically go back to IDLE to be ready for the next transaction
        next_state = IDLE;
      end
      default: next_state = IDLE;
    endcase
    
    // --- Output Logic ---
    
    // 'checking' is a Moore-style output. It depends only on the current state.
    checking = (current_state == CHECKING);
    
    // 'parity_error' is a Mealy-style output. It depends on the current state
    // AND the current inputs to predict an error condition immediately.
    // An error exists if we are checking and the *next* parity would be 1 (odd).
    if (current_state == CHECKING) begin
      // Calculate what the parity would be after this cycle
      parity_error = running_parity ^ data_in;
    end else begin
      parity_error = 1'b0;
    end
  end
  
endmodule