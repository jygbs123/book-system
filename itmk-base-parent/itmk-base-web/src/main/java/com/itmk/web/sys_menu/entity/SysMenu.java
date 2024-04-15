package com.itmk.web.sys_menu.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@TableName("sys_menu")
public class SysMenu {
    @TableId(type = IdType.AUTO)
    private Long menuId;
    private Long parentId;
    private String title;
    private String code;
    private String name;
    private String path;
    private String url;
    //类型(0 目录 1菜单，2按钮)
    private String type;
    private String icon;
    private String parentName;
    private Long orderNum;
    private Date createTime;
    private Date updateTime;
    //该字段不属于数据库表，需要排除
    @TableField(exist = false)
    private List<SysMenu> children = new ArrayList<>();
    //不属于数据库表中的字段，需要排除
    @TableField(exist = false)
     private Boolean open;
}
