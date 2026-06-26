/*
  Warnings:

  - The primary key for the `Insumo` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id_insumo` on the `Insumo` table. All the data in the column will be lost.
  - The primary key for the `Lote` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `data_fab` on the `Lote` table. All the data in the column will be lost.
  - You are about to drop the column `data_val` on the `Lote` table. All the data in the column will be lost.
  - You are about to drop the column `id_lote` on the `Lote` table. All the data in the column will be lost.
  - You are about to drop the column `qr_code` on the `Lote` table. All the data in the column will be lost.
  - You are about to drop the column `quantidade` on the `Lote` table. All the data in the column will be lost.
  - You are about to drop the `Movimentacao` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Usuario` table. If the table is not empty, all the data it contains will be lost.
  - The required column `id` was added to the `Insumo` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `updatedAt` to the `Insumo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `data_validade` to the `Lote` table without a default value. This is not possible if the table is not empty.
  - The required column `id` was added to the `Lote` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `quantidade_atual` to the `Lote` table without a default value. This is not possible if the table is not empty.
  - Added the required column `quantidade_inicial` to the `Lote` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Lote" DROP CONSTRAINT "Lote_insumoId_fkey";

-- DropForeignKey
ALTER TABLE "Movimentacao" DROP CONSTRAINT "Movimentacao_loteId_fkey";

-- DropForeignKey
ALTER TABLE "Movimentacao" DROP CONSTRAINT "Movimentacao_usuarioId_fkey";

-- AlterTable
ALTER TABLE "Insumo" DROP CONSTRAINT "Insumo_pkey",
DROP COLUMN "id_insumo",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "id" TEXT NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "capacidade_total" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "quantidade_atual" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "status" SET DEFAULT 'DISPONIVEL',
ADD CONSTRAINT "Insumo_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Lote" DROP CONSTRAINT "Lote_pkey",
DROP COLUMN "data_fab",
DROP COLUMN "data_val",
DROP COLUMN "id_lote",
DROP COLUMN "qr_code",
DROP COLUMN "quantidade",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "data_validade" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "id" TEXT NOT NULL,
ADD COLUMN     "quantidade_atual" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "quantidade_inicial" DOUBLE PRECISION NOT NULL,
ALTER COLUMN "insumoId" SET DATA TYPE TEXT,
ADD CONSTRAINT "Lote_pkey" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "Movimentacao";

-- DropTable
DROP TABLE "Usuario";

-- AddForeignKey
ALTER TABLE "Lote" ADD CONSTRAINT "Lote_insumoId_fkey" FOREIGN KEY ("insumoId") REFERENCES "Insumo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
