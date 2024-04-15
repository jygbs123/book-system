// 重置表单
export default function resetForm(formName, obj) {
  // 重置表单
  if (this.$refs[formName]) {
    this.$refs[formName].resetFields()
    this.$refs[formName].clearValidate()
  }
  // 清空数据
  Object.keys(obj).forEach(key => {
    obj[key] = ''
  })
}
