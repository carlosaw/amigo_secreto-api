import { RequestHandler } from "express";
import * as events from '../services/events';
import * as people from '../services/people';
import { z } from "zod";

export const getAll: RequestHandler = async (req, res) => {
  const items = await events.getAll();
  if (items) return res.json({ events: items });

  res.json({ error: 'Ocorreu um erro!' });
}

export const getEvent: RequestHandler = async (req, res) => {
  const { id } = req.params;
  const eventItem = await events.getOne(parseInt(id));
  if (eventItem) return res.json({ event: eventItem });

  res.json({ error: 'Ocorreu um erro!' });
}

export const addEvent: RequestHandler = async (req, res) => {
  const addEventSchema = z.object({
    title: z.string(),
    description: z.string(),
    grouped: z.boolean()
  });
  const body = addEventSchema.safeParse(req.body);
  if (!body.success) return res.json({ error: 'Dados inválidos!' });

  const newEvent = await events.add(body.data);
  if (newEvent) return res.status(201).json({ event: newEvent });

  res.json({ error: 'Ocorreu um erro!' });
}

export const updateEvent: RequestHandler = async (req, res) => {
  const { id } = req.params;// Pega o envento
  const updateEventSchema = z.object({// Pega o que foi digitado
    status: z.boolean().optional(),// Pode trocar só status
    title: z.string().optional(),// Pode trocar só titulo
    description: z.string().optional(),// Pode trocar só description
    grouped: z.boolean().optional()// Pode trocar só grupo
  });
  const body = updateEventSchema.safeParse(req.body);
  if (!body.success) return res.json({ error: 'Dados inválidos! ' });

  const updatedEvent = await events.update(parseInt(id), body.data);
  if (updatedEvent) {
    if (updatedEvent.status) {
      // TODO: Fazer o sorteio
      const result = events.doMatches(parseInt(id));
      if(!result) {
        return res.json({ error: 'Grupos impossíveis de sorrtear' });
      } 
    } else {
      // TODO: Limpar o sorteio
      await people.update({ id_event: parseInt(id) }, {matched: '' });
    }
    return res.json({ event: updatedEvent });
  }
  res.json({ error: 'Ocorreu um erro!' });
}

export const deleteEvent: RequestHandler = async (req, res) => {
  const { id } = req.params;

  const deletedEvent = await events.remove(parseInt(id));
  if (deletedEvent) return res.json({ event: deletedEvent });

  res.json({ error: 'Ocorreu um erro!' });
}