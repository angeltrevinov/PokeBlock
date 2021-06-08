import { createRouter, createWebHashHistory } from 'vue-router'
import Home from '../views/Home.vue'
import CreateAccout from "../views/CreateAccout";
import CheckPokemons from "../views/CheckPokemons";

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
  },
  {
    path: '/my-pokemons',
    name: 'My Pokemons',
    component: CheckPokemons
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
