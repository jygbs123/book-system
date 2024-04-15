package com.itmk.web.sys_role.entiy;

import lombok.Data;

@Data
public class RoleParm {
    private Long currentPage;
    private Long pageSize;
    private String roleName;
}
