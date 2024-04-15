package com.itmk.web.sys_menu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.itmk.web.sys_menu.entity.SysMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysMenuMapper extends BaseMapper<SysMenu> {
    //根据用户id查询权限
    List<SysMenu> getMenuByUserId(@Param("userId") Long userId);
    //根据读者id查询权限
    List<SysMenu> getReaderMenuByUserId(@Param("readerId") Long readerId);
    //根据角色id查询权限
    List<SysMenu> getMenuByRoleId(@Param("roleId") Long roleId);
}
