package com.itmk.web.sys_category.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class CategoryEcharts {
    private List<String> names =  new ArrayList<>();
    private List<Integer> counts = new ArrayList<>();
}