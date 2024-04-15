import http from '@/utils/http'
// 列表
export const getListApi = async(parm) => {
  return await http.get('/api/category/list', parm)
}
// 新增
export const addApi = async(parm) => {
  return await http.post('/api/category', parm)
}
// 编辑
export const editApi = async(parm) => {
  return await http.put('/api/category', parm)
}
// 删除
export const deleteApi = async(parm) => {
  return await http.delete('/api/category', parm)
}
export const categoryCountApi = async() => {
  return await http.get('/api/category/categoryCount', null)
}
