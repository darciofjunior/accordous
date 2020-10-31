<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreUpdateImovels extends FormRequest
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
            'email_proprietario'    => "required|email|unique:imovels,email_proprietario,{$id},id",
            'rua'                   => 'required|min:10|max:80',
            'numero'                => 'required|min:1|max:5',
            'complmento'            => 'max:20',
            'bairro'                => 'required|min:5|max:50',
            'cidade'                => 'required|min:5|max:70',
            'estado'                => 'required|min:2|',
            'image'                 => 'image',
            'status'                => '',
        ];
    }
}
