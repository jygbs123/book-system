package com.itmk.web.sys_menu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.sys_menu.entity.MakeTree;
import com.itmk.web.sys_menu.entity.SysMenu;
import com.itmk.web.sys_menu.mapper.SysMenuMapper;
import com.itmk.web.sys_menu.service.SysMenuService;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements SysMenuService {

    @Override
    public List<SysMenu> menuList() {
        //查询列表
        QueryWrapper<SysMenu> query = new QueryWrapper<>();
        query.lambda().orderByAsc(SysMenu::getOrderNum);
        List<SysMenu> menuList = this.baseMapper.selectList(query);
        //组装树
        List<SysMenu> list = MakeTree.makeMenuTree(menuList, 0L);
        return list;
    }

    @Override
    public List<SysMenu> parentList() {
        //只需要查询目录和菜单
        String[] types = {"0","1"};
        //构造查询条件
        QueryWrapper<SysMenu> query = new QueryWrapper<>();
        query.lambda().in(SysMenu::getType, Arrays.asList(types)).orderByAsc(SysMenu::getOrderNum);
        List<SysMenu> sysMenus = this.baseMapper.selectList(query);
        //构造顶级菜单
        SysMenu menu = new SysMenu();
        menu.setMenuId(0L);
        menu.setParentId(-1L);
        menu.setTitle("顶级菜单");
        sysMenus.add(menu);
        //构造树
        List<SysMenu> sysMenus1 = MakeTree.makeMenuTree(sysMenus, -1L);

        return sysMenus1;
    }

    @Override
    public List<SysMenu> getMenuByUserId(Long userId) {
        return this.baseMapper.getMenuByUserId(userId);
    }

    @Override
    public List<SysMenu> getMenuByRoleId(Long roleId) {
        return this.baseMapper.getMenuByRoleId(roleId);
    }

    @Override
    public List<SysMenu> getReaderMenuByUserId(Long readerId) {
        return this.baseMapper.getReaderMenuByUserId(readerId);
    }
}
