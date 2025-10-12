a bit parity checker moudle - for a DATA_WIDTH size bit vector input included a MEALU and MOORE FSM .

MOUDLE -  lab1_parity_checker:

always_ff block - 
bit_counter and parity bit logic with consideration of the current state.
reset means - back to IDLE state and reset the parity_bit and counter.
If we went from IDLE==>CHECKING state - bit counter goest to zero.
IF we currently in CHECKING state - add 1 to counter and: if data in is '1' toggel parity bit.

always comb block:
FSM logic:
if start bit the '1' - next state = checking
if bit counter is at the and of the sequence next state = done
when current state is DONE - next state = IDLE

Test bench:
