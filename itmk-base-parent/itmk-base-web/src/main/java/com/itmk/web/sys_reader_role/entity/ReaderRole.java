package com.itmk.web.sys_reader_role.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("sys_reader_role")
public class ReaderRole {
    @TableId(type = IdType.AUTO)
    private Long readerRoleId;
    private Long readerId;
    private Long roleId;
}
