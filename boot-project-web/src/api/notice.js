import http from '@/utils/http'
// 列表
export const getListApi = async(parm) => {
  return await http.get('/api/notice/list', parm)
}
// 新增
export const addApi = async(parm) => {
  return await http.post('/api/notice', parm)
}
// 编辑
export const editApi = async(parm) => {
  return await http.put('/api/notice', parm)
}
// 删除
export const deleteApi = async(parm) => {
  return await http.delete('/api/notice', parm)
}
export const getTopListApi = async() => {
  return await http.get('/api/notice/getTopList', null)
}
