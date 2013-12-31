------------------------------------------------------
--
-- Library Name : Project COEN 6501
-- Unit Name : Booth Multiplier
-- Author: Supriya Shalvi and Oana Neagu
------------------------------------------------------
------------------------------------------------------
-- Description : Test bench performs the
-- following:
-- > Give the values to the squarer for simulation
--
------------------------------------------------------
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;            
use ieee.std_logic_textio.all; 
 
entity  TESTBENCH  is
end TESTBENCH;
architecture BEHAVIORAL of TESTBENCH is
component booth_mult
 port (
       a : in STD_LOGIC_VECTOR (7 downto 0);
       clk, reset : in STD_LOGIC;
       load: in std_logic;
       load_cmd : out std_logic;
       flag : out std_logic;
       rout : out STD_LOGIC_VECTOR (15 downto 0));
      
end component;
signal A_in_TB : std_logic_vector(7 downto 0 );
signal clk_TB, reset_TB, load_TB, load_cmd_TB : std_logic :='0';
signal flag_TB : std_logic;
signal Rout_TB: std_logic_vector(15 downto 0);
begin
-- instantiate the Device Under Test
inst_DUT : booth_mult
  port map (
    a => A_in_TB,
    clk => clk_TB,
    reset => reset_TB,
    load_cmd => load_cmd_TB,
    rout => Rout_TB,
    flag => flag_TB,
    load => load_TB);
-- Generate clock stimulus
STIMULUS_CLK : process
begin
  clk_TB <= '1';
  wait for 50 ps;
  clk_TB <= '0';
  wait for 50 ps;
end process STIMULUS_CLK;
-- Generate reset stimulus
STIMULUS_RST : process
begin
  reset_TB <= '1';
  wait for 100 ps;
  reset_TB <= '0';
  wait;
end process STIMULUS_RST;
STIMULUS_LOAD : process
begin
  load_TB <= '0';
  wait for 100 ps;
  load_TB <= '1';
  wait;
end process STIMULUS_LOAD;
-- Generate multiplication requests
STIMULUS_START : process
file logFile : text is out "bus_log.txt";  -- set output file name
variable L: line;
variable A_temp, i : integer;
begin
  write(L, string'("A     Result"));  -- include heading in file
  writeline(logFile,L);
  A_temp := 0;    -- start A at 0

  i := 1;
  for i in 1 to 256 loop
    A_in_TB <= STD_LOGIC_VECTOR(to_unsigned(A_temp,8));
    
    
    
    wait until flag_TB = '1';  -- wait for the multiplier to finish
      hwrite(L, A_in_TB); 
    write(L, string'(" "));
    
    hwrite(L, Rout_TB);          -- insert hex value of result in file
    writeline(logFile,L);
    A_temp := A_temp + 1;      -- increment value of A (Multiplicand)
    
  end loop;
  
  wait;
end process STIMULUS_START;
end BEHAVIORAL;