<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="listParm" label-width="80px" :inline="true" size="small">
      <el-form-item label="学号">
        <el-input v-model="listParm.username" />
      </el-form-item>
      <el-form-item label="借书状态">
        <el-select v-model="listParm.borrowStatus" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button icon="el-icon-close" @click="resetBtn">重置</el-button>
        <el-button
          type="primary"
          icon="el-icon-edit"
          @click="returnBtn"
        >批量还书
        </el-button>
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table
      ref="tables"
      :height="tableHeight"
      :data="tableData"
      border
      stripe
    >
      <el-table-column type="selection" width="55" />
      <el-table-column prop="bookName" label="图书名称" />
      <el-table-column prop="bookPlaceNum" label="书架号" />
      <el-table-column prop="username" label="学号" />
      <el-table-column prop="learnNum" label="读者" />
      <el-table-column prop="className" label="班级" />
      <el-table-column prop="phone" label="电话" />
      <el-table-column prop="borrowTime" label="借书时间" />
      <el-table-column prop="returnTime" label="还书时间" />
      <el-table-column
        prop="borrowStatus"
        label="借书状态"
        align="center"
        width="100"
      >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.borrowStatus == '0'" type="danger">审核中</el-tag>
          <el-tag v-if="scope.row.borrowStatus == '1'">在借中</el-tag>
          <el-tag
            v-if="scope.row.borrowStatus == '2'"
            type="success"
          >已还
          </el-tag>
          <el-tag
            v-if="scope.row.borrowStatus == '3'"
            type="danger"
          >拒绝
          </el-tag>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" width="210">
        <template slot-scope="scope">
          <el-button
            type="primary"
            icon="el-icon-edit"
            size="small"
            @click="alongReturnBtn(scope.row)"
          >还书
          </el-button>
          <el-button
            type="danger"
            icon="el-icon-edit"
            size="small"
            @click="ExceptioReturnBtn(scope.row)"
          >异常还书
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
    <!-- 异常还书备注 -->
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
          ref="exceptionRef"
          :model="exception"
          :rules="rules"
          label-width="80px"
          size="small"
        >
          <el-form-item prop="type" label="异常类型">
            <el-select v-model="exception.type" placeholder="请选择">
              <el-option
                v-for="item in exoptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item prop="excepionText" label="备注">
            <el-input
              v-model="exception.excepionText"
              type="textarea"
            />
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import SysDialog from '@/components/dialog/SysDialog.vue'
import {
  returnBorrowApi,
  returnBooksApi,
  exceptionBooksApi
} from '@/api/borrow'

export default {
  components: {
    SysDialog
  },
  data() {
    return {
      rules: {
        type: [
          { required: true, message: '请选择异常类型', trigger: 'change' }
        ],
        excepionText: [
          { required: true, message: '请填写备注', trigger: 'change' }
        ]
      },
      exoptions: [
        {
          value: '0',
          label: '异常还书'
        },
        {
          value: '1',
          label: '丢失'
        }
      ],
      exception: {
        borrowId: '',
        bookId: '',
        type: '',
        excepionText: '',
        timeStatus: ''
      },
      // 弹框属性定义
      dialog: {
        width: 630,
        height: 150,
        title: '还书备注',
        visible: false
      },
      bookIds: [],
      tableHeight: 0,
      options: [
        {
          value: '0',
          label: '审核中'
        },
        {
          value: '1',
          label: '在借中'
        },
        {
          value: '2',
          label: '已还'
        },
        {
          value: '3',
          label: '拒绝'
        }
      ],
      tableData: [],
      listParm: {
        currentPage: 1,
        pageSize: 10,
        username: '',
        borrowStatus: '1',
        total: 0,
        timeStatus: ''
      }
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.tableHeight = window.innerHeight - 220
    })
  },
  created() {
    this.returnBorrow()
  },
  methods: {
    onConfirm() {
      this.$refs.exceptionRef.validate(async(valid) => {
        if (valid) {
          const res = await exceptionBooksApi(this.exception)
          if (res && res.code == 200) {
            this.$message.success(res.msg)
            this.returnBorrow()
            this.dialog.visible = false
          }
        }
      })
    },
    onClose() {
      this.dialog.visible = false
    },
    // 异常还书的事件
    ExceptioReturnBtn(row) {
      this.exception.borrowId = row.borrowId
      this.exception.bookId = row.bookId
      this.dialog.visible = true
    },
    // 单独还书的事件
    async alongReturnBtn(row) {
      this.bookIds = []
      console.log(row)
      const confirm = await this.$myconfirm('确定还书吗?')
      if (confirm) {
        if (row.borrowStatus == '1') {
          // 在借中的才能还
          const obj = {}
          obj.borrowId = row.borrowId
          obj.bookId = row.bookId
          this.bookIds.push(obj)
          const res = await returnBooksApi(this.bookIds)
          if (res && res.code == 200) {
            this.$message.success(res.msg)
            this.returnBorrow()
          }
        }
      }
    },
    currentChange(val) {
      this.listParm.currentPage = val
      this.returnBorrow()
    },
    sizeChange(val) {
      this.listParm.pageSize = val
      this.returnBorrow()
    },
    async returnBtn() {
      this.bookIds = []
      const confirm = await this.$myconfirm('确定还书吗?')
      if (confirm) {
        const datas = this.$refs.tables.selection
        if (datas.length == 0) {
          this.$message.error('请选择要还的书！')
          return
        }
        for (let i = 0; i < datas.length; i++) {
          const obj = {}
          obj.borrowId = datas[i].borrowId
          obj.bookId = datas[i].bookId
          this.bookIds.push(obj)
        }
        const res = await returnBooksApi(this.bookIds)
        if (res && res.code == 200) {
          this.$message.success(res.msg)
          this.returnBorrow()
        }
      }
    },
    resetBtn() {
      this.listParm.currentPage = 1
      this.listParm.username = ''
      this.listParm.borrowStatus = ''
      this.returnBorrow()
    },
    searchBtn() {
      this.returnBorrow()
    },
    async returnBorrow() {
      const res = await returnBorrowApi(this.listParm)
      if (res && res.code == 200) {
        console.log(res)
        this.tableData = res.data.records
        this.listParm.total = res.data.total
      }
    }
  }
}
</script>

<style>
</style>
