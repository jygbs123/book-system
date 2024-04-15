import http from '@/utils/http'
// 借书
export const borrowApi = async(parm) => {
  return await http.post('/api/borrow', parm)
}
// 还书列表
export const returnBorrowApi = async(parm) => {
  return await http.get('/api/borrow/getBorrowList', parm)
}
// 还书
export const returnBooksApi = async(parm) => {
  return await http.post('/api/borrow/returnBooks', parm)
}
// 异常还书
export const exceptionBooksApi = async(parm) => {
  return await http.post('/api/borrow/exceptionBooks', parm)
}
// 借阅查看
export const getLookBorrowListApi = async(parm) => {
  return await http.get('/api/borrow/getLookBorrowList', parm)
}
export const applyBookApi = async(parm) => {
  return await http.post('/api/borrow/applyBook', parm)
}
// 还书续期
export const addTimeApi = async(parm) => {
  return await http.post('/api/borrow/addTime', parm)
}
// 借书待审核总数
export const getBorrowApplyCountApi = async(parm) => {
  return await http.get('/api/borrow/getBorrowApplyCount', parm)
}
// 到期待还书总数
export const getBorrowReturnCountApi = async(parm) => {
  return await http.get('/api/borrow/getBorrowReturnCount', parm)
}

