package com.itmk.web.sys_user_role.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("sys_user_role")
public class UserRole {
    @TableId(type = IdType.AUTO)
    private Long userRoleId;
    private Long userId;
    private Long roleId;
}
