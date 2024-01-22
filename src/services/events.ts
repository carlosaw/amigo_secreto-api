import { Prisma, PrismaClient } from "@prisma/client";
import * as people from './people';
import * as groups from './groups';
import { encryptMatch } from "../utils/match";

const prisma = new PrismaClient();

export const getAll = async () => {
  try {
    return await prisma.event.findMany();
  } catch (err) { return false }
}

export const getOne = async (id: number) => {
  try {
    return await prisma.event.findFirst({ where: { id } });
  } catch (err) { return false }
}

type EventsCreateData = Prisma.Args<typeof prisma.event, 'create'>['data'];
export const add = async (data: EventsCreateData) => {
  try {
    return await prisma.event.create({ data });
  } catch (err) { return false }
}

type EventsUpdateData = Prisma.Args<typeof prisma.event, 'update'>['data'];
export const update = async (id: number, data: EventsUpdateData) => {
  try {
    return await prisma.event.update({ where: { id }, data });
  } catch (err) { return false }
}

export const remove = async (id: number) => {
  try {
    return await prisma.event.delete({ where: { id } });
  } catch (err) { return false }
}

/* 
  - Grupo A (id: 1)
  -- Carlos Alberto
  -- Charles
  -- Pedro

  - Grupo B (id: 2)
  -- João
  --Inácio

  - Grupo C (id: 5)
  -- Gabriela
  */

// SORTEIO = rota(PUT /admin/events/:id)
export const doMatches = async (id: number): Promise<boolean> => {
  // Consulta evento e se é agrupado
  const eventItem = await prisma.event.findFirst({ where: { id }, select: { grouped: true }});
  if(eventItem) {// Se evento existe

    // Pega lista das pessoas daquele evento
    const peopleList = await people.getAll({ id_event: id });
    if(peopleList) { // Se tiver pessoas
      let sortedList: { id: number, match: number }[] = []; // Lista dos sorteados
      let sortable: number[] = []; // sorteável (não foi sorteado)

      let attempts = 0; // Tentativas de sorteio
      let maxAttempts = peopleList.length; // Máximo de tentativas ==== qtde. de pessoas
      let keepTrying = true; // Faz o sorteio 
      // Faça sorteio enquanto tentativas menor que máximo de tentativas
      while(keepTrying && attempts < maxAttempts) {
        keepTrying = false; // Para o sorteio
        attempts++; // Nova tentativa
        sortedList = []; // Limpa a lista de sorteados
        sortable = peopleList.map(item => item.id); // Pega os ids

        // Loop de pessoas
        for(let i in peopleList) {
          let sortableFiltered: number[] = sortable;/// Lista de pessoas sorteáveis
          if(eventItem.grouped) {// Se evento for AGRUPADO
            // Pega somente pessoas de outros grupos
            sortableFiltered = sortable.filter(sortableItem => {
              // Pega a pessoa baseado no id
              let sortablePerson = peopleList.find(item => item.id === sortableItem);
              // Se achou pessoa tem que ser diferente da pessoa do id
              return peopleList[i].id_group !== sortablePerson?.id_group;
            });
          }
          
          if(sortableFiltered.length === 0 || // Se não tem ninguém pra ser sorteado ou
           (sortableFiltered.length === 1 && // se tem só uma pessoa
            peopleList[i].id === sortableFiltered[0] // esta pessoa sou eu
          )) {
            keepTrying = true; // Deu problema 
          } else { // Caso contrário continua...
            // Faz o sorteio
            // Gera um número aleatório conforme número de pessoas sorteáveis
            let sortedIndex = Math.floor(Math.random() * sortableFiltered.length);
            // Se a pessoa aleatório sorteada for eu, sorteia de novo
            while(sortableFiltered[sortedIndex] === peopleList[i].id) {
              sortedIndex = Math.floor(Math.random() * sortableFiltered.length);
            }
            // Adiciona o registro da pessoa sorteada
            sortedList.push({
              id: peopleList[i].id,
              match: sortableFiltered[sortedIndex]
            });
            // Remove a pessoa que eu tirei dos sorteáveis
            sortable = sortable.filter(item => item !== sortableFiltered[sortedIndex]);
          }
        }
      }

      console.log( `ATTEMPTS: ${attempts}` );
      console.log( `MAX ATTEMPTS: ${maxAttempts}` );
      console.log( sortedList );
      // Se tentativas menor que máximo de tentativas ('deu certo')
      if(attempts < maxAttempts) {
        for(let i in sortedList) {// Pega a lista de sorteados
          await people.update({// Troca o matched (sorteado);
            id: sortedList[i].id,// Pega a pessoa
            id_event: id // Pega o evento
          }, { matched: encryptMatch(sortedList[i].match) });// Quem foi sorteado 
          // TODO: Criar encryptMatch(utils/match.ts)
        }
        return true;
      }
      
    }
  }

  return false;

}