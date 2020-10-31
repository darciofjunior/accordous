<template>
    <div>
        <center>
            <h5>
                <b>Selecione um Imóvel Cadastrado</b>
            </h5>
            <searchImovelsComponent
                @search="searchImovels"></searchImovelsComponent>
            <br/>
        </center>

        <table class="table table-dark">
            <thead>
                <tr align="center">
                    <th>Email do Proprietário</th>
                    <th>Endereço</th>
                    <th>Imagem</th>
                </tr>
            </thead>
            <tbody class="table table-light">
                <tr v-for="(imovel, index) in imovels.data" :key="index">
                    <td>
                        <div class="form-check">
                            <input type="radio" name="opt_imovel_id" :id="index" v-if="imovel.id == contrato.imovel_id" checked="checked" @click="imovelId(imovel.id)" required>
                            <input type="radio" name="opt_imovel_id" :id="index" v-else @click="imovelId(imovel.id)" required>
                            &nbsp;
                            <label :for="index">
                                <font color="red">Cód: {{ imovel.id }}</font>
                                |&nbsp;{{ imovel.email_proprietario }}
                            </label>
                        </div>
                    </td>
                    <td>
                        {{ imovel.rua }}, {{ imovel.numero }}, {{ imovel.cidade }}, {{ imovel.estado }}
                    </td>
                    <td>
                        <img v-if="imovel.image" :src="[`/storage/imovels/${imovel.image}`]" :alt="imovel.image" class="img-list">
                    </td>
                </tr>
            </tbody>
        </table>

        <div v-if="imovels.data">
            <paginacaoComponent
                :pagination="imovels"
                :offset="4"
                @paginate="loadImovels">
            </paginacaoComponent>
        </div>

     </div>
</template>

<script>

import SearchImovelsComponent from './SearchImovelsComponent'
import PaginacaoComponent from './../PaginacaoComponent'

export default {
    created () {
        this.loadImovels(1)
    },

    props: {
        contrato: {
            require: true,
            type: Object,
        },
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

        imovelId(id) {
            this.contrato.imovel_id = id
        }
    },

    components: {
        SearchImovelsComponent,
        PaginacaoComponent,
    }
}
</script>

<style scoped>
.img-list {max-width: 50px;}
</style>