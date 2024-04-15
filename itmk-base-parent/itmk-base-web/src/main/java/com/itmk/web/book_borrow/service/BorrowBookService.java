package com.itmk.web.book_borrow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.book_borrow.entity.*;
import org.apache.ibatis.annotations.Param;


import java.util.List;


public interface BorrowBookService extends IService<BorrowBook> {
    //借书
    void borrow(BorrowParm parm,String userType);
    //还书列表
    IPage<ReturnBook> getBorrowList(ListParm parm);
    //还书
    void returnBook(List<ReturnParm> list);
    //异常还书
    void exceptionBook(ExceptionParm parm);
    //借阅查看列表
    IPage<LookBorrow> getLookBorrowList(LookParm parm);
     //读者借阅查看列表
    IPage<LookBorrow> getReaderLookBorrowList(LookParm parm);
}
