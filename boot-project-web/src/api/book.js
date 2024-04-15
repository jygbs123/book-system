import http from '@/utils/http'
// 列表
export const getListApi = async(parm) => {
  return await http.get('/api/books/list', parm)
}
// 查询图书列表
export const getCateListApi = async() => {
  return await http.get('/api/category/cateList', null)
}
// 新增图书
export const addBookApi = async(parms) => {
  return await http.post('/api/books', parms)
}
// 编辑
export const editBookApi = async(parm) => {
  return await http.put('/api/books', parm)
}
// 删除
export const deleteBookApi = async(parm) => {
  return await http.delete('/api/books', parm)
}
export const getHotBookApi = async() => {
  return await http.get('/api/books/getHotBook', null)
}
