import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import https from 'https';
import http from 'http';
import siteRoutes from './routes/site';
import adminRoutes from './routes/admin';
import { requestIntercepter } from './utils/requestIntercepter';
import fs from 'fs';

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.all('*', requestIntercepter);

app.use('/admin', adminRoutes);
app.use('/', siteRoutes);

const runServer = (port: number, server: http.Server) => {
  server.listen(port, () => {
    console.log(`🚀 Running at PORT ${port}`);
  })
}

const regularServer = http.createServer(app);
if (process.env.NODE_ENV === 'production') {
  // TODO: configurar SSL
  const options = { // Cria options com arquivos do .env
    key: fs.readFileSync(process.env.SSL_KEY as string),
    cert: fs.readFileSync(process.env.SSL_CERT as string)
  }
  // Cria Servidor seguro
  const secServer = https.createServer(options, app);
  runServer(80, regularServer); // Roda servidor na porta 80
  runServer(443, secServer); // Roda https na porta 443
  // TODO: rodar server na 80 e/ou na 443
} else {
  const serverPort: number = process.env.PORT ? parseInt(process.env.PORT) : 9000;
  runServer(serverPort, regularServer);
}