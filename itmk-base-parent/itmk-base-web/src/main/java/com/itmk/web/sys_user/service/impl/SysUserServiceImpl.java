package com.itmk.web.sys_user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.sys_user.entity.PageParm;
import com.itmk.web.sys_user.entity.SysUser;
import com.itmk.web.sys_user.mapper.SysUserMapper;
import com.itmk.web.sys_user.service.SysUserService;
import com.itmk.web.sys_user_role.entity.UserRole;
import com.itmk.web.sys_user_role.service.UserRoleService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements SysUserService {    //继承ServiceImpl使用Mybatis Plus提供的方法，实现SYsUserService可以定义自己的方法
    @Autowired
    private UserRoleService userRoleService;

    @Override
    public IPage<SysUser> list(PageParm parm) {
        //构造分页对象
        Page<SysUser> page = new Page<>();
        page.setSize(parm.getPageSize());
        page.setCurrent(parm.getCurrentPage());
        //构造查询条件
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        if(StringUtils.isNotEmpty(parm.getNickName())){
             query.lambda().like(SysUser::getNickName,parm.getNickName());
        }
        if(StringUtils.isNotEmpty(parm.getPhone())){
             query.lambda().like(SysUser::getPhone,parm.getPhone());
        }
        return this.baseMapper.selectPage(page,query);

    }

    @Override
    @Transactional
    public void addUser(SysUser user) {
        //插入用户
        int insert = this.baseMapper.insert(user);
        if(insert >0){
            //插入用户对应的角色
            UserRole userRole = new UserRole();
            userRole.setRoleId(user.getRoleId());
            userRole.setUserId(user.getUserId());
            userRoleService.save(userRole);
        }
    }

    @Override
    public void editUser(SysUser user) {
        int i = this.baseMapper.updateById(user);
        //先删除原来的角色，再重新插入
        if(i > 0){
            QueryWrapper<UserRole> query = new QueryWrapper<>();
            query.lambda().eq(UserRole::getUserId,user.getUserId());
            //删除
            userRoleService.remove(query);
            //插入用户对应的角色
            UserRole userRole = new UserRole();
            userRole.setRoleId(user.getRoleId());
            userRole.setUserId(user.getUserId());
            userRoleService.save(userRole);
        }
    }

    @Override
    public SysUser loadByUsername(String username) {
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.lambda().eq(SysUser::getUsername,username);
        return this.baseMapper.selectOne(query);

    }
}
