import { createRouter, createWebHashHistory } from 'vue-router'
import Home from '../views/Home.vue'
import CreateAccout from "../views/CreateAccout";

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/create-account',
    name: 'Create Account',
    component: CreateAccout
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
