library ieee;
use ieee.std_logic_1164.all;
entity top is
    port(
        code : in std_logic_vector(2 downto 0); -- entrada 1 bit enable + 2 bits para decodificador 2x4
        code_decoder : out std_logic_vector(3 downto 0); -- saida decodificador 2x4
        pcode : in std_logic_vector(3 downto 0); -- entrada 4 bits para codificador de prioridade 4x3
        pcode_encoder : out std_logic_vector(2 downto 0) -- saida codificador de prioridade 4x3 
    );
end top;

architecture top_arch of top is
begin
    decoder_unit: entity work.decoder_2_4(cond_arch)
        port map(
            a => code(1 downto 0);
            en => code(2);
            y => code_decoder
        );
    prio_encoder_unit: entity work.prio_encoder(if_arch)
        port map(
            r => pcode;
            pcode => pcode_encoder
        );

end top_arch;
    