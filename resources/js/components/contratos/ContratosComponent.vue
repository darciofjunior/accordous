<template>
    <div>
        <center>
            <h2>
                Contratos(s) Cadastrado(s)
                <button class="btn btn-success" @click.prevent="createContratos">
                    Cadastrar
                </button>
            </h2>
            <searchContratosComponent
                @search="searchContratos"></searchContratosComponent>
            <br/>
        </center>

        <div class="row">
            <div class="col">
                <vodal
                    :show="showModal"
                    animation="zoom"
                    :width="1000"
                    :height="860"
                    @hide="hideModal">
                    
                    <formContratosComponent
                        :contrato="contrato"
                        :update="update"
                        @success="success">
                    </formContratosComponent>

                </vodal>
            </div>
        </div>

        <table class="table table-dark">
            <thead>
                <tr align="center">
                    <th>Email do Contratante</th>
                    <th>Nome do Contratante</th>
                    <th>Tipo de Pessoa</th>
                    <th>CPF / CNPJ</th>
                    <th>Dados do Imóvel</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody class="table table-light">
                <tr v-for="(contrato, index) in contratos.data" :key="index">
                    <td>{{ contrato.email_contratante }}</td>
                    <td>{{ contrato.nome_contratante }}</td>
                    <td>{{ contrato.tipo_pessoa }}</td>
                    <td>{{ contrato.cpf_cnpj }}</td>
                    <td>
                        <b>Proprietário: </b>{{ contrato.imovel.email_proprietario }}<br/>
                        {{ contrato.imovel.rua }}, {{ contrato.imovel.numero }}, {{ contrato.imovel.cidade }}, {{ contrato.imovel.estado }}
                    </td>
                    <td>
                        <a href="#" @click.prevent="editarContratos(contrato.id)" class="btn btn-info">
                            Editar
                        </a>
                        <a href="#" @click.prevent="confirmarExcluirContratos(contrato.id)" class="btn btn-danger">
                            Deletar
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>

        <div v-if="contratos.data">
            <paginacaoComponent
                :pagination="contratos"
                :offset="2"
                @paginate="loadContratos">

            </paginacaoComponent>
        </div>

     </div>
</template>

<script>

import FormContratosComponent from './FormContratosComponent'
import SearchContratosComponent from './SearchContratosComponent'
import PaginacaoComponent from './../PaginacaoComponent'
import Vodal from 'vodal'

export default {
    data() {
        return {
            contrato: {
                id: '',
                email_contratante: '',
                nome_contratante: '',
                tipo_pessoa: '',
                cpf_cnpj: '',
                imovel_id: '',
            },
            update: false,
            showModal: false,
            search: '',
            errors: {}
        }
    },

    created () {
        this.loadContratos(1)
    },

    computed: {
        contratos () {
            return this.$store.state.contratos.items
        },
        params() {
            return {
                page: this.contratos.current_page,
                filter: this.search,
            }
        }
    },

    methods: {
        loadContratos(page) {
            this.$store.dispatch('loadContratos', {...this.params, page})
        },

        searchContratos(filter) {
            this.search = filter
            this.loadContratos(1)
        },

        createContratos() {
            this.update     = false,
            this.showModal  = true,
            this.reset()
        },

        editarContratos(id) {
            this.reset()

            this.$store.dispatch('loadContrato', id)
                        .then(response => {
                            this.contrato   = response
                            this.showModal  = true
                            this.update     = true
                        })
                        .catch(() => {
                            this.$snotify.error('ERRO AO CARREGAR O CONTRATO !')
                        })
        },

        confirmarExcluirContratos(id) {
            this.$snotify.error(`DESEJA REALMENTE DELETAR ESSE CONTRATO ?`, 'DELETAR CONTRATO', {
                timeout:            1000,
                showProgressBar:    true,
                closeOnClik:        true,
                pauseOnHouve:       true,
                buttons: [
                    {text: 'NÃO'},
                    {text: 'SIM', action: () => this.excluirContratos(id)}
                ]
            })
        },

        excluirContratos(id) {
            this.$store.dispatch('destroyContratos', id)
                        .then(() => {
                            this.$snotify.success('CONTRATO DELETADO COM SUCESSO !')
                            this.$store.dispatch('loadContratos')
                        })
                        .catch(() => this.$snotify.error('ESSE CONTRATO NÃO PODE SER DELETADO !'))
        },

        hideModal() {
            this.showModal = false
        },

        success() {
            this.hideModal()
            this.$store.dispatch('loadContratos')
        },

        reset() {
            this.contrato = {
                id: '',
                email_contratante: '',
                nome_contratante: '',
                tipo_pessoa: '',
                cpf_cnpj: '',
                imovel_id: ''
            }
        },
    },

    components: {
        FormContratosComponent,
        SearchContratosComponent,
        PaginacaoComponent,
        Vodal,
    }
}
</script>

<style scoped>
.img-list {max-width: 100px;}
</style>