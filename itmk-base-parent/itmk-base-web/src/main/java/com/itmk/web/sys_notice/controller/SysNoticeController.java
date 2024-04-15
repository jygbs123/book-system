package com.itmk.web.sys_notice.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.itmk.annotation.Auth;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.sys_notice.entity.NoticeParm;
import com.itmk.web.sys_notice.entity.SysNotice;
import com.itmk.web.sys_notice.service.SysNoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/api/notice")
public class SysNoticeController {
    @Autowired
    private SysNoticeService sysNoticeService;

    //新增
    @Auth
    @PostMapping
    public ResultVo add(@RequestBody SysNotice sysNotice){
        sysNotice.setCreateTime(new Date());
        boolean save = sysNoticeService.save(sysNotice);
        if(save){
            return ResultUtils.success("新增成功");
        }
        return ResultUtils.error("新增失败!");
    }

    //编辑
    @Auth
    @PutMapping
    public ResultVo edit(@RequestBody SysNotice sysNotice){
        boolean save = sysNoticeService.updateById(sysNotice);
        if(save){
            return ResultUtils.success("编辑成功");
        }
        return ResultUtils.error("编辑失败!");
    }

    //删除
    @Auth
    @DeleteMapping("/{noticeId}")
    public ResultVo delete(@PathVariable("noticeId") Long noticeId){
        boolean save = sysNoticeService.removeById(noticeId);
        if(save){
            return ResultUtils.success("删除成功");
        }
        return ResultUtils.error("删除失败!");
    }

    //列表
    @Auth
    @GetMapping("/list")
    public ResultVo getList(NoticeParm parm){
        IPage<SysNotice> list = sysNoticeService.getList(parm);
        return ResultUtils.success("查询成功",list);
    }

    //列表
    @Auth
    @GetMapping("/getTopList")
    public ResultVo getTopList(){
        QueryWrapper<SysNotice> query = new QueryWrapper<>();
        query.lambda().orderByDesc(SysNotice::getCreateTime).last("limit 3");
        List<SysNotice> list = sysNoticeService.list(query);
        return ResultUtils.success("查询成功",list);
    }
}
