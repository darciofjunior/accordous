import Vue from 'vue'
import Vuex from 'vuex'

import Contratos from './modules/contratos/contratos'
import Estados from './modules/estados/estados'
import Imovels from './modules/imovels/imovels'
import Preloader from './modules/preloader/preloader'

Vue.use(Vuex)

const store = new Vuex.Store({
    modules: {
        contratos: Contratos,
        estados: Estados,
        imovels: Imovels, 
        preloader: Preloader
    }
})

export default store