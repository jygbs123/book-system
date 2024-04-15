package com.itmk.web.sys_menu.entity;

import org.springframework.beans.BeanUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class MakeTree {

    public static List<SysMenu> makeMenuTree(List<SysMenu> menuList, Long pid) {
        List<SysMenu> list = new ArrayList<>();
        Optional.ofNullable(menuList).orElse(new ArrayList<>())
                .stream()
                .filter(item -> item != null && item.getParentId() == pid)
                .forEach(dom -> {
                    SysMenu menu = new SysMenu();
                    BeanUtils.copyProperties(dom, menu);
                    //查询该项的下级菜单
                    List<SysMenu> sysMenus = makeMenuTree(menuList, dom.getMenuId());
                    menu.setChildren(sysMenus);
                    list.add(menu);
                });
        return list;
    }

     /**
     * 生成路由数据格式
     */
    public static List<RouterVO> makeRouter(List<SysMenu> menuList, Long pid){
        //接受生产的路由数据
        List<RouterVO> list = new ArrayList<>();
        //组装数据
        Optional.ofNullable(menuList).orElse(new ArrayList<>())
                .stream()
                .filter(item ->item != null && item.getParentId() == pid)
                .forEach(item ->{
                    RouterVO router = new RouterVO();
                    router.setName(item.getName());
                    router.setPath(item.getPath());
                    //判断是否是一级菜单
                    if(item.getParentId() == 0L){
                        router.setComponent("Layout");
                        router.setAlwaysShow(true);
                    }else{
                        router.setComponent(item.getUrl());
                        router.setAlwaysShow(false);
                    }
                    //设置meta
                    router.setMeta(router.new Meta(
                            item.getTitle(),
                            item.getIcon(),
                            item.getCode().split(",")
                    ));
                    //设置children
                    List<RouterVO> children = makeRouter(menuList, item.getMenuId());
                    router.setChildren(children);
                    if(router.getChildren().size() > 0){
                        router.setAlwaysShow(true);
                    }
                    list.add(router);
                });
        return list;
    }
}
