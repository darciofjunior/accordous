export default {
    state: {
        items: {
            data: []
        }
    },

    mutations: {
        LOAD_CONTRATOS(state, contratos) {
            state.items = contratos
        }
    },

    actions: {
        loadContratos (context, params) {
            context.commit('PRELOADER', true)

            axios.get('api/contratos', {params})
                .then(response => context.commit('LOAD_CONTRATOS', response.data))
                .catch(error => console.log(error))
                .finally(() => context.commit('PRELOADER', false))
        },

        loadContrato (context, id) {
            context.commit('PRELOADER', true)

            return new Promise((resolve, reject) => {
                axios.get(`api/contratos/${id}`)
                .then(response => resolve(response.data))
                .catch(error => reject())
                .finally(() => context.commit('PRELOADER', false))
            })
        },

        storeContratos(context, params) {
            context.commit('PRELOADER', true)

            return new Promise((resolve, reject) => {
                axios.post('api/contratos', params)
                .then(response => resolve())
                .catch(error => {
                    context.commit('PRELOADER', false)
                    reject(error.response)
                })
            })
        },

        updateContratos(context, params) {
            context.commit('PRELOADER', true)

            return new Promise((resolve, reject) => {
                axios.put(`api/contratos/${params.id}`, params)
                .then(response => resolve())
                .catch(error => {
                    context.commit('PRELOADER', false)
                    reject(error.response)
                })
            })
        },

        destroyContratos(context, id) {
            context.commit('PRELOADER', true)

            return new Promise((resolve, reject) => {
                axios.delete(`api/contratos/${id}`)
                .then(response => resolve())
                .catch(error => {
                    reject()
                    context.commit('PRELOADER', false)
                })
            })
        }
    },

    getters: {
        
    }
}