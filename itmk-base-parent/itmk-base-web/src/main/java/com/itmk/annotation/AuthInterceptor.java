package com.itmk.annotation;

import com.itmk.exception.BusinessException;
import com.itmk.jwt.JwtUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class AuthInterceptor implements HandlerInterceptor {
    @Autowired
    private JwtUtils jwtUtils;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Auth annotation;
        if(handler instanceof HandlerMethod){
            annotation = ((HandlerMethod) handler).getMethodAnnotation(Auth.class);
        }else{
            return true;
        }
        if(annotation == null){
            return true;
        }
        //获取token
        String token = request.getHeader("token");
        if(StringUtils.isEmpty(token)){
            token = request.getParameter("token");
        }
        if(StringUtils.isEmpty(token)){
            throw new BusinessException(600,"token不能为空!");
        }
        //判断是否过期
        Boolean expired = jwtUtils.isTokenExpired(token);
        if(expired){
            throw new BusinessException(600,"token过期!");
        }
        //解析token
        String username = jwtUtils.getUsernameFromToken(token);
        if(StringUtils.isEmpty(username)){
            throw new BusinessException(600,"token验证失败!");
        }
        return true;
    }
}
