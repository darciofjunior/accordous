import Vue from 'vue' 
import VueRouter from 'vue-router'

import MenuComponent from '../components/MenuComponent'

import ImovelsComponent from '../components/imovels/ImovelsComponent'
import ContratosComponent from '../components/contratos/ContratosComponent'

Vue.use(VueRouter)

const routes = [
    {
        path: '/', 
        component: MenuComponent,
        children: [
            {path: '/imovels', component: ImovelsComponent, name: 'imovels'},
            {path: '/contratos', component: ContratosComponent, name: 'contratos'},
        ],
    },
]

const router = new VueRouter({
    routes
})

export default router