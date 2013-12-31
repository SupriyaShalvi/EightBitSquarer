------------------------------------------------------
--
-- Library Name : Project COEN 6501
-- Unit Name : Booth Multiplier
-- Author: Supriya Shalvi and Oana Neagu
------------------------------------------------------
------------------------------------------------------
-- Description : Booth Multiplier performs the
-- following:
-- > Take a as a 8 bit input and gives 16 bit square output
-- > Instantiate the encoder, controller, registers and adder 
--   components for structural modelling.
--
------------------------------------------------------
------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.std_logic_arith.all;
use work.all;

entity booth_mult is
Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
       clk, reset : in STD_LOGIC;
       load : in std_logic;
       load_cmd : out std_logic;
       flag : out std_logic;
       rout : out STD_LOGIC_VECTOR (15 downto 0));
       --ovf: out std_logic);
end booth_mult;

architecture Behavioral of booth_mult is
  
COMPONENT registerA 
port (reset : in std_logic ;
      A_in : in std_logic_vector  (7 downto 0);
      clk : in std_logic ;
      --load: in std_logic;
      RA : out std_logic_vector  (7 downto 0));
end component;
COMPONENT registerZ
port (reset : in std_logic ;
      y : in std_logic_vector  (15 downto 0);
      clk : in std_logic ;
      RZ : out std_logic_vector  (15 downto 0));
end component;
COMPONENT booth_encoder
PORT(
     a : IN std_logic_vector(7 downto 0);
     arg : IN std_logic_vector(2 downto 0);
     pprod : OUT std_logic_vector(15 downto 0)
);
END COMPONENT;

COMPONENT sixteenbit_fa
PORT(
      a : IN std_logic_vector(15 downto 0);
      b : IN std_logic_vector(15 downto 0);
      yout : OUT std_logic_vector(15 downto 0);
      cout : OUT std_logic
);
END COMPONENT;
component Controller is
port (reset : in std_logic ;
 clk : in std_logic ;
 Load : in std_logic;
 LOAD_cmd : out std_logic ;
 flag_cmd : out std_logic);
end component;

signal ra : std_logic_vector(7 downto 0);
signal pp1,pp2,pp3,pp4,s1,s2,s3,sum1,sum2: std_logic_vector(15 downto 0);
signal st: std_logic_vector(2 downto 0);
signal k1,k2, ovf: std_logic;
signal yout : STD_LOGIC_VECTOR (15 downto 0);
begin
 INst_Controller : Controller
 port map (
          clk => clk,
          reset => reset,
          Load =>load,
          load_cmd =>load_cmd,
          flag_cmd => flag
        ); 
ra0: registerA PORT MAP(reset,a,clk,ra);
st<=a(1 downto 0)&'0';
u0: booth_encoder PORT MAP(a,st,pp1);
u1: booth_encoder PORT MAP(ra,ra(3 downto 1),pp2);
u2: booth_encoder PORT MAP(ra,ra(5 downto 3),pp3);
u3: booth_encoder PORT MAP(ra,ra(7 downto 5),pp4);
s1<=pp2(13 downto 0)&"00";
s2<=pp3(11 downto 0)&"0000";
s3<=pp4(9 downto 0)&"000000";
u4: sixteenbit_fa PORT MAP(pp1,s1,sum1,k1);
u5: sixteenbit_fa PORT MAP(sum1,s2,sum2,k2);
u6: sixteenbit_fa PORT MAP(sum2,s3,yout,ovf);
rz0 : registerZ PORT MAP(reset,yout,clk,rout);
end Behavioral;
