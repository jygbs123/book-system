package com.itmk.web.sys_role.entiy;

import com.itmk.web.sys_menu.entity.SysMenu;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class AssignVo {
    //当前用户拥有的菜单
    private List<SysMenu> menuList = new ArrayList<>();
    //被分配的角色拥有的菜单id
    private Object[] checkList;
}
