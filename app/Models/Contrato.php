<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Contrato extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'email_contratante',
        'nome_contratante',
        'tipo_pessoa',
        'cpf_cnpj',
        'imovel_id',
    ];

    public function searchContratos($data, $totalPage = 5)
    {
        if (!isset($data['filter']))
            return $this->with('imovel')
                        ->orderBy('email_contratante', 'ASC')
                        ->paginate($totalPage);

        return $this->with('imovel')->where(function ($query) use ($data) {
            if (isset($data['filter'])) {
                $filter = $data['filter'];
                $query->where('email_contratante', 'LIKE', "%{$filter}%");
                $query->orWhere('nome_contratante', 'LIKE', "%{$filter}%");
                $query->orWhere('tipo_pessoa', 'LIKE', "%{$filter}%");
                $query->orWhere('cpf_cnpj', 'LIKE', "%{$filter}%");
            }
        })
        ->orderBy('email_contratante', 'ASC')
        ->paginate($totalPage);
    }

    public function imovel() {
        return $this->hasOne(Imovel::class, 'id', 'imovel_id');
    }
  
    //Verifico se o imóvel escolhido já não está em algum outro contato ...
    public function imovel_em_contrato($imovel_id, $id = '') {
        if($id == '') {//Inclusão ...
            return $this->where('imovel_id', $imovel_id)
                        ->select('id')
                        ->first();
        }else {//Alteração ...
            return $this->where('imovel_id', $imovel_id)
                        ->where('id', '<>', $id)
                        ->select('id')
                        ->first();
        }
    }
}
