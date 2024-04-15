<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="listParm" label-width="80px" :inline="true" size="small">
      <el-form-item>
        <el-input
          v-model="listParm.roleName"
          placeholder="请输入角色名称"
        />
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button
          icon="el-icon-close"
          style="color: #ff7670"
          @click="resetBtn"
        >重置</el-button>
        <el-button
          v-permission="['sys:role:add']"
          type="primary"
          icon="el-icon-plus"
          @click="addBtn"
        >新增</el-button>
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table :height="tableHeight" :data="tableData" border stripe>
      <el-table-column prop="roleName" label="角色名称" />
      <el-table-column prop="roleType" label="角色类型">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.roleType == '1'">系统角色</el-tag>
          <el-tag
            v-if="scope.row.roleType == '2'"
            type="success"
          >读者角色</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="remark" label="角色备注" />
      <el-table-column label="操作"  width="300">
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:role:edit']"
            type="primary"
            size="small"
            icon="el-icon-edit"
            @click="editBtn(scope.row)"
          >编辑</el-button>
          <el-button
            type="primary"
            size="small"
            icon="el-icon-edit"
            @click="assignBtn(scope.row)"
          >分配权限</el-button>
          <el-button
            v-if="scope.row.roleType == '2'"
            v-permission="['sys:role:delete']"
            type="danger"
            size="small"
            icon="el-icon-delete"
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
    <!-- 新增编辑弹框 -->
    <sys-dialog
      :title="dialog.title"
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
        >
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="roleName" label="角色名称">
                <el-input v-model="addModel.roleName" />
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="角色类型">
                <el-select v-model="addModel.roleType" placeholder="请选择">
                  <el-option
                    v-for="item in options"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="角色备注">
                <el-input v-model="addModel.remark" />
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </sys-dialog>
    <!-- 分配权限的弹框 -->
    <sys-dialog
      :title="assignDialog.title"
      :visible="assignDialog.visible"
      :width="assignDialog.width"
      :height="assignDialog.height"
      @onConfirm="assignConfirm"
      @onClose="assignClose"
    >
      <div slot="content">
        <el-tree
          ref="assignTree"
          :data="assignTreeData"
          node-key="menuId"
          :props="defaultProps"
          empty-text="暂无数据"
          :show-checkbox="true"
          default-expand-all
          :default-checked-keys="assignTreeChecked"
        />
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import SysDialog from '@/components/dialog/SysDialog.vue'
import {
  getListApi,
  addRoleApi,
  editRoleApi,
  deleteRoleApi,
  getAssingShowApi,
  saveAssignApi
} from '@/api/role'
export default {
  // 注册组件
  components: {
    SysDialog
  },
  data() {
    return {
      defaultProps: {
        children: 'children',
        label: 'title'
      },
      options: [
        {
          value: '1',
          label: '系统用户'
        },
        {
          value: '2',
          label: '读者'
        }
      ],
      // 表单验证
      rules: {
        roleName: [
          {
            trigger: 'blur',
            required: true,
            message: '请填写角色名称'
          }
        ]
      },
      // 表单数据
      addModel: {
        type: '', // 0：新增 1：编辑
        roleId: '',
        roleName: '',
        remark: '',
        roleType: ''
      },
      // 弹框属性
      dialog: {
        title: '',
        height: 150,
        visible: false
      },
      // 表格高度
      tableHeight: 0,
      // 列表查询参数
      listParm: {
        pageSize: 10,
        currentPage: 1,
        roleName: '',
        total: 0
      },
      tableData: [],
      // 角色Id
      roleId: '',
      // 树数据
      assignTreeData: [],
      // 角色原来的权限
      assignTreeChecked: [],
      assignDialog: {
        title: '',
        visible: false,
        width: 300,
        height: 450
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
    assignClose() {
      this.assignDialog.visible = false
    },
    async assignConfirm() {
      // 获取树选中的数据
      const ids = this.$refs.assignTree
        .getCheckedKeys()
        .concat(this.$refs.assignTree.getHalfCheckedKeys())
      console.log(ids)
      const parm = {
        roleId: this.roleId,
        list: ids
      }
      const res = await saveAssignApi(parm)
      if (res && res.code == 200) {
        this.$message({ type: 'success', message: res.msg })
        this.assignDialog.visible = false
      }
    },
    async assignBtn(row) {
      // 清空数据
      this.roleId = ''
      this.assignTreeData = []
      this.assignTreeChecked = []
      this.roleId = row.roleId
      // 设置弹框属性
      this.assignDialog.title = '为【' + row.roleName + '】分配权限'
      this.assignDialog.visible = true
      // 获取权限数据
      const parm = {
        userId: '3',
        roleId: this.roleId
      }
      const res = await getAssingShowApi(parm)
      console.log(res)
      if (res && res.code == 200) {
        this.assignTreeData = res.data.menuList
        this.assignTreeChecked = res.data.checkList
      }
      // 如果角色原来有权限
      if (this.assignTreeChecked.length > 0) {
        const newArr = []
        this.assignTreeChecked.forEach((item) => {
          this.checked(item, this.assignTreeData, newArr)
        })
        this.assignTreeChecked = newArr
      }
    },
    // 找出所有的回显数据
    checked(id, data, newArr) {
      data.forEach((item) => {
        if (item.menuId == id) {
          // 是不是末级
          if (item.children && item.children.length == 0) {
            newArr.push(item.menuId)
          }
        } else {
          if (item.children && item.children.length != 0) {
            this.checked(id, item.children, newArr)
          }
        }
      })
    },
    // 弹框确定
    onConfirm() {
      // 表单验证
      this.$refs.addRef.validate(async(valid) => {
        if (valid) {
          this.dialog.visible = false
          let res = null
          if (this.addModel.type == '0') {
            res = await addRoleApi(this.addModel)
          } else {
            res = await editRoleApi(this.addModel)
          }
          if (res && res.code == 200) {
            // 信息提示
            this.$message({ type: 'success', message: res.msg })
            // 刷新表格
            this.getList()
          }
        }
      })
    },
    // 弹框关闭
    onClose() {
      this.dialog.visible = false
    },
    // 获取列表
    async getList() {
      const res = await getListApi(this.listParm)
      if (res && res.code == 200) {
        console.log(res)
        // 设置表格数据
        this.tableData = res.data.records
        this.listParm.total = res.data.total
      }
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
      // 确定
      const confirm = await this.$myconfirm('确定删除该数据吗?')
      if (confirm) {
        const res = await deleteRoleApi({ roleId: row.roleId })
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
      this.dialog.visible = true
      this.dialog.title = '新增角色'
      // 清空表单数据
      this.$resetForm('addRef', this.addModel)
      // 把要编辑的数据放到表单数据对象
      this.$objCoppy(row, this.addModel)
      this.addModel.type = '1' // 编辑
    },
    // 新增按钮
    addBtn() {
      // 设置弹框属性
      this.dialog.visible = true
      this.dialog.title = '新增角色'
      // 清空表单数据
      this.$resetForm('addRef', this.addModel)
      //
      this.addModel.type = '0'
    },
    // 重置按钮
    resetBtn() {
      this.listParm.roleName = ''
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
