/*
  Warnings:

  - The primary key for the `Insumo` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Insumo` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Lote` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Lote` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Changed the type of `insumoId` on the `Lote` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "Lote" DROP CONSTRAINT "Lote_insumoId_fkey";

-- AlterTable
ALTER TABLE "Insumo" DROP CONSTRAINT "Insumo_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Insumo_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Lote" DROP CONSTRAINT "Lote_pkey",
DROP COLUMN "insumoId",
ADD COLUMN     "insumoId" INTEGER NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Lote_pkey" PRIMARY KEY ("id");

-- AddForeignKey
ALTER TABLE "Lote" ADD CONSTRAINT "Lote_insumoId_fkey" FOREIGN KEY ("insumoId") REFERENCES "Insumo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
