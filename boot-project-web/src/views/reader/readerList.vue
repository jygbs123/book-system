<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="listParm" :inline="true" size="small">
      <el-form-item>
        <el-input
          v-model="listParm.username"
          placeholder="请输入学号"
        />
      </el-form-item>
      <el-form-item>
        <el-input
          v-model="listParm.learnNum"
          placeholder="请输入姓名"
        />
      </el-form-item>
      <el-form-item>
        <el-input
          v-model="listParm.phone"
          placeholder="请输入电话号码"
        />
      </el-form-item>
      <el-form-item>
        <el-input
          v-model="listParm.idCard"
          placeholder="请输入身份证号码"
        />
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button
          style="color: #ff7670"
          icon="el-icon-close"
          @click="resetBtn"
        >重置
        </el-button>
        <el-button
          v-permission="['sys:reader:add']"
          type="primary"
          icon="el-icon-plus"
          @click="addBtn"
        >新增
        </el-button>
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table :height="tableHeight" :data="tableData" border stripe>
      <el-table-column prop="learnNum" label="姓名" />
      <el-table-column prop="username" label="学号" width="100" />
      <el-table-column prop="className" label="班级" width="120" />
      <el-table-column prop="idCard" label="身份证号" width="165" />
      <el-table-column prop="phone" label="电话" width="120"/>
      <el-table-column prop="sex" label="性别" width="70">
        <template slot-scope="scope">
          <span v-if="scope.row.sex == '0'">男</span>
          <span v-if="scope.row.sex == '1'">女</span>
        </template>
      </el-table-column>
      <el-table-column prop="checkStatus" label="审核状态">
        <template slot-scope="scope">
          <el-tag
            v-if="scope.row.checkStatus == '0'"
            type="danger"
          >未审核
          </el-tag>
          <el-tag v-if="scope.row.checkStatus == '1'">已审核</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="userStatus" label="用户状态">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.userStatus == '0'">停用</el-tag>
          <el-tag v-if="scope.row.userStatus == '1'">启用</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="380">
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:reader:edit']"
            icon="el-icon-edit"
            type="primary"
            size="small"
            @click="editBtn(scope.row)"
          >编辑
          </el-button>
          <el-button
            v-permission="['sys:reader:apply']"
            icon="el-icon-edit"
            type="primary"
            size="small"
            @click="applyBtn(scope.row)"
          >审核
          </el-button>
          <el-button
            v-permission="['sys:reader:resetpassword']"
            icon="el-icon-edit"
            type="danger"
            size="small"
            @click="resetPasswordBtn(scope.row)"
          >重置密码
          </el-button>
          <el-button
            v-permission="['sys:reader:delete']"
            icon="el-icon-delete"
            type="danger"
            size="small"
            @click="deleteBtn(scope.row)"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <el-pagination
      :current-page.sync="listParm.currentPage"
      :page-sizes="[15, 20, 40, 80, 100]"
      :page-size="listParm.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="listParm.total"
      background
      @size-change="sizeChange"
      @current-change="currentChange"
    />
    <!-- 新增弹框 -->
    <sys-dialog
      :title="dialog.title"
      :width="dialog.width"
      :height="dialog.height"
      :visible="dialog.visible"
      @onClose="onClose"
      @onConfirm="onConfirm"
    >
      <div slot="content">
        <el-form
          ref="addRef"
          :model="addModel"
          :rules="rules"
          label-width="80px"
          size="small"
          style="margin-right: 30px"
        >
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="learnNum" label="姓名">
                <el-input v-model="addModel.learnNum" />
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="phone" label="电话">
                <el-input v-model="addModel.phone" maxlength="11" />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="username" label="学号">
                <el-input v-model="addModel.username" />
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="className" label="班级">
                <el-input v-model="addModel.className" />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="idCard" label="身份证">
                <el-input v-model="addModel.idCard" maxlength="18" />
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
              <el-form-item label="性别">
                <el-radio-group v-model="addModel.sex">
                  <el-radio :label="'0'">男</el-radio>
                  <el-radio :label="'1'">女</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import SysDialog from '@/components/dialog/SysDialog.vue'
import {
  getListApi,
  addReaderApi,
  editReaderApi,
  deleteReaderApi,
  applyReaderApi,
  resetPasswordApi
} from '@/api/reader'

export default {
  // 注册组件
  components: {
    SysDialog
  },
  data() {
    return {
      // 弹框属性
      dialog: {
        title: '',
        width: 640,
        height: 230,
        visible: false
      },
      rules: {
        learnNum: [{ required: true, message: '请填写姓名', trigger: 'blur' }],
        username: [{ required: true, message: '请填写学号', trigger: 'blur' }],
        idCard: [
          { required: true, message: '请填写身份证号', trigger: 'blur' }
        ],
        phone: [
          { pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/, required: true, message: '请输入正确的手机号码', trigger: 'blur' }
        ],
        password: [{ required: true, message: '请填写密码', trigger: 'blur' }],
        className: [{ required: true, message: '请填写班级', trigger: 'blur' }]
      },
      // 表单属性
      addModel: {
        type: '',
        readerId: '',
        learnNum: '',
        username: '',
        idCard: '',
        sex: '',
        phone: '',
        password: '',
        className: '',
        checkStatus: '',
        userStatus: ''
      },
      // 表格高度
      tableHeight: 0,
      // 表格数据
      tableData: [],
      // 列表参数
      listParm: {
        total: 0,
        currentPage: 1,
        pageSize: 15,
        username: '',
        idCard: '',
        phone: '',
        learnNum: ''
      }
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.tableHeight = window.innerHeight - 220
    })
  },
  created() {
    this.getList()
  },
  methods: {
    async resetPasswordBtn(row) {
      const confirm = await this.$myconfirm('确定重置密码吗，重置之后默认密码为【666666】?')
      if (confirm) {
        console.log(row)
        const res = await resetPasswordApi({
          readerId: row.readerId
        })
        if (res && res.code == 200) {
          this.$message.success(res.msg)
        }
      }
    },
    async applyBtn(row) {
      const confirm = await this.$myconfirm('确定审核吗?')
      if (confirm) {
        console.log(row)
        const res = await applyReaderApi({ readerId: row.readerId })
        if (res && res.code == 200) {
          this.$message.success(res.msg)
          // 刷新表格
          this.getList()
        }
      }
    },
    // 弹框确定
    onConfirm() {
      this.$refs.addRef.validate(async(valid) => {
        if (valid) {
          let res = null
          if (this.addModel.type == '0') {
            res = await addReaderApi(this.addModel)
          } else {
            res = await editReaderApi(this.addModel)
          }
          if (res && res.code == 200) {
            // 信息提示
            this.$message({ type: 'success', message: res.msg })
            // 刷新表格
            this.getList()
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
    },
    // 页容量改变时触发
    sizeChange(val) {
    },
    // 获取列表
    async getList() {
      const res = await getListApi(this.listParm)
      if (res && res.code == 200) {
        console.log(res)
        this.tableData = res.data.records
        this.listParm.total = res.data.total
      }
    },
    // 删除按钮
    async deleteBtn(row) {
      const confirm = await this.$myconfirm('确定删除该数据吗?')
      if (confirm) {
        const res = await deleteReaderApi({ readerId: row.readerId })
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
      this.dialog.title = '编辑读者'
      this.dialog.visible = true
      // 清空表单
      this.$resetForm('addRef', this.addModel)
      // 把要编辑的数据复制到表单数据域
      this.$objCoppy(row, this.addModel)
      // 设置编辑属性
      this.addModel.type = '1'
    },
    // 新增按钮
    addBtn() {
      this.dialog.title = '新增读者'
      this.dialog.visible = true
      // 清空表单
      this.$resetForm('addRef', this.addModel)
      // 设置编辑属性
      this.addModel.type = '0'
    },
    // 重置按钮
    resetBtn() {
      this.listParm.username = ''
      this.listParm.idCard = ''
      this.listParm.learnNum = ''
      this.listParm.phone = ''
      this.getList()
    },
    // 搜索按钮
    searchBtn() {
      this.getList()
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
