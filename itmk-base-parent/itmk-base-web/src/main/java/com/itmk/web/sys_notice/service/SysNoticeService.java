package com.itmk.web.sys_notice.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.sys_notice.entity.NoticeParm;
import com.itmk.web.sys_notice.entity.SysNotice;

public interface SysNoticeService extends IService<SysNotice> {
    IPage<SysNotice> getList(NoticeParm parm);
}
