package com.itmk.web.book_borrow.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.exception.BusinessException;
import com.itmk.exception_advice.BusinessExceptionEnum;
import com.itmk.web.book_borrow.entity.*;
import com.itmk.web.book_borrow.mapper.BorrowBookMapper;
import com.itmk.web.book_borrow.service.BorrowBookService;
import com.itmk.web.sys_books.entity.SysBooks;
import com.itmk.web.sys_books.service.SysBooksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.stream.Collectors;

@Service
public class BorrowBookServiceImpl extends ServiceImpl<BorrowBookMapper, BorrowBook> implements BorrowBookService {

    @Autowired
    private SysBooksService sysBooksService;

    private Lock lock = new ReentrantLock();

    @Override
    @Transactional
    public void borrow(BorrowParm parm, String userType) {
        //加锁
        lock.lock();
        try {
            //构造查询条件
            QueryWrapper<SysBooks> query = new QueryWrapper<>();
            query.lambda().in(SysBooks::getBookId, parm.getBookIds());
            List<SysBooks> list = sysBooksService.list(query);
            //查看库存是否充足
            List<SysBooks> collect = list.stream().filter(item -> item.getBookStore().longValue() < 1L).collect(Collectors.toList());
            if (collect.size() > 0) {
                //提示哪本图书库存不足
                List<String> stringList = collect.stream().map(SysBooks::getBookName).collect(Collectors.toList());
                throw new BusinessException(BusinessExceptionEnum.NO_STOCK.getCode(),
                        stringList + BusinessExceptionEnum.NO_STOCK.getMessage());
            }
            //减库存，插入借书明细
            List<Long> bookIds = parm.getBookIds();
            for (int i = 0; i < bookIds.size(); i++) {
                Long bookId = bookIds.get(i);
                //减库存
                int res = sysBooksService.subBook(bookId);
                if (res > 0) {
                    BorrowBook borrowBook = new BorrowBook();
                    borrowBook.setBookId(bookId);
                    borrowBook.setReaderId(parm.getReaderId());
                    borrowBook.setReturnTime(parm.getReturnTime());
                    if (userType.equals("0")) { // 0读者
                        borrowBook.setApplyStatus("0");
                        borrowBook.setBorrowStatus("0");
                    } else if (userType.equals("1")) { // 1 管理员
                        borrowBook.setApplyStatus("1");
                        borrowBook.setBorrowStatus("1");
                    } else {
                        throw new BusinessException(500, "用户类型不存在,无法借书!");
                    }
                    borrowBook.setBorrowTime(new Date());
                    //插入明细
                    this.baseMapper.insert(borrowBook);
                }
            }

        } finally {
            //释放锁
            lock.unlock();
        }
    }

    @Override
    public IPage<ReturnBook> getBorrowList(ListParm parm) {
        //构造分页对象
        Page<ReturnBook> page = new Page<>();
        page.setCurrent(parm.getCurrentPage());
        page.setSize(parm.getPageSize());
        return this.baseMapper.getBorrowList(page, parm);
    }

    @Override
    @Transactional
    public void returnBook(List<ReturnParm> list) {
        //加库存，变更借书状态
        for (int i = 0; i < list.size(); i++) {
            //加库存
            int res = sysBooksService.addBook(list.get(i).getBookId());
            if (res > 0) {
                //变更借书状态
                BorrowBook borrowBook = new BorrowBook();
                borrowBook.setBorrowId(list.get(i).getBorrowId());
                borrowBook.setBorrowStatus("2"); //已还
                borrowBook.setReturnStatus("1"); //正常还书
                this.baseMapper.updateById(borrowBook);
            }
        }

    }

    @Override
    public void exceptionBook(ExceptionParm parm) {
        // 0: 异常、破损  1：丢失 ：不能还库存
        String type = parm.getType();
        if (type.equals("0")) {
            //加库存
            int res = sysBooksService.addBook(parm.getBookId());
            if (res > 0) {
                //变更借书状态
                BorrowBook borrowBook = new BorrowBook();
                borrowBook.setBorrowId(parm.getBorrowId());
                borrowBook.setBorrowStatus("2"); //已还
                borrowBook.setReturnStatus("2"); //异常还书
                borrowBook.setExcepionText(parm.getExcepionText());
                this.baseMapper.updateById(borrowBook);
            }
        } else { //丢失
            //变更借书状态
            BorrowBook borrowBook = new BorrowBook();
            borrowBook.setBorrowId(parm.getBorrowId());
            borrowBook.setBorrowStatus("2"); //已还
            borrowBook.setReturnStatus("3"); //丢失
            borrowBook.setExcepionText(parm.getExcepionText());
            this.baseMapper.updateById(borrowBook);
        }
    }

    @Override
    public IPage<LookBorrow> getLookBorrowList(LookParm parm) {
        //构造分页对象
        Page<LookBorrow> page = new Page<>();
        page.setCurrent(parm.getCurrentPage());
        page.setSize(parm.getPageSize());
        return this.baseMapper.getLookBorrowList(page, parm);
    }

    @Override
    public IPage<LookBorrow> getReaderLookBorrowList(LookParm parm) {
        //构造分页对象
        Page<LookBorrow> page = new Page<>();
        page.setCurrent(parm.getCurrentPage());
        page.setSize(parm.getPageSize());
        return this.baseMapper.getReaderLookBorrowList(page,parm);
    }
}
