% 8.5 Meter Level
    try
        spd_8_5m_rel=ncread(currFile,'spd_8_5m_rel');
    catch
        errmsg('red','Spd_8_5m_rel does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_8_5m_rel = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end
    
    try
        spd_8_5m_lconv=ncread(currFile,'spd_8_5m_lconv');
    catch
        errmsg('red','Spd_8_5m_lconv does not exist in the following file: \n');
        errmsg('blue', '      %s\n',currFile)
        spd_8_5m_lconv = 0.* ones(len_Table,1);
        errmsg('Magenta','The data has been saved as 0!\n')
        fprintf('\n')
        flag_counter = flag_counter + 1;
    end