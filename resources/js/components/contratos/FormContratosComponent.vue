<template>
    <div class="container">
        <form class="group" @submit.prevent="submitForm">
            
            <div class="form-group">
                <div v-if="errors.email_contratante" class="has-error">{{ errors.email_contratante }}</div>
                <label><b>Email do Contratante: </b></label>
                <input type="email" v-model="contrato.email_contratante" class="form-control" placeholder="Email do Contratante" required>
            </div>

            <div class="form-group">
                <div v-if="errors.nome_contratante" class="has-error">{{ errors.nome_contratante }}</div>
                <label><b>Nome do Contratante: </b></label>
                <input type="text" v-model="contrato.nome_contratante" class="form-control" placeholder="Nome do Contratante" pattern="^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$" required>
            </div>

            <div class="form-group">
                <div v-if="errors.tipo_pessoa" class="has-error">{{ errors.tipo_pessoa }}</div>
                <label><b>Tipo de Pessoa: </b></label>
                <select v-model="contrato.tipo_pessoa" id="campo_tipo_pessoa" class="form-control" @change.prevent="trocar_tipo_pessoa()" required>
                    <option value="" style="color:red" disabled>SELECIONE</option>
                    <option value="PF">PF</option>
                    <option value="PJ">PJ</option>
                </select>
                <br/>
                <div v-if="errors.cpf_cnpj" class="has-error">{{ errors.cpf_cnpj }}</div>
                <input type="text" v-model="contrato.cpf_cnpj" v-mask="mask" id="campo_cpf_cnpj" class="form-control" placeholder="CPF ou CNPJ" @blur.prevent="validar_cpf_cnpj()" required>
            </div>

            <input type="hidden" v-model="contrato.imovel_id" class="form-control" required>

            <div v-if="contrato.imovel_id">
                <label><b>Imóvel Escolhido: </b></label>
                <font color="red">Cód: {{ contrato.imovel_id }}</font>
            </div>

            <div class="form-group">
                <escolherImovelsComponent
                    :contrato="contrato"
                    :offset="4">
                </escolherImovelsComponent>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary">Enviar</button>
            </div>
        </form>
    </div>
</template>

<script>

import TheMask from 'vue-the-mask'
import EscolherImovelsComponent from './../imovels/EscolherImovelsComponent'

export default {
    data() {
        return {
            errors: {},
            mask:       '',
            mask_cpf:   "###.###.###-##",
            mask_cnpj:  "##.###.###/####-##"
        }
    },
   
    props: {
        update: {
            require: false,
            type: Boolean,
            default: false,
        },
        contrato: {
            require: false,
            type: Object,
        },
    },

    methods: {
        submitForm() {
            let retorno = this.validar_cpf_cnpj()
            if(retorno == false) return false

            let action = this.update ? 'updateContratos' : 'storeContratos'
          
            this.$store.dispatch(action, this.contrato)

                .then(() => {
                    let message = this.update ? 'ALTERADO' : 'CADASTRADO'
                    this.$snotify.success('CONTRATO '+message+' COM SUCESSO !')
                    this.reset()
                    this.$emit('success')
                })
                .catch(error => {
                    this.$snotify.error('EXISTEM ERROS DE CADASTRADO OU ESSE IMÓVEL JÁ ESTÁ EM OUTRO CONTRATO !'),
                    this.errors = error.data
                })
        },

        loadContratos(page) {
            this.$store.dispatch('loadContratos', {...this.params, page})
        },

        searchContratos(filter) {
            this.search = filter
            this.loadContratos(1)
        },

        reset() {
            this.errors = {}
        },

        trocar_tipo_pessoa() {
            if(document.getElementById('campo_tipo_pessoa').value == 'PF') {
                document.getElementById('campo_cpf_cnpj').placeholder = 'CPF'
                this.mask = this.mask_cpf
            }else {
                document.getElementById('campo_cpf_cnpj').placeholder = 'CNPJ'
                this.mask = this.mask_cnpj
            }
        },

        validar_cpf_cnpj() {
            var cpf_cnpj = document.getElementById('campo_cpf_cnpj').value

            if(cpf_cnpj.length < 14) {
                alert('CPF / CNPJ INVÁLIDO !!!\n\n QUANTIDADE DE CARACTERES MENOR DO QUE A QUANTIDADE PADRÃO !')
                return false; 
            }else if (cpf_cnpj.length == 14) {//CPF ...
                var cpf = cpf_cnpj.trim();
            
                cpf = cpf.replace(/\./g, '');
                cpf = cpf.replace('-', '');
                cpf = cpf.split('');
                
                var v1 = 0;
                var v2 = 0;
                var aux = false;
                
                for (var i = 1; cpf.length > i; i++) {
                    if (cpf[i - 1] != cpf[i]) {
                        aux = true;   
                    }
                } 
                
                if (aux == false) {
                    alert('CPF INVÁLIDO !!!')
                    return false; 
                } 
                
                for (var i = 0, p = 10; (cpf.length - 2) > i; i++, p--) {
                    v1 += cpf[i] * p; 
                } 
                
                v1 = ((v1 * 10) % 11);
                
                if (v1 == 10) {
                    v1 = 0; 
                }
                
                if (v1 != cpf[9]) {
                    alert('CPF INVÁLIDO !!!')
                    return false; 
                } 
                
                for (var i = 0, p = 11; (cpf.length - 1) > i; i++, p--) {
                    v2 += cpf[i] * p; 
                } 
                
                v2 = ((v2 * 10) % 11);
                
                if (v2 == 10) {
                    v2 = 0; 
                }
                
                if (v2 != cpf[10]) {
                    alert('CPF INVÁLIDO !!!')
                    return false; 
                }
            } else if (cpf_cnpj.length == 18) {//CNPJ ...
                var cnpj = cpf_cnpj.trim();
                
                cnpj = cnpj.replace(/\./g, '');
                cnpj = cnpj.replace('-', '');
                cnpj = cnpj.replace('/', ''); 
                cnpj = cnpj.split(''); 
                
                var v1 = 0;
                var v2 = 0;
                var aux = false;
                
                for (var i = 1; cnpj.length > i; i++) { 
                    if (cnpj[i - 1] != cnpj[i]) {  
                        aux = true;   
                    } 
                } 
                
                if (aux == false) {  
                    alert('CNPJ INVÁLIDO !!!')
                    return false
                }
                
                for (var i = 0, p1 = 5, p2 = 13; (cnpj.length - 2) > i; i++, p1--, p2--) {
                    if (p1 >= 2) {  
                        v1 += cnpj[i] * p1;  
                    } else {  
                        v1 += cnpj[i] * p2;  
                    } 
                } 
                
                v1 = (v1 % 11);
                
                if (v1 < 2) { 
                    v1 = 0; 
                } else { 
                    v1 = (11 - v1); 
                } 
                
                if (v1 != cnpj[12]) {  
                    alert('CNPJ INVÁLIDO !!!')
                    return false
                } 
                
                for (var i = 0, p1 = 6, p2 = 14; (cnpj.length - 1) > i; i++, p1--, p2--) { 
                    if (p1 >= 2) {  
                        v2 += cnpj[i] * p1;  
                    } else {   
                        v2 += cnpj[i] * p2; 
                    } 
                }
                
                v2 = (v2 % 11); 
                
                if (v2 < 2) {  
                    v2 = 0;
                } else { 
                    v2 = (11 - v2); 
                } 
                
                if (v2 != cnpj[13]) {   
                    alert('CNPJ INVÁLIDO !!!')
                    return false
                }
            } else {
                alert('CNPJ INVÁLIDO !!!')
                return false
            }
        },

        somente_letras(e, t) {
            try {
                if (window.event) {
                    var charCode = window.event.keyCode;
                } else if (e) {
                    var charCode = e.which;
                } else {
                    return true;
                }
                if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123))
                    return true;
                else
                    return false;
            } catch (err) {
                alert(err.Description);
            }
        },
    },

    components: {
        EscolherImovelsComponent,
        TheMask,
    }
}
</script>

<style scoped>
.has-error {color: red;}
.has-error input {border: 1px solid red;}
</style>