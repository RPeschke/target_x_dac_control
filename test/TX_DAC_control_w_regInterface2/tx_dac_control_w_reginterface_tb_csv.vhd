


library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.type_conversions_pgk.all;
use work.CSV_UtilityPkg.all;



use work.tx_dac_control_w_reginterface_IO_pgk.all;


entity tx_dac_control_w_reginterface_reader_et  is
    generic (
        FileName : string 
    );
    port (
        clk : in std_logic ;
        data : out tx_dac_control_w_reginterface_reader_rec
    );
end entity;   

architecture Behavioral of tx_dac_control_w_reginterface_reader_et is 

  constant  NUM_COL    : integer := 4;
  signal    csv_r_data : c_integer_array(NUM_COL -1 downto 0)  := (others=>0)  ;
begin

  csv_r :entity  work.csv_read_file 
    generic map (
        FileName =>  FileName, 
        NUM_COL => NUM_COL,
        HeaderLines =>  2
    ) port map (
        clk => clk,
        Rows => csv_r_data
    );

  csv_from_integer(csv_r_data(0), data.clk);
  csv_from_integer(csv_r_data(1), data.rst);
  csv_from_integer(csv_r_data(2), data.reg.address);
  csv_from_integer(csv_r_data(3), data.reg.value);


end architecture;
---------------------------------------------------------------------------------------------------
    


library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.type_conversions_pgk.all;
use work.CSV_UtilityPkg.all;



use work.tx_dac_control_w_reginterface_IO_pgk.all;

entity tx_dac_control_w_reginterface_writer_et  is
    generic ( 
        FileName : string 
    ); port (
        clk : in std_logic ;
        data : in tx_dac_control_w_reginterface_writer_rec
    );
end entity;

architecture Behavioral of tx_dac_control_w_reginterface_writer_et is 
  constant  NUM_COL : integer := 9;
  signal data_int   : c_integer_array(NUM_COL - 1 downto 0)  := (others=>0);
begin

    csv_w : entity  work.csv_write_file 
        generic map (
            FileName => FileName,
            HeaderLines=> "clk, rst, reg_address, reg_value, tx_dac_control_out_sclk, tx_dac_control_out_reg_clr, tx_dac_control_out_sin, tx_dac_control_out_pclk",
            NUM_COL =>   NUM_COL 
        ) port map(
            clk => clk, 
            Rows => data_int
        );


  csv_to_integer(data.clk, data_int(0) );
  csv_to_integer(data.rst, data_int(1) );
  csv_to_integer(data.reg.address, data_int(2) );
  csv_to_integer(data.reg.value, data_int(3) );
  csv_to_integer(data.tx_dac_control_out.sclk, data_int(4) );
  csv_to_integer(data.tx_dac_control_out.reg_clr, data_int(5) );
  csv_to_integer(data.tx_dac_control_out.sin, data_int(6) );
  csv_to_integer(data.tx_dac_control_out.pclk, data_int(7) );


end Behavioral;
---------------------------------------------------------------------------------------------------
    

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.type_conversions_pgk.all;
use work.CSV_UtilityPkg.all;


use work.tx_dac_control_w_reginterface_IO_pgk.all;

entity tx_dac_control_w_reginterface_tb_csv is 
end entity;

architecture behavior of tx_dac_control_w_reginterface_tb_csv is 
  signal clk : std_logic := '0';
  signal data_in : tx_dac_control_w_reginterface_reader_rec;
  signal data_out : tx_dac_control_w_reginterface_writer_rec;

begin 

  clk_gen : entity work.ClockGenerator generic map ( CLOCK_period => 10 ns) port map ( clk => clk );

  csv_read : entity work.tx_dac_control_w_reginterface_reader_et 
    generic map (
        FileName => "./tx_dac_control_w_reginterface_tb_csv.csv" 
    ) port map (
        clk => clk ,data => data_in
    );
 
  csv_write : entity work.tx_dac_control_w_reginterface_writer_et
    generic map (
        FileName => "./tx_dac_control_w_reginterface_tb_csv_out.csv" 
    ) port map (
        clk => clk ,data => data_out
    );
  

  data_out.clk <=clk;
  data_out.rst <= data_in.rst;
  data_out.reg <= data_in.reg;


DUT :  entity work.tx_dac_control_w_reginterface   generic map(
asicnumber => asicnumber  ) port map(

  clk => clk,
    rst => data_out.rst,
  reg => data_out.reg,
  tx_dac_control_out => data_out.tx_dac_control_out
    );

end behavior;
---------------------------------------------------------------------------------------------------
    