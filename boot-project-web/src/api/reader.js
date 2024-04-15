import http from '@/utils/http'
// 列表
export const getListApi = async(parm) => {
  return await http.get('/api/reader/list', parm)
}
// 新增
export const addReaderApi = async(parm) => {
  return await http.post('/api/reader', parm)
}
// 编辑
export const editReaderApi = async(parm) => {
  return await http.put('/api/reader', parm)
}
// 删除
export const deleteReaderApi = async(parm) => {
  return await http.delete('/api/reader', parm)
}
// 根据学号查询
export const getByUserNameApi = async(parm) => {
  return await http.get('/api/reader/getByUserName', parm)
}
// 读者注册
export const registerApi = async(parm) => {
  return await http.post('/api/reader/register', parm)
}
// 读者审核
export const applyReaderApi = async(parm) => {
  return await http.put('/api/reader/applyReader', parm)
}
// 读者总数
export const getReaderCountApi = async(parm) => {
  return await http.get('/api/reader/getReaderCount', parm)
}
// 待审核读者总数
export const getApplyReaderCountApi = async(parm) => {
  return await http.get('/api/reader/getApplyReaderCount', parm)
}
// 重置密码
export const resetPasswordApi = async(parm) => {
  return await http.post('/api/reader/resetPassword', parm)
}
