<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Imovel extends Model
{
    public $timestamps = false;

    protected $fillable = [
        'email_proprietario',
        'rua',
        'numero',
        'complemento',
        'bairro',
        'cidade',
        'estado',
        'foto', 
        'status'
    ];

    public function searchImovels($data, $totalPage = 5)
    {
        if (!isset($data['filter']))
            return $this->orderBy('email_proprietario', 'ASC')
                        ->paginate($totalPage);

        return $this->where(function ($query) use ($data) {
            if (isset($data['filter'])) {
                $filter = $data['filter'];
                $query->where('email_proprietario', 'LIKE', "%{$filter}%");
                $query->orWhere('rua', 'LIKE', "%{$filter}%");
                $query->orWhere('numero', 'LIKE', "%{$filter}%");
                $query->orWhere('complemento', 'LIKE', "%{$filter}%");
                $query->orWhere('bairro', 'LIKE', "%{$filter}%");
                $query->orWhere('cidade', 'LIKE', "%{$filter}%");
                $query->orWhere('estado', 'LIKE', "%{$filter}%");
                $query->orWhere('status', 'LIKE', "%{$filter}%");
            }
        })
        ->orderBy('email_proprietario', 'ASC')
        ->paginate($totalPage);
    }
}
