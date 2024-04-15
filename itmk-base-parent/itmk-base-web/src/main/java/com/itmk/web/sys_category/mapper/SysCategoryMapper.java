package com.itmk.web.sys_category.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.itmk.web.sys_category.entity.CategoryVo;
import com.itmk.web.sys_category.entity.SysCategory;

import java.util.List;

public interface SysCategoryMapper extends BaseMapper<SysCategory> {
    List<CategoryVo> getCategoryVo();
}
