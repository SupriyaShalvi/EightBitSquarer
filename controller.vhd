------------------------------------------------------
--
-- Library Name : Project COEN 6501
-- Unit Name : Booth Multiplier
-- Author: Supriya Shalvi and Oana Neagu
--
------------------------------------------------------
------------------------------------------------------
------------------------------------------------------
-- Description : Controller is a finite state machine
-- that performs the following in each
-- state:
-- IDLE > samples the load signal
-- LOADING_A > commands the input register to load when load command goes high
-- MUL > do the square of the input
-- LOADING_Z > load the result in output register
--
------------------------------------------------------
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity Controller is
port (reset : in std_logic ;
 clk : in std_logic ;
 Load : in std_logic;
 LOAD_cmd : out std_logic ;
 flag_cmd : out std_logic);
end;
------------------------------------------------------
architecture rtl of Controller is
signal temp_count2 : std_logic_vector(2 downto 0);
-- declare states
type state_typ is (IDLE, LOADING_A, MUL, LOADING_Z );
signal state : state_typ;
begin
process (clk, reset)
 begin
 if reset='1' then
 state <= IDLE;
 elsif (clk'event and clk='1') then
 case state is
 when IDLE =>
 if load = '1' then
 state <= LOADING_A;
 else
 state <= IDLE;
 end if;
 when LOADING_A =>
 state <= MUL;
 when MUL =>
 state <= LOADING_Z;
 when LOADING_Z =>
 state <= IDLE; -- ready for next input
 end case;
 end if;
 end process;
 flag_cmd <= '1' when state = LOADING_Z else '0';
 LOAD_cmd <= '1' when state = IDLE else '0';
end rtl;
