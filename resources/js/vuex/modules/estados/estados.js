export default {
    state: {
        items: {
            data: []
        }
    },

    mutations: {
        LOAD_ESTADOS(state, estados) {
            state.items = estados
        }
    },

    actions: {
        loadEstados (context) {
            context.commit('PRELOADER', true)

            axios.get('api/estados')
                .then(response => context.commit('LOAD_ESTADOS', response))
                .catch(error => console.log(error))
                .finally(() => context.commit('PRELOADER', false))
        }
    }
}
