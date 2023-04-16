import { createRouter, createWebHashHistory } from 'vue-router'
import MandateView from '../components/MandateView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: MandateView
  },
  {
    path: '/account',
    name: 'account',
    component: () => import('../components/AccountView.vue')
  },
  {
    path: '/board',
    name: 'board',
    component: () => import( '../components/BoardView.vue')
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
