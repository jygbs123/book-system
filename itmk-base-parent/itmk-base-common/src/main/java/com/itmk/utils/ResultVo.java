package com.itmk.utils;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data //字段生成get和set方法
@AllArgsConstructor
public class ResultVo<T> {
    private String msg;
    private int code;
    private T data;
}