import { RequestHandler } from "express";
import * as peoples from '../services/peoples';
import { z } from "zod";

export const getAll: RequestHandler = async (req, res) => {
  const { id_event, id_group } = req.params;

  const items = await peoples.getAll({
    id_event: parseInt(id_event),
    id_group: parseInt(id_group)
  });
  if(items) return res.json({ peoples: items});

  res.json({ error: 'Ocorreu um erro!'});
}