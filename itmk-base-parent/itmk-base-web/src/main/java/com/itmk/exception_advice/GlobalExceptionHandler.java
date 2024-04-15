package com.itmk.exception_advice;


import com.itmk.exception.BusinessException;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class GlobalExceptionHandler {
     /**
     * 自定义业务异常拦截
     * BusinessException
     */
    @ExceptionHandler(BusinessException.class)
    @ResponseBody
    public ResultVo bussinessexception(BusinessException e) {

        return ResultUtils.error(e.getMessage(),e.getCode(),e.getMessage());
    }

    /**
     * 未知的运行时异常拦截
     */
    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ResponseBody
    public ResultVo notFount(RuntimeException e) {
        return ResultUtils.error(e.getMessage(),BusinessExceptionEnum.SERVER_ERROR.getCode(),
                BusinessExceptionEnum.SERVER_ERROR.getMessage());
    }
}