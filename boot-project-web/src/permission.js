import router from './router'
import store from './store'
import { Message } from 'element-ui'
import NProgress from 'nprogress' // progress bar
import 'nprogress/nprogress.css' // progress bar style
import { getToken } from '@/utils/auth' // get token from cookie
import getPageTitle from '@/utils/get-page-title'

NProgress.configure({ showSpinner: false }) // NProgress Configuration

const whiteList = ['/login'] // no redirect whitelist
// 全局守卫路由
router.beforeEach(async(to, from, next) => {
  // start progress bar
  NProgress.start()

  // set page title
  document.title = getPageTitle(to.meta.title)

  // determine whether the user has logged in
  // 从Cookies里面获取token
  const hasToken = getToken()
  // 判断token是否存在
  if (hasToken) {
    // 判断是否是登录，是，直接跳到首页
    if (to.path === '/login') {
      // if is logged in, redirect to the home page
      next({ path: '/' })
      NProgress.done()
    } else {
      // 从vuex里面获取用户的所有权限
      // determine whether the user has obtained his permission roles through getInfo
      const hasRoles = store.getters.roles && store.getters.roles.length > 0
      if (hasRoles) {
        // 有权限，直接放行
        next()
      } else {
        try {
          // get user info
          // note: roles must be a object array! such as: ['admin'] or ,['developer','editor']
          // 从后端服务器获取权限信息，vuex里面的user模块的getInfo方法
          const { roles } = await store.dispatch('user/getInfo')

          // generate accessible routes map based on roles
          // 动态生成菜单和路由
          const accessRoutes = await store.dispatch('permission/generateRoutes', roles)
          console.log('生成动态路由')
          console.log(accessRoutes)
          const obj = { path: '*', redirect: '/404', hidden: true }
          accessRoutes.push(obj)
          // dynamically add accessible routes
          // 动态生成路由
          router.addRoutes(accessRoutes)

          // hack method to ensure that addRoutes is complete
          // set the replace: true, so the navigation will not leave a history record
          next({ ...to, replace: true })
        } catch (error) {
          console.log('进入异常')
          // remove token and go to login page to re-login
          await store.dispatch('user/resetToken')
          // Message.error(error || 'Has Error')
          next(`/login?redirect=${to.path}`)
          NProgress.done()
        }
      }
    }
  } else {
    /* has no token*/
    // 判断请求是否在白名单中
    if (whiteList.indexOf(to.path) !== -1) {
      // in the free login whitelist, go directly
      // 如果在白名单，直接放行
      next()
    } else {
      // 跳转到登录
      // other pages that do not have permission to access are redirected to the login page.
      next(`/login?redirect=${to.path}`)
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  // finish progress bar
  NProgress.done()
})
