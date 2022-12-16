

library IEEE;
library UNISIM;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;



package TX_DAC_control_pack is 



type TX_DAC_control is record 
  SCLK : std_logic; 
  REG_CLR : std_logic; 
  SIN : std_logic; 
  PCLK : std_logic; 
end record;


constant TX_DAC_control_null : TX_DAC_control:= (
  SCLK => '0',
  REG_CLR => '0',
  SIN => '0',
  PCLK => '0'
);


type TX_DAC_control_a is array (natural range <>) of TX_DAC_control;



end package;


