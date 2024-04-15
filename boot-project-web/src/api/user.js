import request from '@/utils/request'
import http from '@/utils/http'
// 此登录，mock.js数据,实际开发中，会调用后端接口
// export function login(data) {
//   return request({
//     url: '/vue-admin-template/user/login',
//     method: 'post',
//     data
//   })
// }
export const loginApi = async(parm) => {
  return await http.post('/api/system/login', parm)
}
// export function getInfo(token) {
//   return request({
//     url: '/vue-admin-template/user/info',
//     method: 'get',
//     params: { token }
//   })
// }

export const getInfo = async(parm) => {
  return await http.get('/api/system/getInfo', parm)
}

export function logout() {
  return request({
    url: '/vue-admin-template/user/logout',
    method: 'post'
  })
}

// 获取用户列表
export const getListApi = async(parm) => {
  return await http.get('/api/user/list', parm)
}
// 新增
export const addUserApi = async(parm) => {
  return await http.post('/api/user', parm)
}
// 编辑
export const editUserApi = async(parm) => {
  return await http.put('/api/user', parm)
}
// 删除
export const deleteUserApi = async(parm) => {
  return await http.delete('/api/user', parm)
}
// 获取角色列表
export const getRoleListApi = async() => {
  return await http.get('/api/user/getRoleList', null)
}
// 根据用户id查询角色
export const getRoleIdApi = async(parm) => {
  return await http.get('/api/user/getRoleId', parm)
}
// 获取菜单列表
export const getMenuListApi = async() => {
  return await http.get('/api/system/getMenuList', null)
}
// 修改密码
export const updatePasswordApi = async(parm) => {
  return await http.post('/api/user/updatePassword', parm)
}
// 重置密码
export const resetPasswordApi = async(parm) => {
  return await http.post('/api/user/resetPassword', parm)
}
