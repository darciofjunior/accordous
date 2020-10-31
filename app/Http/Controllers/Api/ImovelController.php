<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Imovel;
use App\Http\Requests\StoreUpdateImovels;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class ImovelController extends Controller
{
    private $imovel, $totalPage = 5;

    public function __construct(Imovel $imovel) {
        $this->imovel = $imovel;
    }

    public function index(Request $request)
    {
        if(!$imovels = $this->imovel->searchImovels($request->all(), $this->totalPage))
            return response()->json(['mensagem' => 'Nenhum Imóvel Cadastrado !'], 404);

        return response()->json($imovels);
    }

    public function show($id)
    {
        if(!$imovel = $this->imovel->find($id))
            return response()->json(['mensagem' => 'Imóvel não Cadastrado !'], 404);

        return response()->json($imovel);
    }

    public function store(StoreUpdateImovels $request)
    {
        $data           = $request->all();

        /******************Imagem******************/
        if ($request->hasFile('image') && $request->file('image')->isValid()) {
            $name           = Str::kebab(strstr($request->email_proprietario, '@', true));
            $extension      = $request->image->extension();

            $nameFile       = "{$name}.{$extension}";

            $upload         = $request->image->storeAs('imovels', $nameFile);

            if (!$upload)
                return response()->json(['error' => 'Fail_Upload'], 500);
        }
        /******************************************/

        $data['status'] = 'Não Contratado';

        $imovel = $this->imovel->create($data);

        //Se existir Imagem do Imóvel, atualiza o Imóvel criado com esta Imagem ...
        if(isset($nameFile)) {
            $imovel->image = $nameFile;
            $imovel->update();
        }

        return response()->json($imovel, 201);
    }

    public function update(StoreUpdateImovels $request, $id)
    {
        if(!$imovel = $this->imovel->find($id)) 
            return response()->json(['mensagem' => 'Imóvel não Cadastrado !'], 404);

        $data           = $request->all();

        if ($imovel->image) {
            if (Storage::exists("imovels/{$imovel->image}"))
                Storage::delete("imovels/{$imovel->image}");
        }

        /******************Imagem******************/
        if ($request->hasFile('image') && $request->file('image')->isValid()) {
            $name           = Str::kebab(strstr($request->email_proprietario, '@', true));
            $extension      = $request->image->extension();

            $nameFile       = "{$name}.{$extension}";
            $data['image']  = $nameFile;

            $upload = $request->image->storeAs('imovels', $nameFile);

            if (!$upload)
                return response()->json(['error' => 'Fail_Upload'], 500);
        }else {
            $data['image']  = '';
        }
        /******************************************/

        $imovel->update($data);

        return response()->json($imovel);
    }

    public function destroy($id)
    {
        if(!$imovel = $this->imovel->find($id))
            return response()->json(['mensagem' => 'Imóvel não Cadastrado !'], 404);

        //Deleta o imovel da galeria de Imagens ...
        if ($imovel->image) {
            if (Storage::exists("imovels/{$imovel->image}"))
                Storage::delete("imovels/{$imovel->image}");
        }

        //Delete o Registro em si ...
        $imovel->delete();

        return response()->json($imovel, 204);
    }
}
