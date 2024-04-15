package com.itmk.web.sys_reader.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 用学号登录
 */
@Data
@TableName("sys_reader")
public class SysReader {
    @TableId(type = IdType.AUTO)
    private Long readerId;
    private String learnNum; // 姓名
    private String username;  // 学号
    private String idCard;
    private String sex;
    private String phone;
    private String password;
    private String type;
    private String checkStatus;
    private String userStatus;
    private String className;
}
