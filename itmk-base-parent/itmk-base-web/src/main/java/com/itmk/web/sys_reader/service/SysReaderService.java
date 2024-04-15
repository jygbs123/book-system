package com.itmk.web.sys_reader.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.sys_reader.entity.ReaderParm;
import com.itmk.web.sys_reader.entity.SysReader;

public interface SysReaderService extends IService<SysReader> {
    IPage<SysReader> getList(ReaderParm parm);
    //新增读者
    void saveReader(SysReader sysReader);
    //编辑读者
    void editReader(SysReader sysReader);

    SysReader loadByUsername(String username);
}
