package com.itmk.web.sys_menu.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.sys_menu.entity.SysMenu;

import java.util.List;

public interface SysMenuService extends IService<SysMenu> {
    //菜单列表
    List<SysMenu> menuList();
    //上级菜单列表
    List<SysMenu> parentList();
    //根据用户id查询权限
    List<SysMenu> getMenuByUserId(Long userId);
    //根据角色id查询权限
    List<SysMenu> getMenuByRoleId(Long roleId);
    //根据读者id查询权限
    List<SysMenu> getReaderMenuByUserId(Long readerId);
}
