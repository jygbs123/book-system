<template>
  <!--图书分类 -->
  <el-main>
    <!--搜索栏 -->
    <el-form :model="listParm" label-width="80px" :inline="true" size="small">
      <el-form-item>
        <el-input
          v-model="listParm.categoryName"
          placeholder="请输入类型名称"
        />
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button
          icon="el-icon-close"
          style="color: #ff7670"
          @click="resetBtn"
        >重置
        </el-button>
        <el-button
          v-permission="['sys:bookCategory:add']"
          type="primary"
          icon="el-icon-plus"
          @click="addBtn"
        >新增
        </el-button>
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table :height="tableHeight" :data="tableData" border stripe>
      <el-table-column prop="categoryName" label="分类名称" />
      <el-table-column prop="orderNum" label="序号" />
      <el-table-column label="操作" align="center" width="180">
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:bookCategory:edit']"
            type="primary"
            size="small"
            icon="el-icon-edit"
            @click="editBtn(scope.row)"
          >编辑
          </el-button>
          <el-button
            v-permission="['sys:bookCategory:delete']"
            type="danger"
            size="small"
            icon="el-icon-delete"
            @click="deleteBtn(scope.row)"
          >删除
          </el-button>
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
    <!-- 新增、编辑页面 -->
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
          style="margin-right: 15px"
        >
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="categoryName" label="分类名称">
                <el-input v-model="addModel.categoryName" />
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="序号">
                <el-input v-model="addModel.orderNum" />
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
import { getListApi, addApi, editApi, deleteApi } from '@/api/category'

export default {
  // 注册
  components: {
    SysDialog
  },
  data() {
    return {
      // 表单验证规则
      rules: {
        categoryName: [
          {
            trigger: 'blur',
            required: true,
            message: '请填写分类名称'
          }
        ]
      },
      // 表单绑定的属性
      addModel: {
        type: '',
        categoryId: '',
        categoryName: '',
        orderNum: ''
      },
      // 弹框属性
      dialog: {
        width: 630,
        height: 150,
        title: '',
        visible: false
      },
      // 表格高度
      tableHeight: 0,
      // 表格数据
      tableData: [],
      // 列表参数
      listParm: {
        currentPage: 1,
        pageSize: 10,
        categoryName: '',
        total: 0
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
    // 弹框关闭
    onClose() {
      this.dialog.visible = false
    },
    // 弹框确定
    onConfirm() {
      // 表单验证
      this.$refs.addRef.validate(async(valid) => {
        if (valid) {
          let res = null
          if (this.addModel.type == '0') {
            res = await addApi(this.addModel)
          } else {
            res = await editApi(this.addModel)
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
    // 获取列表
    async getList() {
      const res = await getListApi(this.listParm)
      if (res && res.code == 200) {
        console.log(res)
        this.tableData = res.data.records
        this.listParm.total = res.data.total
      }
    },
    // 页数改变时触发事件
    currentChange(val) {
      this.listParm.currentPage = val
      this.getList()
    },
    // 页容量改动时触发事件
    sizeChange(val) {
      this.listParm.pageSize = val
      this.getList()
    },
    // 删除按钮
    async deleteBtn(row) {
      // 信息确认
      const confrim = await this.$myconfirm('确定删除该数据吗?')
      if (confrim) {
        const res = await deleteApi({ categoryId: row.categoryId })
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
      this.dialog.title = '编辑分类'
      this.dialog.visible = true
      // 清空表单
      this.$resetForm('addRef', this.addModel)
      // 把要编辑的数据复制到表单数据域
      this.$objCoppy(row, this.addModel)
      this.addModel.type = '1'
    },
    // 新增
    addBtn() {
      // 设置弹框属性
      this.dialog.title = '新增分类'
      this.dialog.visible = true
      // 清空表单
      this.$resetForm('addRef', this.addModel)
      this.addModel.type = '0'
    },
    // 重置按钮
    resetBtn() {
      // 清空表单
      this.listParm.categoryName = ''
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
