<template>
    <div class="container">
        <form class="group" @submit.prevent="submitForm">
            
            <div class="form-group">
                <div v-if="errors.email_proprietario" class="has-error">{{ errors.email_proprietario }}</div>
                <label><b>Email do Proprietário: </b></label>
                <input type="email" v-model="imovel.email_proprietario" class="form-control" placeholder="Email do Proprietário" required>
            </div>

            <div class="form-group">
                <div v-if="errors.rua" class="has-error">{{ errors.rua }}</div>
                <label><b>Rua: </b></label>
                <input type="text" v-model="imovel.rua" class="form-control" placeholder="Rua" required>
            </div>

            <div class="form-group">
                <div v-if="errors.numero" class="has-error">{{ errors.numero }}</div>
                <label><b>Número: </b></label>
                <input type="number" v-model="imovel.numero" min="1" class="form-control" placeholder="Número" required>
            </div>

            <div class="form-group">
                <div v-if="errors.complemento" class="has-error">{{ errors.complemento }}</div>
                <label>Complemento: </label>
                <input type="text" v-model="imovel.complemento" class="form-control" placeholder="Complemento">
            </div>

            <div class="form-group">
                <div v-if="errors.bairro" class="has-error">{{ errors.bairro }}</div>
                <label><b>Bairro: </b></label>
                <input type="text" v-model="imovel.bairro" class="form-control" placeholder="Bairro" required>
            </div>

            <div class="form-group">
                <div v-if="errors.cidade" class="has-error">{{ errors.cidade }}</div>
                <label><b>Cidade: </b></label>
                <input type="text" v-model="imovel.cidade" class="form-control" placeholder="Cidade" required>
            </div>

            <div class="form-group">
                <div v-if="errors.estado" class="has-error">{{ errors.estado }}</div>
                <label><b>Estado: </b></label>
                <select v-model="imovel.estado" class="form-control" required>
                    <option value="" style="color:red" disabled>SELECIONE</option>
                    <option :value="estado.uf" v-for="(estado, index) in estados.data" :key="index">{{ estado.uf }}</option>
                </select>
            </div>

            <div class="form-group">
                <label><b>Imagem: </b></label>
                <div v-if="imagePreview" class="text-center">
                    <img :src="imagePreview" class="imagePreview">
                    <button class="btn btn-danger" @click.prevent="removePreview">Remover</button>
                </div>
                <div v-else>
                    <input type="file" class="form-control" placeholder="Imagem" @change="onFileChange">
                </div>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary">Enviar</button>
            </div>
        </form>
    </div>
</template>

<script>
export default {
    data() {
        return {
            errors: {},
            upload: null,
            imagePreview: null
        }
    },

    created () {
        this.$store.dispatch('loadEstados').errors
    },

    computed: {
        estados () {
            return this.$store.state.estados.items
        },
    },
    
    props: {
        update: {
            require: false,
            type: Boolean,
            default: false,
        },
        imovel: {
            require: false,
            type: Object,
        }
    },

    methods: {
        submitForm() {
            let action = this.update ? 'updateImovels' : 'storeImovels'

            const formData = new FormData()

            if(this.upload != null)
                formData.append('image', this.upload)
            
            formData.append('id', this.imovel.id)
            formData.append('email_proprietario', this.imovel.email_proprietario)
            formData.append('rua', this.imovel.rua)
            formData.append('numero', this.imovel.numero)
            formData.append('complemento', this.imovel.complemento)
            formData.append('bairro', this.imovel.bairro)
            formData.append('cidade', this.imovel.cidade)
            formData.append('estado', this.imovel.estado)

            this.$store.dispatch(action, formData)

                .then(() => {
                    let message = this.update ? 'ALTERADO' : 'CADASTRADO'
                    this.$snotify.success('IMÓVEL '+message+' COM SUCESSO !')
                    this.reset()
                    this.$emit('success')
                })
                .catch(error => {
                    this.$snotify.error('EXISTEM ERROS DE CADASTRADO, IMÓVEL NÃO CADASTRADO !'),
                    this.errors = error.data
                })
        },

        reset() {
            this.errors         = {},
            this.imagePreview   = null,
            this.upload         = null
        },

        onFileChange(e) {
            let files = e.target.files || e.dataTransfer.files

            if(!files.length)
                return

            this.upload = files[0]

            this.previewImage(files[0])
        },

        previewImage(file) {
            let reader = new FileReader()

            reader.onload = (e) => {
                this.imagePreview = e.target.result
            }
            reader.readAsDataURL(file)
        },

        removePreview() {
            this.imagePreview   = null
            this.upload         = null
        }
    }
}
</script>

<style scoped>
.has-error {color: red;}
.has-error input {border: 1px solid red;}
.imagePreview {
    max-width: 100px;
}
</style>