package com.itmk.web.sys_user.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.itmk.annotation.Auth;
import com.itmk.jwt.JwtUtils;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.sys_reader.entity.SysReader;
import com.itmk.web.sys_reader.service.SysReaderService;
import com.itmk.web.sys_role.entiy.SysRole;
import com.itmk.web.sys_role.service.SysRoleService;
import com.itmk.web.sys_user.entity.PageParm;
import com.itmk.web.sys_user.entity.SysUser;
import com.itmk.web.sys_user.entity.UpdatePasswordParm;
import com.itmk.web.sys_user.service.SysUserService;
import com.itmk.web.sys_user_role.entity.UserRole;
import com.itmk.web.sys_user_role.service.UserRoleService;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/api/user")
public class SysUserController {
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private UserRoleService userRoleService;
    @Autowired
    private JwtUtils jwtUtils;
    @Autowired
    private SysReaderService sysReaderService;

    //新增用户
    @Auth
    @PostMapping
    public ResultVo addUser(@RequestBody SysUser user){
        //判断账户是否被占用
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.lambda().eq(SysUser::getUsername,user.getUsername());
        SysUser one = sysUserService.getOne(query);
        if(one != null){
            return ResultUtils.error("账户被占用!");
        }
        //密码加密
        user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
        //设置是否是管理员
        user.setIsAdmin("0");
        user.setCreateTime(new Date());
        //入库
        sysUserService.addUser(user);
        return ResultUtils.success("新增用户成功!");
    }

    //编辑用户
    @Auth
    @PutMapping
    public ResultVo editUser(@RequestBody SysUser user){
        //判断账户是否被占用
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.lambda().eq(SysUser::getUsername,user.getUsername());
        SysUser one = sysUserService.getOne(query);
        if(one != null && one.getUserId() != user.getUserId()){
            return ResultUtils.error("账户被占用!");
        }
        //密码加密
        user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
        user.setUpdateTime(new Date());
        //更新
        sysUserService.editUser(user);
        return ResultUtils.success("编辑用户成功!");
    }

    //删除
    @Auth
    @DeleteMapping("/{userId}")
    public ResultVo delete(@PathVariable("userId") Long userId){
        boolean remove = sysUserService.removeById(userId);
        if(remove){
            return ResultUtils.success("删除用户成功!");
        }
        return ResultUtils.error("删除用户失败!");
    }

    //列表查询
    @Auth
    @GetMapping("/list")
    public ResultVo getList(PageParm parm){
        IPage<SysUser> list = sysUserService.list(parm);
        //密码处理
        list.getRecords().stream().forEach(item ->{
            item.setPassword("");
        });
        return ResultUtils.success("查询成功",list);
    }

    //查询角色列表
    @Auth
    @GetMapping("/getRoleList")
    public ResultVo getRoleList(){
        List<SysRole> list = sysRoleService.list();
        return ResultUtils.success("查询成功",list);
    }

    //根据用户id查询角色
    @Auth
    @GetMapping("/getRoleId")
    public ResultVo getRoleId(Long userId){
        QueryWrapper<UserRole> query = new QueryWrapper<>();
        query.lambda().eq(UserRole::getUserId, userId);
        UserRole one = userRoleService.getOne(query);
        return ResultUtils.success("查询成功",one);
    }

    @Auth
    @PostMapping("/updatePassword")
    public ResultVo updatePassword(@RequestBody UpdatePasswordParm parm, HttpServletRequest request){
        //获取token
        String token = request.getHeader("token");
        Claims claims = jwtUtils.getClaimsFromToken(token);
        Object userType = claims.get("userType");
        //原密码
        String old = DigestUtils.md5DigestAsHex(parm.getOldPassword().getBytes());
        if(userType.equals("0")){ //0 ：读者
            SysReader reader = sysReaderService.getById(parm.getUserId());
            //密码对比
            if(!old.equals(reader.getPassword())){
                return ResultUtils.error("原密码错误!");
            }
            SysReader sysReader = new SysReader();
            sysReader.setPassword(DigestUtils.md5DigestAsHex(parm.getPassword().getBytes()));
            sysReader.setReaderId(parm.getUserId());
            boolean b = sysReaderService.updateById(sysReader);
            if(b){
                return ResultUtils.success("密码修改成功!");
            }
        }else{ // 管理员
            SysUser user = sysUserService.getById(parm.getUserId());
            if(!user.getPassword().equals(old)){
                 return ResultUtils.error("原密码错误!");
            }
            SysUser sysReader = new SysUser();
            sysReader.setPassword(DigestUtils.md5DigestAsHex(parm.getPassword().getBytes()));
            sysReader.setUserId(parm.getUserId());
            boolean b = sysUserService.updateById(sysReader);
            if(b){
                return ResultUtils.success("密码修改成功!");
            }
        }
        return ResultUtils.error("密码修改失败!");
    }

     //重置密码
    @PostMapping("/resetPassword")
    public ResultVo resetPassword(@RequestBody SysUser sysUser){
        String pasword = "666666";
        sysUser.setPassword(DigestUtils.md5DigestAsHex(pasword.getBytes()));
        boolean b = sysUserService.updateById(sysUser);
        if(b){
            return ResultUtils.success("重置密码成功!");
        }
        return ResultUtils.error("重置密码失败!");
    }
}
