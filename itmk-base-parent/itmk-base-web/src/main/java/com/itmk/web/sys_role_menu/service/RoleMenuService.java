package com.itmk.web.sys_role_menu.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.sys_role_menu.entity.RoleMenu;

import java.util.List;

public interface RoleMenuService extends IService<RoleMenu> {
    //保存角色的权限
    void assignSave(Long roleId,List<Long> menuList);
}
