package com.itmk.web.sys_role.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.itmk.annotation.Auth;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.sys_role.entiy.*;
import com.itmk.web.sys_role.service.SysRoleService;
import com.itmk.web.sys_role_menu.service.RoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
@RequestMapping("/api/role")
public class SysRoleController {
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private RoleMenuService roleMenuService;

    //新增
    @Auth
    @PostMapping
    public ResultVo addRole(@RequestBody SysRole role) {
        if (role.getRoleType().equals("2")) {
            QueryWrapper<SysRole> query = new QueryWrapper<>();
            query.lambda().eq(SysRole::getRoleType, "2");
            SysRole one = sysRoleService.getOne(query);
            if (one != null) {
                return ResultUtils.error("读者角色已经存在!");
            }
        }
        role.setCreateTime(new Date());
        boolean save = sysRoleService.save(role);
        if (save) {
            return ResultUtils.success("新增角色成功!");
        }
        return ResultUtils.error("新增角色失败!");
    }

    //编辑
    @Auth
    @PutMapping
    public ResultVo editRole(@RequestBody SysRole role) {
        if (role.getRoleType().equals("2")) {
            QueryWrapper<SysRole> query = new QueryWrapper<>();
            query.lambda().eq(SysRole::getRoleType, "2");
            SysRole one = sysRoleService.getOne(query);
            if (one != null && role.getRoleId() != one.getRoleId()) {
                return ResultUtils.error("读者角色已经存在!");
            }
        }
        role.setCreateTime(new Date());
        boolean save = sysRoleService.updateById(role);
        if (save) {
            return ResultUtils.success("编辑角色成功!");
        }
        return ResultUtils.error("编辑角色失败!");
    }

    //删除
    @Auth
    @DeleteMapping("/{roleId}")
    public ResultVo deleteRole(@PathVariable("roleId") Long roleId) {
        boolean remove = sysRoleService.removeById(roleId);
        if (remove) {
            return ResultUtils.success("删除角色成功!");
        }
        return ResultUtils.error("删除角色失败!");
    }

    //列表
    @Auth
    @GetMapping("/list")
    public ResultVo getList(RoleParm parm) {
        IPage<SysRole> list = sysRoleService.list(parm);
        return ResultUtils.success("查询成功!", list);
    }

    //查询角色权限树的回显
    @Auth
    @GetMapping("/getAssingShow")
    public ResultVo getAssingShow(AssignParm parm) {
        AssignVo show = sysRoleService.getAssignShow(parm);
        return ResultUtils.success("查询成功", show);
    }

    //角色分配权限保存
    @Auth
    @PostMapping("/assignSave")
    public ResultVo assignSave(@RequestBody SaveAssign parm) {
        roleMenuService.assignSave(parm.getRoleId(), parm.getList());
        return ResultUtils.success("分配成功!");
    }
}
