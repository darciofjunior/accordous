<template>
    <div>
        <form class="form form-inline" @submit.prevent="searchContratos">
            <input type="text" v-model="filter" placeholder="Pesquisar:" class="form-control mr-sm-2">
            <button type="submit" class="btn btn-outline-success">Pesquisar</button>
        </form>
    </div>
</template>

<script>
export default {
    data() {
        return {
            filter: ''
        }
    },
    methods: {
         searchContratos() {
             this.$emit('search', this.filter)
         }
    }
}
</script>