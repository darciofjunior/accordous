const CONFIGS = {
    headers: {
        'content-type' : 'multipart/form-data',
    }
}

export default {
    state: {
        items: {
            data: []
        }
    },

    mutations: {
        LOAD_IMOVEIS(state, imovels) {
            state.items = imovels
        }
    },

    actions: {
        loadImovels (context, params) {
            context.commit('PRELOADER', true)

            axios.get('api/imovels', {params})
                .then(response => context.commit('LOAD_IMOVEIS', response.data))
                .catch(error => console.log(error))
                .finally(() => context.commit('PRELOADER', false))
        },

        loadImovel (context, id) {
            context.commit('PRELOADER', true)

            return new Promise((resolve, reject) => {
                axios.get(`api/imovels/${id}`)
                .then(response => resolve(response.data))
                .catch(error => reject())
                .finally(() => context.commit('PRELOADER', false))
            })
        },

        storeImovels(context, formData) {
            context.commit('PRELOADER', true)

            return new Promise((resolve, reject) => {
                axios.post('api/imovels', formData, CONFIGS)
                .then(response => resolve())
                .catch(error => {
                    context.commit('PRELOADER', false)
                    reject(error.response)
                })
            })
        },

        updateImovels(context, formData) {
            context.commit('PRELOADER', true)

            formData.append('_method', 'PUT')

            return new Promise((resolve, reject) => {
                axios.post(`api/imovels/${formData.get('id')}`, formData)
                .then(response => resolve())
                .catch(error => {
                    context.commit('PRELOADER', false)
                    reject(error.response)
                })
            })
        },

        destroyImovels(context, id) {
            context.commit('PRELOADER', true)

            return new Promise((resolve, reject) => {
                axios.delete(`api/imovels/${id}`)
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