<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="noticeParm" label-width="80px" :inline="true" size="mini">
      <el-form-item label="公告标题">
        <el-input v-model="noticeParm.noticeTitle" />
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
          v-permission="['sys:noticeList:add']"
          type="primary"
          icon="el-icon-plus"
          @click="addBtn"
        >新增
        </el-button>
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table
      size="small"
      :height="tableHeight"
      :data="tableData"
      border
      stripe
    >
      <el-table-column prop="noticeTitle" label="公告标题" />
      <el-table-column prop="noticeContent" label="公告内容" />
      <el-table-column prop="createTime" label="公告时间" />
      <el-table-column label="操作" align="center" width="180">
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:noticeList:edit']"
            type="primary"
            size="small"
            icon="el-icon-edit"
            @click="editBtn(scope.row)"
          >编辑
          </el-button>
          <el-button
            v-permission="['sys:noticeList:delete']"
            type="danger"
            icon="el-icon-delete"
            size="small"
            @click="deleteBtn(scope.row)"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <el-pagination
      :current-page.sync="noticeParm.currentPage"
      :page-sizes="[10, 20, 40, 80, 100]"
      :page-size="noticeParm.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="noticeParm.total"
      background
      @size-change="sizeChange"
      @current-change="currentChange"
    />
    <!-- 新增、编辑弹框 -->
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
          :inline="false"
          size="small"
        >
          <el-form-item prop="noticeTitle" label="标题">
            <el-input v-model="addModel.noticeTitle" />
          </el-form-item>
          <el-form-item prop="noticeContent" label="内容">
            <el-input
              v-model="addModel.noticeContent"
              type="textarea"
            />
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import { addApi, editApi, deleteApi } from '@/api/notice'
import SysDialog from '@/components/dialog/SysDialog.vue'
import { getListApi } from '@/api/notice'

export default {
  // 注册组件
  components: {
    SysDialog
  },
  data() {
    return {
      // 表单验证规则
      rules: {
        noticeTitle: [
          { required: true, message: '请输入标题', trigger: 'blur' }
        ],
        noticeContent: [
          { required: true, message: '请输入内容', trigger: 'blur' }
        ]
      },
      addModel: {
        editType: '', // 0：新增 1：编辑
        noticeId: '',
        noticeTitle: '',
        noticeContent: ''
      },
      // 弹框属性
      dialog: {
        title: '',
        width: 650,
        height: 180,
        visible: false
      },
      tableHeight: 0,
      tableData: [],
      noticeParm: {
        currentPage: 1,
        pageSize: 10,
        noticeTitle: '',
        total: 0
      }
    }
  },
  created() {
    this.getList()
  },
  mounted() {
    this.$nextTick(() => {
      this.tableHeight = window.innerHeight - 220
    })
  },
  methods: {
    onConfirm() {
      // 表单验证
      this.$refs.addRef.validate(async(valid) => {
        if (valid) {
          let res = null
          if (this.addModel.editType == '0') {
            res = await addApi(this.addModel)
          } else {
            res = await editApi(this.addModel)
          }
          if (res && res.code == 200) {
            this.$message.success(res.msg)
            this.getList()
            this.dialog.visible = false
          }
        }
      })
    },
    onClose() {
      this.dialog.visible = false
    },
    currentChange(val) {
    },
    sizeChange(val) {
    },
    async deleteBtn(row) {
      const confirm = await this.$myconfirm('确定删除该数据吗?')
      if (confirm) {
        const parm = {
          noticeId: row.noticeId
        }
        const res = await deleteApi(parm)
        if (res && res.code == 200) {
          this.$message.success(res.msg)
          this.getList()
        }
      }
    },
    editBtn(row) {
      // 清空表单
      this.$resetForm('addRef', this.addModel)
      // 把要编辑的数据设置到addModel里面
      this.$objCoppy(row, this.addModel)
      // 设置type
      this.addModel.editType = '1'
      // 弹框显示
      this.dialog.title = '编辑公告'
      this.dialog.visible = true
    },
    // 重置按钮
    resetBtn() {
      this.noticeParm.noticeTitle = ''
      this.getList()
    },
    // 搜索按钮
    searchBtn() {
      this.getList()
    },
    // 新增按钮
    addBtn() {
      // 清空表单
      this.$resetForm('addRef', this.addModel)
      // 设置type
      this.addModel.editType = '0'
      // 弹框显示
      this.dialog.title = '新增公告'
      this.dialog.visible = true
    },
    async getList() {
      const res = await getListApi(this.noticeParm)
      if (res && res.code == 200) {
        this.tableData = res.data.records
        this.noticeParm.total = res.data.total
      }
    }
  }
}
</script>

<style>
</style>
