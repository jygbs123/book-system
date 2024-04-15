package com.itmk.web.sys_books.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.sys_books.entity.BookVo;
import com.itmk.web.sys_books.entity.ListParm;
import com.itmk.web.sys_books.entity.SysBooks;

import java.util.List;

public interface SysBooksService extends IService<SysBooks> {
    IPage<SysBooks> getList(ListParm parm);
    //减库存
    int subBook(Long bookId);
    //加库存
    int addBook(Long bookId);
     List<BookVo> getHotBook();
}
