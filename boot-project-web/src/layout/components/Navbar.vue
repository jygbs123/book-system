<template>
  <div class="navbar">
    <hamburger
      :is-active="sidebar.opened"
      class="hamburger-container"
      @toggleClick="toggleSideBar"
    />

    <breadcrumb class="breadcrumb-container"/>

    <div class="right-menu">
      <el-dropdown class="avatar-container" trigger="click">
        <div class="avatar-wrapper">
          <img src="../../assets/images/111.png" class="user-avatar"/>
          <i class="el-icon-caret-bottom"/>
        </div>
        <el-dropdown-menu slot="dropdown" class="user-dropdown">
          <router-link to="/">
            <el-dropdown-item> 首页</el-dropdown-item>
          </router-link>
          <el-dropdown-item divided @click.native="updatePwd">
            <span style="display: block">密码修改</span>
          </el-dropdown-item>
          <el-dropdown-item divided @click.native="logout">
            <span style="display: block">退出登录</span>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
    <!-- 修改密码弹框 -->
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
          :model="addModel"
          ref="addModel"
          :rules="rules"
          label-width="80px"
          :inline="true"
          size="small"
        >
          <el-form-item prop="oldPassword" label="原密码">
            <el-input v-model="addModel.oldPassword"></el-input>
          </el-form-item>
          <el-form-item prop="password" label="新密码">
            <el-input v-model="addModel.password"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </div>
</template>

<script>
import SysDialog from '@/components/dialog/SysDialog.vue'
import { mapGetters } from 'vuex'
import Breadcrumb from '@/components/Breadcrumb'
import Hamburger from '@/components/Hamburger'
import { updatePasswordApi } from '@/api/user'
import { getUserId } from '@/utils/auth'

export default {
  components: {
    Breadcrumb,
    Hamburger,
    SysDialog
  },
  data() {
    return {
      rules: {
        oldPassword: [
          { trigger: 'blur', required: true, message: '原密码不能为空!' }
        ],
        password: [
          { trigger: 'blur', required: true, message: '新密码不能为空!' }
        ]
      },
      addModel: {
        userId: '',
        oldPassword: '',
        password: '',
        learnNum: ''
      },
      dialog: {
        title: '密码修改',
        height: 150,
        width: 650,
        visible: false
      }
    }
  },
  computed: {
    ...mapGetters(['sidebar', 'avatar'])
  },
  methods: {
    onConfirm() {
      this.$refs.addModel.validate(async(valid) => {
        if (valid) {
          this.addModel.userId = getUserId()
          let res = await updatePasswordApi(this.addModel)
          if (res && res.code == 200) {
            this.$message.success(res.msg)
            this.dialog.visible = false
          }
        }
      })
    },
    onClose() {
      this.dialog.visible = false
    },
    updatePwd() {
      this.dialog.visible = true
    },
    toggleSideBar() {
      this.$store.dispatch('app/toggleSideBar')
    },
    async logout() {
      await this.$store.dispatch('user/logout')
      this.$router.push(`/login?redirect=${this.$route.fullPath}`)
    }
  }
}
</script>

<style lang="scss" scoped>
.navbar {
  height: 50px;
  overflow: hidden;
  position: relative;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);

  .hamburger-container {
    line-height: 46px;
    height: 100%;
    float: left;
    cursor: pointer;
    transition: background 0.3s;
    -webkit-tap-highlight-color: transparent;

    &:hover {
      background: rgba(0, 0, 0, 0.025);
    }
  }

  .breadcrumb-container {
    float: left;
  }

  .right-menu {
    float: right;
    height: 100%;
    line-height: 50px;

    &:focus {
      outline: none;
    }

    .right-menu-item {
      display: inline-block;
      padding: 0 8px;
      height: 100%;
      font-size: 18px;
      color: #5a5e66;
      vertical-align: text-bottom;

      &.hover-effect {
        cursor: pointer;
        transition: background 0.3s;

        &:hover {
          background: rgba(0, 0, 0, 0.025);
        }
      }
    }

    .avatar-container {
      margin-right: 30px;

      .avatar-wrapper {
        margin-top: 5px;
        position: relative;

        .user-avatar {
          cursor: pointer;
          width: 40px;
          height: 40px;
          border-radius: 10px;
        }

        .el-icon-caret-bottom {
          cursor: pointer;
          position: absolute;
          right: -20px;
          top: 25px;
          font-size: 12px;
        }
      }
    }
  }
}
</style>
