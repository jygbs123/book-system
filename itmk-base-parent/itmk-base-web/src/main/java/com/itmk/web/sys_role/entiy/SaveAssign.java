package com.itmk.web.sys_role.entiy;

import lombok.Data;

import java.util.List;

@Data
public class SaveAssign {
    private Long roleId;
    private List<Long> list;
}
