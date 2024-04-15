package com.itmk.web.sys_user.entity;

import lombok.Data;

@Data
public class UpdatePasswordParm {
    private Long userId;
    private String oldPassword;
    private String password;
}