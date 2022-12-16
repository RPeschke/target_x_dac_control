

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use work.CSV_UtilityPkg.all;


-- Start Include user packages --
use work.roling_register_p.all;
use work.xgen_axistream_32.all;
use work.TX_DAC_control_pack.all;

-- End Include user packages --

package tx_dac_control_w_reginterface_IO_pgk is

  constant asicnumber : integer := 0;

type tx_dac_control_w_reginterface_writer_rec is record
    clk : std_logic;  
    rst : std_logic;  
    reg : registert;  
    tx_dac_control_out : tx_dac_control;  

end record;



type tx_dac_control_w_reginterface_reader_rec is record
    clk : std_logic;  
    rst : std_logic;  
    reg : registert;  

end record;


end tx_dac_control_w_reginterface_IO_pgk;

package body tx_dac_control_w_reginterface_IO_pgk is

end package body tx_dac_control_w_reginterface_IO_pgk;

        