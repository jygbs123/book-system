<template>
  <el-main>
    <el-form size="small">
      <el-form-item>
        <el-button
          v-permission="['sys:menu:add']"
          type="primary"
          icon="el-icon-plus"
          @click="addBtn"
        >新增
        </el-button>
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table
      :height="tableHeight"
      :data="tableData"
      border
      stripe
      row-key="menuId"
      default-expand-all
      :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
    >
      <el-table-column prop="title" label="菜单名称"/>
      <el-table-column prop="title" label="菜单图标">
        <template slot-scope="scope">
          <i :class="scope.row.icon"/>
        </template>
      </el-table-column>
      <el-table-column prop="name" label="菜单类型">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.type == '0'">目录</el-tag>
          <el-tag v-if="scope.row.type == '1'" type="success">菜单</el-tag>
          <el-tag v-if="scope.row.type == '2'" type="danger">按钮</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="name" label="路由名称"/>
      <el-table-column prop="path" label="路由地址"/>
      <el-table-column prop="code" label="权限字段"/>
      <el-table-column label="操作" align="center" width="180">
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:menu:edit']"
            type="primary"
            icon="el-icon-edit"
            size="small"
            @click="editBtn(scope.row)"
          >编辑
          </el-button>
          <el-button
            v-permission="['sys:menu:delete']"
            type="danger"
            icon="el-icon-delete"
            size="small"
            @click="deleteBtn(scope.row)"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 新增、编辑 -->
    <sys-dialog
      :title="dialog.title"
      :height="dialog.height"
      :width="dialog.width"
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
          style="margin-right: 8px"
        >
          <el-row>
            <el-col :span="24" :offset="0">
              <el-form-item prop="type" label="菜单类型">
                <el-radio-group v-model="addModel.type">
                  <el-radio :label="'0'">目录</el-radio>
                  <el-radio :label="'1'">菜单</el-radio>
                  <el-radio :label="'2'">按钮</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="parentName" label="上级菜单">
                <!-- <el-input type="hidden" v-model="addModel.parentId"></el-input> -->
                <el-input
                  v-model="addModel.parentName"
                  @click.native="selectParent"
                />
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="title" label="菜单名称">
                <el-input v-model="addModel.title"/>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col v-if="addModel.type != '2'" :span="12" :offset="0">
              <el-form-item label="菜单图标">
                <el-input v-model="addModel.icon"/>
              </el-form-item>
            </el-col>
            <el-col v-if="addModel.type == '1'" :span="12" :offset="0">
              <el-form-item prop="name" label="路由名称">
                <el-input v-model="addModel.name"/>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row v-if="addModel.type == '1'">
            <el-col :span="12" :offset="0">
              <el-form-item prop="path" label="路由地址">
                <el-input v-model="addModel.path"/>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="url" label="组件路径">
                <el-input v-model="addModel.url"/>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="权限字段">
                <el-input v-model="addModel.code"/>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="菜单序号">
                <el-input v-model="addModel.orderNum"/>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </sys-dialog>
    <!-- 上级菜单 -->
    <sys-dialog
      :title="parentDialog.title"
      :width="parentDialog.width"
      :height="parentDialog.height"
      :visible="parentDialog.visible"
      @onClose="parentClose"
      @onConfirm="parentConfirm"
    >
      <div slot="content">
        <el-tree
          ref="parentTree"
          :data="treeData"
          node-key="menuId"
          :props="defaultProps"
          empty-text="暂无数据"
          :show-checkbox="false"
          :highlight-current="true"
          default-expand-all
          :expand-on-click-node="false"
          @node-click="handleNodeClick"
        >
          <div slot-scope="{ node, data }">
            <!-- 如果没有下级，显示文档图标 -->
            <span v-if="data.children.length == 0">
              <i style="margin-left: 3px" class="el-icon-document"/>
            </span>
            <!-- 有下级，判断是否展开 -->
            <span v-else @click.stop="openBtn(data)">
              <i
                v-if="data.open"
                style="margin-left: 3px"
                class="el-icon-plus"
              />
              <i v-else style="margin-left: 3px" class="el-icon-minus"/>
            </span>
            <span style="margin-left: 3px">{{ node.label }}</span>
          </div>
        </el-tree>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import SysDialog from '@/components/dialog/SysDialog.vue'
import {
  getMenuListApi,
  getParentMenuListApi,
  addMenuApi,
  editMenuApi,
  deleteMenuApi
} from '@/api/menu'

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
      // 上级菜单数据
      treeData: [],
      // 上级弹框属性
      parentDialog: {
        width: 300,
        title: '选择上级菜单',
        height: 450,
        visible: false
      },
      // 表单验证规则
      rules: {
        type: [
          {
            trigger: 'blur',
            required: true,
            message: '请选择菜单类型'
          }
        ],
        parentName: [
          {
            trigger: 'blur',
            required: true,
            message: '请选择上级菜单'
          }
        ],
        title: [
          {
            trigger: 'blur',
            required: true,
            message: '请填写菜单名称'
          }
        ],
        name: [
          {
            trigger: 'blur',
            required: true,
            message: '请填写路由名称'
          }
        ],
        path: [
          {
            trigger: 'blur',
            required: true,
            message: '请填写路由地址'
          }
        ],
        url: [
          {
            trigger: 'blur',
            required: true,
            message: '请填写组件路径'
          }
        ]
      },
      // 表单数据
      addModel: {
        editType: '', // 0:新增 1：编辑
        menuId: '',
        type: '',
        parentId: '',
        title: '',
        code: '',
        name: '',
        path: '',
        url: '',
        icon: '',
        parentName: '',
        orderNum: ''
      },
      // 弹框属性
      dialog: {
        width: 650,
        title: '',
        height: 280,
        visible: false
      },
      // 表格高度
      tableHeight: 0,
      // 表格数据
      tableData: [],
      // 树选择的数据
      selectNode: {
        id: '',
        title: ''
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
    // 编辑
    editBtn(row) {
      // 设置弹框属性
      this.dialog.title = '编辑菜单'
      this.dialog.visible = true
      // 清空表单
      this.$resetForm('addRef', this.addModel)
      // 把要编辑的数据放到表单绑定的数据里面,回显
      this.$objCoppy(row, this.addModel)
      this.addModel.editType = '1'
    },
    // 删除按钮
    async deleteBtn(row) {
      const confirm = await this.$myconfirm('确定删除该数据吗?')
      if (confirm) {
        const res = await deleteMenuApi({ menuId: row.menuId })
        if (res && res.code == 200) {
          this.$message({ type: 'success', message: res.msg })
          this.getList()
        }
      }
    },
    // 上级部门节点加号和减号点击事件
    openBtn(data) {
      data.open = !data.open
      this.$refs.parentTree.store.nodesMap[data.menuId].expanded = !data.open
    },
    // 上级菜单树点击事件
    handleNodeClick(node) {
      console.log(node)
      this.selectNode.id = node.menuId
      this.selectNode.title = node.title
    },
    // 上级菜单确定事件
    parentConfirm() {
      this.addModel.parentId = this.selectNode.id
      this.addModel.parentName = this.selectNode.title
      this.parentDialog.visible = false
      console.log(this.addModel)
    },
    // 上级菜单关闭事件
    parentClose() {
      this.parentDialog.visible = false
    },
    // 选择上级菜单事件
    async selectParent() {
      // 查询上级菜单树数据
      const res = await getParentMenuListApi()
      if (res && res.code == 200) {
        this.treeData = res.data
      }
      this.parentDialog.visible = true
    },
    // 新增按钮
    addBtn() {
      // 设置弹框属性
      this.dialog.title = '新增菜单'
      this.dialog.visible = true
      // 清空表单
      this.$resetForm('addRef', this.addModel)
      this.addModel.editType = '0'
    },
    // 弹框确定
    onConfirm() {
      this.$refs.addRef.validate(async(valid) => {
        if (valid) {
          let res = null
          if (this.addModel.editType == '0') {
            res = await addMenuApi(this.addModel)
          } else {
            res = await editMenuApi(this.addModel)
          }
          if (res && res.code == 200) {
            this.$message({ type: 'success', message: res.msg })
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
    async getList() {
      const res = await getMenuListApi()
      if (res && res.code == 200) {
        console.log(res)
        this.tableData = res.data
      }
    }
  }
}
</script>

<style lang="scss" scoped>
::v-deep .el-tree {
  // 将每一行的设置为相对定位 方便后面before after 使用绝对定位来固定位置
  .el-tree-node {
    position: relative;
    padding-left: 10px;
  }

  // 子集像右偏移 给数线留出距离
  .el-tree-node__children {
    padding-left: 20px;
  }

  //这是竖线
  .el-tree-node :last-child:before {
    height: 40px;
  }

  .el-tree > .el-tree-node:before {
    border-left: none;
  }

  .el-tree > .el-tree-node:after {
    border-top: none;
  }

  //这自定义的线 的公共部分
  .el-tree-node:before,
  .el-tree-node:after {
    content: "";
    left: -4px;
    position: absolute;
    right: auto;
    border-width: 1px;
  }

  .tree :first-child .el-tree-node:before {
    border-left: none;
  }

  // 竖线
  .el-tree-node:before {
    border-left: 1px dotted #d9d9d9;
    bottom: 0px;
    height: 100%;
    top: -25px;
    width: 1px;
  }

  //横线
  .el-tree-node:after {
    border-top: 1px dotted #d9d9d9;
    height: 20px;
    top: 14px;
    width: 24px;
  }

  .el-tree-node__expand-icon.is-leaf {
    width: 8px;
  }

  //去掉elementui自带的展开按钮  一个向下的按钮,打开时向右
  .el-tree-node__content > .el-tree-node__expand-icon {
    display: none;
  }

  //每一行的高度
  .el-tree-node__content {
    line-height: 30px;
    height: 30px;
    padding-left: 10px !important;
  }
}

//去掉最上级的before  after 即是去电最上层的连接线
::v-deep .el-tree > div {
  &::before {
    display: none;
  }

  &::after {
    display: none;
  }
}
</style>
