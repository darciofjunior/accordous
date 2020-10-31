<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Estado;
use App\Http\Requests\StoreUpdateEstados;

class EstadoController extends Controller
{
    private $estado;

    public function __construct(Estado $estado)
    {
        $this->estado = $estado;
    }

    public function index()
    {
        if(!$estados = $this->estado->orderBy('uf', 'ASC')->get())
            return response()->json(['mensagem' => 'Nenhum Estado Cadastrado !'], 404);

        return response()->json($estados);
    }

    public function show($id)
    {
        if(!$estado = $this->estado->find($id))
            return response()->json(['mensagem' => 'Estado não Cadastrado !'], 404);

        return response()->json($estado);
    }

    public function store(StoreUpdateEstados $request)  
    {
        $estado = $this->estado->create($request->all());

        return response()->json($estado, 201);
    }

    public function update(StoreUpdateEstados $request, $id)
    {
        if(!$estado = $this->estado->find($id)) 
            return response()->json(['mensagem' => 'Estado não Cadastrado !'], 404);

        $estado->update($request->all());

        return response()->json($estado);
    }

    public function destroy($id)
    {
        if(!$estado = $this->estado->find($id))
            return response()->json(['mensagem' => 'Estado não Cadastrado !'], 404);

        $estado->delete();

        return response()->json($estado, 204);
    }
}
