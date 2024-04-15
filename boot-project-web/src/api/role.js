import http from '@/utils/http'
// 列表
export const getListApi = async(parm) => {
  return await http.get('/api/role/list', parm)
}
// 新增
export const addRoleApi = async(parm) => {
  return await http.post('/api/role', parm)
}
// 编辑
export const editRoleApi = async(parm) => {
  return await http.put('/api/role', parm)
}
// 删除
export const deleteRoleApi = async(parm) => {
  return await http.delete('/api/role', parm)
}
export const getAssingShowApi = async(parm) => {
  return await http.get('/api/role/getAssingShow', parm)
}
// 保存角色分配的权限
export const saveAssignApi = async(parm) => {
  return await http.post('/api/role/assignSave', parm)
}
