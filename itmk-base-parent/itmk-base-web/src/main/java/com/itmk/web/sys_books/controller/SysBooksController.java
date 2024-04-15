package com.itmk.web.sys_books.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.itmk.annotation.Auth;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.sys_books.entity.BookVo;
import com.itmk.web.sys_books.entity.ListParm;
import com.itmk.web.sys_books.entity.SysBooks;
import com.itmk.web.sys_books.service.SysBooksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/books")
public class SysBooksController {
    @Autowired
    private SysBooksService sysBooksService;

    //新增
    @Auth
    @PostMapping
    public ResultVo add(@RequestBody SysBooks books){
        boolean save = sysBooksService.save(books);
        if(save){
            return ResultUtils.success("新增成功");
        }
        return ResultUtils.error("新增失败");
    }

    //编辑
    @Auth
    @PutMapping
    public ResultVo edit(@RequestBody SysBooks books){
        boolean save = sysBooksService.updateById(books);
        if(save){
            return ResultUtils.success("编辑成功");
        }
        return ResultUtils.error("编辑失败");
    }

    //删除
    @Auth
    @DeleteMapping("/{bookId}")
    public ResultVo delete(@PathVariable("bookId") Long bookId){
        boolean remove = sysBooksService.removeById(bookId);
         if(remove){
            return ResultUtils.success("删除成功");
        }
        return ResultUtils.error("删除失败");
    }

    //列表
    @Auth
    @GetMapping("/list")
    public ResultVo getList(ListParm parm){
        IPage<SysBooks> list = sysBooksService.getList(parm);
        return ResultUtils.success("查询成功",list);
    }

     //列表
    @Auth
    @GetMapping("/getHotBook")
    public ResultVo getHotBook(){
        List<BookVo> hotBook = sysBooksService.getHotBook();
        return ResultUtils.success("查询成功",hotBook);
    }
}
