package com.itmk.web.sys_books.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.sys_books.entity.BookVo;
import com.itmk.web.sys_books.entity.ListParm;
import com.itmk.web.sys_books.entity.SysBooks;
import com.itmk.web.sys_books.mapper.SysBooksMapper;
import com.itmk.web.sys_books.service.SysBooksService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysBooksServiceImpl extends ServiceImpl<SysBooksMapper, SysBooks> implements SysBooksService {
    @Override
    public IPage<SysBooks> getList(ListParm parm) {
        //构造分页对象
        Page<SysBooks> page = new Page<>();
        page.setCurrent(parm.getCurrentPage());
        page.setSize(parm.getPageSize());
        return this.baseMapper.getList(page,parm);
    }

    @Override
    public int subBook(Long bookId) {
        return this.baseMapper.subBook(bookId);
    }

    @Override
    public int addBook(Long bookId) {
        return this.baseMapper.addBook(bookId);
    }

    @Override
    public List<BookVo> getHotBook() {
        return this.baseMapper.getHotBook();
    }
}
