-- CreateTable
CREATE TABLE "Usuario" (
    "id_usuario" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "nivel" TEXT NOT NULL,
    "data" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "Insumo" (
    "id_insumo" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "descricao" TEXT,
    "fabricante" TEXT NOT NULL,
    "capacidade_total" INTEGER NOT NULL,
    "quantidade_atual" INTEGER NOT NULL,
    "unidade" TEXT NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "Insumo_pkey" PRIMARY KEY ("id_insumo")
);

-- CreateTable
CREATE TABLE "Lote" (
    "id_lote" SERIAL NOT NULL,
    "numero_lote" TEXT NOT NULL,
    "fabricante" TEXT NOT NULL,
    "data_fab" TIMESTAMP(3) NOT NULL,
    "data_val" TIMESTAMP(3) NOT NULL,
    "quantidade" INTEGER NOT NULL,
    "qr_code" TEXT,
    "insumoId" INTEGER NOT NULL,

    CONSTRAINT "Lote_pkey" PRIMARY KEY ("id_lote")
);

-- CreateTable
CREATE TABLE "Movimentacao" (
    "id_mov" SERIAL NOT NULL,
    "tipo" TEXT NOT NULL,
    "qtd" INTEGER NOT NULL,
    "data" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "motivo" TEXT,
    "usuarioId" INTEGER NOT NULL,
    "loteId" INTEGER NOT NULL,

    CONSTRAINT "Movimentacao_pkey" PRIMARY KEY ("id_mov")
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_email_key" ON "Usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Lote_numero_lote_fabricante_key" ON "Lote"("numero_lote", "fabricante");

-- AddForeignKey
ALTER TABLE "Lote" ADD CONSTRAINT "Lote_insumoId_fkey" FOREIGN KEY ("insumoId") REFERENCES "Insumo"("id_insumo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Movimentacao" ADD CONSTRAINT "Movimentacao_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Movimentacao" ADD CONSTRAINT "Movimentacao_loteId_fkey" FOREIGN KEY ("loteId") REFERENCES "Lote"("id_lote") ON DELETE RESTRICT ON UPDATE CASCADE;
