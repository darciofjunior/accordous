<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreUpdateContratos extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $id = $this->segment('3');

        return [
            'email_contratante'     => "required|min:10|max:100|unique:contratos,email_contratante,{$id},id",
            'nome_contratante'      => 'required|min:3|max:100',
            'tipo_pessoa'           => 'required',
            'cpf_cnpj'              => 'required',
            'imovel_id'             => 'required|exists:imovels,id', 
        ];
    }
}
