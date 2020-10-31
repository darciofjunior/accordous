<template>

    <div class="container">
        <center>
            <h1>Sistema Administrativo <b>ACCORDOUS</b></h1>
            <img src="imgs/casa.jpg"/>
            
            <br/><br/>
            <ul class="nav bg-dark">
                <li class="nav-item">
                    <router-link :to="{name: 'imovels'}" class="nav-link">Imovels ({{ totalImovels }})</router-link>
                </li>
                <li class="nav-item">
                    <router-link :to="{name: 'contratos'}" class="nav-link">Contratos ({{ totalContratos }})</router-link>
                </li>
            </ul>
        </center>

        <div class="container">
            <router-view></router-view>
        </div>
    
    </div>

</template>

<script>
export default {
    computed :{
        totalImovels() {
            if(this.$store.state.imovels.items.data != undefined) {
                return this.$store.state.imovels.items.total
            }else {
                return 0
            }
        },

        totalContratos() {
            if(this.$store.state.contratos.items.data != undefined) {
                return this.$store.state.contratos.items.total
            }else {
                return 0
            }
        }
    }
}
</script>

<style scoped>

</style>