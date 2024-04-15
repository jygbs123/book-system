package com.itmk.web.sys_role.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.sys_role.entiy.AssignParm;
import com.itmk.web.sys_role.entiy.AssignVo;
import com.itmk.web.sys_role.entiy.RoleParm;
import com.itmk.web.sys_role.entiy.SysRole;

public interface SysRoleService extends IService<SysRole> {
    IPage<SysRole> list(RoleParm parm);
    //角色权限的回显
    AssignVo getAssignShow(AssignParm parm);
}
