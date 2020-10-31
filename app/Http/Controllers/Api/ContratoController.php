<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Contrato;
use App\Http\Requests\StoreUpdateContratos;

class ContratoController extends Controller
{
    private $contrato, $totalPage = 5;

    public function __construct(Contrato $contrato)
    {
        $this->contrato = $contrato; 
    }

    public function index(Request $request)
    {
        if(!$contratos = $this->contrato->searchContratos($request->all(), $this->totalPage))
            return response()->json(['mensagem' => 'Nenhum Contrato Cadastrado !'], 404);

        return response()->json($contratos);
    }

    public function show($id)
    {
        if(!$contrato = $this->contrato->find($id))
            return response()->json(['mensagem' => 'Contrato não Cadastrado !'], 404);

        return response()->json($contrato);
    }

    public function store(StoreUpdateContratos $request)
    {
        $imovel_em_contrato = $this->contrato->imovel_em_contrato($request->imovel_id);

        if($imovel_em_contrato)
            return response()->json(['mensagem' => 'Esse imóvel já está em outro Contrato !'], 404);

        $contrato = $this->contrato->create($request->all());

        return response()->json($contrato, 201);
    }

    public function update(StoreUpdateContratos $request, $id)
    {
        if(!$contrato = $this->contrato->find($id))
            return response()->json(['mensagem' => 'Contrato não Cadastrado !'], 404);
      
        $imovel_em_contrato = $this->contrato->imovel_em_contrato($request->imovel_id, $id);

        if($imovel_em_contrato)
            return response()->json(['mensagem' => 'Esse imóvel já está em outro Contrato !'], 404);

        $contrato->update($request->all());

        return response()->json($contrato);
    }

    public function destroy($id)
    {
        if(!$contrato = $this->contrato->find($id))
            return response()->json(['mensagem' => 'Contrato não Cadastrado !'], 404);

        $contrato->delete();

        return response()->json($contrato, 204);
    }
}
