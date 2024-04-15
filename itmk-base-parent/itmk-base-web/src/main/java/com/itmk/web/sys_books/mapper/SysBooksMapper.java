package com.itmk.web.sys_books.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itmk.web.sys_books.entity.BookVo;
import com.itmk.web.sys_books.entity.ListParm;
import com.itmk.web.sys_books.entity.SysBooks;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysBooksMapper extends BaseMapper<SysBooks> {
    IPage<SysBooks> getList(Page<SysBooks> page,@Param("parm") ListParm parm);
    int subBook(@Param("bookId") Long bookId);
    int addBook(@Param("bookId") Long bookId);
    List<BookVo> getHotBook();
}
