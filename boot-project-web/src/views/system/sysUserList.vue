<template>
  <!-- element的标签，只需要当做一个普通的div看待就可以 -->
  <el-main>
    <!-- 搜索栏
     model :绑定表单的数据，通常是一个对象
     ref ： 相当于div的id
     rules ：表单验证的规则
     label-width ： 表单域标签的宽度
     inline ： 是否在同一行显示
     size ：尺寸
      -->
    <el-form
      ref="searchRef"
      :model="listParm"
      label-width="80px"
      :inline="true"
      size="small"
      :rules="rules"
    >
      <el-form-item>
        <el-input
          v-model="listParm.nickName"
          placeholder="请输入姓名"
        />
      </el-form-item>
      <el-form-item>
        <el-input v-model="listParm.phone" placeholder="请输入电话" />
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button
          icon="el-icon-close"
          style="color: #ff7670"
          @click="resetBtn"
        >重置</el-button>
        <el-button
          v-permission="['sys:user:add']"
          type="primary"
          icon="el-icon-plus"
          @click="addBtn"
        >新增</el-button>
      </el-form-item>
    </el-form>
    <!-- 表格
     data： 表格的数据
      -->
    <el-table :height="tableHeight" :data="tableData" border stripe>
      <el-table-column prop="nickName" label="姓名" />
      <el-table-column prop="phone" label="电话" />
      <el-table-column prop="email" label="邮箱" />
      <el-table-column label="操作" align="center" width="300">
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:user:edit']"
            type="primary"
            icon="el-icon-edit"
            size="small"
            @click="editBtn(scope.row)"
          >编辑</el-button>
          <el-button
            v-permission="['sys:user:resetpassword']"
            type="danger"
            icon="el-icon-edit"
            size="small"
            @click="resetPasswordBtn(scope.row)"
          >重置密码</el-button>
          <el-button
            v-permission="['sys:user:delete']"
            type="danger"
            icon="el-icon-delete"
            size="small"
            @click="deleteBtn(scope.row)"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <el-pagination
      :current-page.sync="listParm.currentPage"
      :page-sizes="[10, 20, 40, 80, 100]"
      :page-size="listParm.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="listParm.total"
      background
      @size-change="sizeChange"
      @current-change="currentChange"
    />
    <!-- 新增或编辑弹框 -->
    <sys-dialog
      :title="dialog.title"
      :visible="dialog.visible"
      :width="dialog.width"
      :height="dialog.height"
      @onClose="onClose"
      @onConfirm="onConfirm"
    >
      <div slot="content">
        <!-- el-form : 当做一个普通的form标签
        model ：表单绑定的数据对象
        ref ： 相当于div的id , 唯一的
        rules ： 表单验证规则
        label-width ： 表单域标签的宽度
        inline ： 是否在同一行展示
        size ：尺寸
         -->
        <el-form
          ref="addRef"
          :model="addModel"
          :rules="rules"
          label-width="80px"
          :inline="false"
          size="small"
          style="margin-right: 40px"
        >
          <!-- el-row  : 代表一行，分为24等分
              el-col ： 代表列
         -->
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="nickName" label="姓名">
                <el-input v-model="addModel.nickName" />
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="phone" label="电话">
                <el-input v-model="addModel.phone" />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="邮箱">
                <el-input v-model="addModel.email" />
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="sex" label="性别">
                <el-radio-group v-model="addModel.sex">
                  <el-radio :label="'0'">男</el-radio>
                  <el-radio :label="'1'">女</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="username" label="账户">
                <el-input v-model="addModel.username" />
              </el-form-item>
            </el-col>
            <el-col v-if="addModel.type == '0'" :span="12" :offset="0">
              <el-form-item prop="password" label="密码">
                <el-input v-model="addModel.password" />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="username" label="角色">
                <el-select v-model="addModel.roleId" placeholder="请选择">
                  <el-option
                    v-for="item in options"
                    :key="item.roleId"
                    :label="item.roleName"
                    :value="item.roleId"
                  />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import {
  addUserApi,
  editUserApi,
  getListApi,
  deleteUserApi,
  getRoleListApi,
  getRoleIdApi,
  resetPasswordApi
} from '@/api/user'
// 引入弹框组件
import SysDialog from '@/components/dialog/SysDialog.vue'
export default {
  // 注册组件
  components: {
    SysDialog
  },
  data() {
    return {
      options: [],
      // 表单验证规则
      rules: {
        nickName: [
          {
            trigger: 'blur',
            required: true,
            message: '请填写姓名'
          }
        ],
        phone: [
          {
            trigger: 'blur',
            required: true,
            message: '请填写电话'
          }
        ],
        sex: [
          {
            trigger: 'blur',
            required: true,
            message: '请选择性别'
          }
        ],
        username: [
          {
            trigger: 'blur',
            required: true,
            message: '请填写账户'
          }
        ],
        password: [
          {
            trigger: 'blur',
            required: true,
            message: '请填写密码'
          }
        ]
      },
      // 表单绑定的数据
      addModel: {
        roleId: '',
        type: '', // 0:新增 1：编辑
        userId: '',
        nickName: '',
        phone: '',
        email: '',
        sex: '',
        username: '',
        password: ''
      },
      // 弹框属性
      dialog: {
        title: '',
        visible: false,
        width: 630,
        height: 230
      },
      // 表格的高度
      tableHeight: 0,
      // 列表查询的参数
      listParm: {
        nickName: '',
        phone: '',
        currentPage: 1,
        pageSize: 10,
        total: 3
      },
      // 表格的数据
      tableData: []
    }
  },
  created() {
    this.getList()
    this.getRoleList()
  },
  mounted() {
    this.$nextTick(() => {
      // 计算表格高度
      this.tableHeight = window.innerHeight - 220
    })
  },
  methods: {
    async resetPasswordBtn(row) {
      const confirm = await this.$myconfirm('确定重置密码吗，重置之后默认密码为【666666】?')
      if (confirm) {
        console.log(row)
        const res = await resetPasswordApi({
          userId: row.userId
        })
        if (res && res.code == 200) {
          this.$message.success(res.msg)
        }
      }
    },
    async getRoleId(userId) {
      const res = await getRoleIdApi({ userId: userId })
      if (res && res.code == 200) {
        console.log(res)
        this.addModel.roleId = res.data.roleId
      }
    },
    // 重置按钮
    resetBtn() {
      this.listParm.nickName = ''
      this.listParm.phone = ''
      this.getList()
    },
    // 搜索按钮
    searchBtn() {
      this.getList()
    },
    // 获取列表
    async getList() {
      const res = await getListApi(this.listParm)
      console.log('返回成功')
      console.log(res)
      if (res && res.code == 200) {
        this.tableData = res.data.records
        this.total = res.data.total
      }
    },
    // 弹框确定
    onConfirm() {
      // 表单验证
      this.$refs.addRef.validate(async(valid) => {
        if (valid) {
          let res = null
          if (this.addModel.type == '0') {
            res = await addUserApi(this.addModel)
          } else {
            res = await editUserApi(this.addModel)
          }
          if (res && res.code == 200) {
            // 信息提示
            this.$message({ type: 'success', message: res.msg })
            // 刷新表格
            this.getList()
            // 关闭弹框
            this.dialog.visible = false
          }
        }
      })
    },
    // 弹框关闭
    onClose() {
      this.dialog.visible = false
    },
    // 页数改变时触发
    currentChange(val) {
      this.listParm.currentPage = val
      this.getList()
    },
    // 页容量改变时触发
    sizeChange(val) {
      this.listParm.pageSize = val
      this.getList()
    },
    // 删除按钮
    async deleteBtn(row) {
      const confirm = await this.$myconfirm('确定删除该数据吗?')
      if (confirm) {
        const res = await deleteUserApi({ userId: row.userId })
        if (res && res.code == 200) {
          // 信息提示
          this.$message({ type: 'success', message: res.msg })
          // 刷新表格
          this.getList()
        }
      }
    },
    // 编辑按钮
    editBtn(row) {
      // 设置弹框属性
      this.dialog.title = '编辑用户'
      this.dialog.visible = true
      // 清空表单
      this.$resetForm('addRef', this.addModel)

      // 把要编辑的数据复制到表单绑定的数据域
      this.$objCoppy(row, this.addModel)
      // 设置编辑
      this.addModel.type = '1'
      this.getRoleId(row.userId)
    },
    // 新增按钮
    addBtn() {
      // 设置弹框属性
      this.dialog.title = '新增用户'
      this.dialog.visible = true
      // 清空表单
      this.$resetForm('addRef', this.addModel)
      // 设置为新增
      this.addModel.type = '0'
    },
    async getRoleList() {
      const res = await getRoleListApi()
      console.log(res)
      if (res && res.code == 200) {
        this.options = res.data
      }
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
