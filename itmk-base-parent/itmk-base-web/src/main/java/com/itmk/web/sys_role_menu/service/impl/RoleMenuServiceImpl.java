package com.itmk.web.sys_role_menu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.sys_role_menu.entity.RoleMenu;
import com.itmk.web.sys_role_menu.mapper.RoleMenuMapper;
import com.itmk.web.sys_role_menu.service.RoleMenuService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
public class RoleMenuServiceImpl extends ServiceImpl<RoleMenuMapper, RoleMenu> implements RoleMenuService {
    @Override
    @Transactional
    public void assignSave(Long roleId, List<Long> menuList) {
        //1、删除角色原来的菜单
        QueryWrapper<RoleMenu> query = new QueryWrapper<>();
        query.lambda().eq(RoleMenu::getRoleId,roleId);
        this.baseMapper.delete(query);
        //2、插入新的菜单
        this.baseMapper.assignSave(roleId,menuList);
    }
}
