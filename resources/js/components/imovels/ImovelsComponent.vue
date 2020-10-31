<template>
    <div>
        <center>
            <h2>
                Imóvel(is) Cadastrado(s)
                <button class="btn btn-success" @click.prevent="createImovels">
                    Cadastrar
                </button>
            </h2>
            <searchImovelsComponent
                @search="searchImovels"></searchImovelsComponent>
            <br/>
        </center>

        <div class="row">
            <div class="col">
                <vodal
                    :show="showModal"
                    animation="zoom"
                    :width="1000"
                    :height="800"
                    @hide="hideModal">
                    
                    <formImovelsComponent
                        :imovel="imovel"
                        :update="update"
                        @success="success">
                    </formImovelsComponent>

                </vodal>
            </div>
        </div>

        <table class="table table-dark">
            <thead>
                <tr align="center">
                    <th>Email do Proprietário</th>
                    <th>Endereço</th>
                    <th>Imagem</th>
                    <th>Status</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody class="table table-light">
                <tr v-for="(imovel, index) in imovels.data" :key="index">
                    <td>{{ imovel.email_proprietario }}</td>
                    <td>
                        {{ imovel.rua }}, {{ imovel.numero }}, {{ imovel.cidade }}, {{ imovel.estado }}
                    </td>
                    <td>
                        <div v-if="imovel.image">
                            <img :src="[`/storage/imovels/${imovel.image}`]" :alt="imovel.image" class="img-list">
                        </div>
                    </td>
                    <td>{{ imovel.status }}</td>
                    <td>
                        <a href="#" @click.prevent="editarImovels(imovel.id)" class="btn btn-info">
                            Editar
                        </a>
                        <a href="#" @click.prevent="confirmarExcluirImovels(imovel.id)" class="btn btn-danger">
                            Deletar
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>

        <div v-if="imovels.data">
            <paginacaoComponent
                :pagination="imovels"
                :offset="2"
                @paginate="loadImovels">
            </paginacaoComponent>
        </div>

     </div>
</template>

<script>

import FormImovelsComponent from './FormImovelsComponent'
import SearchImovelsComponent from './SearchImovelsComponent'
import PaginacaoComponent from './../PaginacaoComponent'
import Vodal from 'vodal'

export default {
    data() {
        return {
            imovel: {
                id: '',
                email_proprietario: '',
                rua: '',
                numero: '',
                complemento: '',
                bairro: '',
                estado: '',
                image: '',
                status: '',
            },
            update:         false,
            showModal:      false,
            search:         '',
            upload:         null,
            imagePreview:   null,
            errors: {}
        }
    },

    created () {
        this.loadImovels(1)
    },

    computed: {
        imovels () {
            return this.$store.state.imovels.items
        },
        params() {
            return {
                page: this.imovels.current_page,
                filter: this.search,
            }
        }
    },

    methods: {
        loadImovels(page) {
            this.$store.dispatch('loadImovels', {...this.params, page})
        },

        searchImovels(filter) {
            this.search = filter
            this.loadImovels(1)
        },

        createImovels() {
            this.update         = false,
            this.showModal      = true,
            this.reset()
        },

        editarImovels(id) {
            this.reset()

            this.$store.dispatch('loadImovel', id)
                        .then(response => {
                            this.imovel     = response
                            this.showModal  = true
                            this.update     = true
                        })
                        .catch(() => {
                            this.$snotify.error('ERRO AO CARREGAR O IMÓVEL !')
                        })
        },

        confirmarExcluirImovels(id) {
            this.$snotify.error(`DESEJA REALMENTE DELETAR ESSE IMÓVEL ?`, 'DELETAR IMOVEL', {
                timeout:            1000,
                showProgressBar:    true,
                closeOnClik:        true,
                pauseOnHouve:       true,
                buttons: [
                    {text: 'NÃO'},
                    {text: 'SIM', action: () => this.excluirImovels(id)}
                ]
            })
        },

        excluirImovels(id) {
            this.$store.dispatch('destroyImovels', id)
                        .then(() => {
                            this.$snotify.success('IMÓVEL DELETADO COM SUCESSO !')
                            this.$store.dispatch('loadImovels')
                        })
                        .catch(() => this.$snotify.error('ESSE IMÓVEL NÃO PODE SER DELETADO !'))
        },

        hideModal() {
            this.showModal      = false
            this.reset()
        },

        success() {
            this.hideModal()
            this.$store.dispatch('loadImovels')
        },

        reset() {
            this.imovel = {
                id: '',
                email_proprietario: '',
                rua: '',
                numero: '',
                complemento: '',
                bairro: '',
                estado: '',
                image: '',
                status: '',
            }
            //this.upload         = null,
            //this.imagePreview   = null,
            //this.errors         = {}
        }
    },

    components: {
        FormImovelsComponent,
        SearchImovelsComponent,
        PaginacaoComponent,
        Vodal,
    }
}
</script>

<style scoped>
.img-list {max-width: 100px;}
</style>