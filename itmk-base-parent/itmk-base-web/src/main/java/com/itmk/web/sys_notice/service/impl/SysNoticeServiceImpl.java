package com.itmk.web.sys_notice.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.sys_notice.entity.NoticeParm;
import com.itmk.web.sys_notice.entity.SysNotice;
import com.itmk.web.sys_notice.mapper.SysNoticeMapper;
import com.itmk.web.sys_notice.service.SysNoticeService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

@Service
public class SysNoticeServiceImpl extends ServiceImpl<SysNoticeMapper, SysNotice> implements SysNoticeService {
    @Override
    public IPage<SysNotice> getList(NoticeParm parm) {
        //构造分页对象
        Page<SysNotice> page = new Page<>();
        page.setSize(parm.getPageSize());
        page.setCurrent(parm.getCurrentPage());
        //构造查询条件
        QueryWrapper<SysNotice> query = new QueryWrapper<>();
        if(StringUtils.isNotEmpty(parm.getNoticeTitle())){
            query.lambda().like(SysNotice::getNoticeTitle,parm.getNoticeTitle());
        }
        query.lambda().orderByDesc(SysNotice::getCreateTime);
        return this.baseMapper.selectPage(page,query);
    }
}
