// Encripta 
export const encryptMatch = (id: number): string => {
  // Retorna o token id token
  return `${process.env.DEFAULT_TOKEN}${id}${process.env.DEFAULT_TOKEN}`;
}
// Descripta
export const decryptMatch = (match: string): number => {
  let idString: string = match
    .replace(`${process.env.DEFAULT_TOKEN}`, '') // Remove o primeiro token
    .replace(`${process.env.DEFAULT_TOKEN}`, ''); // Remove o último token
  return parseInt(idString); // Retorna só o id
}