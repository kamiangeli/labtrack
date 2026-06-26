import express from 'express';
import { PrismaClient } from '@prisma/client';

const app = express();
const prisma = new PrismaClient(); 

app.use(express.json());

app.listen(3000, () => {
  console.log("Finalmente! Servidor rodando na porta 3000!");
});


app.post('/insumos', async (req, res) => {
  try {
    const { nome, descricao, fabricante, capacidade_total, quantidade_atual, unidade, status } = req.body;

    const novoInsumo = await prisma.insumo.create({
      data: {
        nome,
        descricao,
        fabricante,
        capacidade_total: Number(capacidade_total),
        quantidade_atual: Number(quantidade_atual),
        unidade,
        status
      }
    });

    return res.status(201).json(novoInsumo);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Erro interno ao cadastrar insumo." });
  }
});




app.post('/lotes', async (req, res) => {
  try {
    const { numero_lote, fabricante, quantidade_inicial, quantidade_atual, data_validade, insumoId } = req.body;

    // 1. Verifica se já existe um lote com o MESMO número E fabricante (RN004)
    const loteExistente = await prisma.lote.findUnique({
      where: {
        numero_lote_fabricante: {
          numero_lote,
          fabricante
        }
      }
    });

    if (loteExistente) {
      return res.status(400).json({ 
        error: "Já existe um lote com este mesmo número para este fabricante." 
      });
    }

    // 2. Cria o lote convertendo o insumoId para número inteiro
    const novoLote = await prisma.lote.create({
      data: {
        numero_lote,
        fabricante,
        quantidade_inicial: Number(quantidade_inicial),
        quantidade_atual: Number(quantidade_atual),
        data_validade: new Date(data_validade),
        insumoId: Number(insumoId) // 🌟 A ÚNICA MUDANÇA REAL FOI AQUI!
      }
    });

    return res.status(201).json(novoLote);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Erro interno ao cadastrar o lote." });
  }
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});