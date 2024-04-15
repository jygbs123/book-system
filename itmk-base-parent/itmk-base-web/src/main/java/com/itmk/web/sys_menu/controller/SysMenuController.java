package com.itmk.web.sys_menu.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.itmk.annotation.Auth;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.sys_menu.entity.SysMenu;
import com.itmk.web.sys_menu.service.SysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/api/menu")
public class SysMenuController {
    @Autowired
    private SysMenuService sysMenuService;

    //新增
    @Auth
    @PostMapping
    public ResultVo addMenu(@RequestBody SysMenu menu){
        menu.setCreateTime(new Date());
        boolean save = sysMenuService.save(menu);
        if(save){
            return ResultUtils.success("新增成功!");
        }
        return ResultUtils.error("新增失败!");
    }

    //编辑
    @Auth
    @PutMapping
    public ResultVo editMenu(@RequestBody SysMenu menu){
        menu.setUpdateTime(new Date());
        boolean save = sysMenuService.updateById(menu);
        if(save){
            return ResultUtils.success("编辑成功!");
        }
        return ResultUtils.error("编辑失败!");
    }

    //删除
    @Auth
    @DeleteMapping("/{menuId}")
    public ResultVo deleteMenu(@PathVariable("menuId") Long menuId){
        //判断是否有下级，有下级，不能删除
        QueryWrapper<SysMenu> query = new QueryWrapper<>();
        query.lambda().eq(SysMenu::getParentId,menuId);
        List<SysMenu> list = sysMenuService.list(query);
        if(list.size() > 0){
            return ResultUtils.error("该菜单存在下级，不能删除!");
        }
        boolean save = sysMenuService.removeById(menuId);
        if(save){
            return ResultUtils.success("删除成功!");
        }
        return ResultUtils.error("删除失败!");
    }

    //菜单列表
    @Auth
    @GetMapping("/list")
    public ResultVo getList(){
        List<SysMenu> list = sysMenuService.menuList();
        return ResultUtils.success("查询成功",list);
    }

    //上级菜单列表
    @Auth
    @GetMapping("/parent")
    public ResultVo getParentList(){
        List<SysMenu> list = sysMenuService.parentList();
        return ResultUtils.success("查询成功",list);
    }
}
