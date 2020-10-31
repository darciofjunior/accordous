<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateImovelsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('imovels', function (Blueprint $table) {
            $table->id();
            $table->string('email_proprietario', 100)->unique();
            $table->string('rua', 80);
            $table->string('numero', 5);
            $table->string('complemento', 20)->nullable();
            $table->string('bairro', 50);
            $table->string('cidade', 70);
            $table->string('estado', 2);
            $table->string('image', 100)->nullable();
            $table->enum('status', ['Contratado', 'Não contratado']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('imovels');
    }
}
