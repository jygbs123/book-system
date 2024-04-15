package com.itmk.web.sys_category.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.sys_category.entity.CategoryEcharts;
import com.itmk.web.sys_category.entity.ListCateParm;
import com.itmk.web.sys_category.entity.SysCategory;


public interface SysCategoryService extends IService<SysCategory> {
    IPage<SysCategory> getList(ListCateParm parm);
    CategoryEcharts getCategoryVo();
}
