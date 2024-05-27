const express = require('express');
const axios = require("axios");
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path'); // Adicione esta linha para lidar com caminhos de arquivos


const app = express();
const port = 3000;

app.use(express.json({limit: '50mb'}));
app.use(express.urlencoded({limit: '50mb'}));
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({limit: '50mb'}));

// Caminho para o arquivo de log
const logFilePath = path.join(__dirname, 'logs', 'app.log');

// Função para registrar mensagens de log no arquivo
const writeToLog = (message) => {
  fs.appendFile(logFilePath, `${new Date().toISOString()}: ${message}\n`, (err) => {
    if (err) {
      console.error('Erro ao escrever no arquivo de log:', err);
    }
  });
};

//Testando pelo GET para ver serviço rodando
app.get("/webhook", function (request, response) { 
  console.log('Servidor rodando');
  writeToLog('Servidor rodando');
  writeToLog(JSON.stringify(request.body));
});

// Rota para o endpoint do webhook
app.post("/webhook/messages-upsert", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/messages-upsert.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});


// Rota para o endpoint do webhook
app.post("/webhook/messages-update", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/messages-update.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/message-update", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/messages-delete", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/messages-delete.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/message-delete", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/messages-set", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/messages-set.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/qrcode-updated", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/qrcode-updated.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/qrcode-updated", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/connection-update", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/connection-update.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/connection-update", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/call", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/call.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/call", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/send-message", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/send-message.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/send-message", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/message-set", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/message-set.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/message-set", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/contacts-set", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/contacts-set.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/contacts-set", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/contacts-upsert", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/contacts-upsert.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/contacts-upsert", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/contacts-update", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/contacts-update.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/contacts-update", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/chats-set", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/chats-set.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/chats-set", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/chats-upsert", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/chats-upsert.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/chats-upsert", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/chats-delete", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/chats-delete.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/chats-delete", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/chats-update", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/chats-update.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/chats-update", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/group-update", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/group-update.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/group-update", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/groups-updsert", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/groups-updsert.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/groups-updsert", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook/group-participants-update", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook/group-participants-update.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook/group-participants-update", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint do webhook
app.post("/webhook", function (request, response) {  
  writeToLog('Recebida uma solicitação no endpoint /webhook.');
  writeToLog(JSON.stringify(request.body));
  console.log(JSON.stringify(request.body));
  
  response.sendStatus(200);

  const webhookObject = JSON.parse(JSON.stringify(request.body));
  try { 
    axios      
      .post("http://localhost:8020/responsewebhook", webhookObject, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log(response.data);
      })
      .catch((error) => {
        console.error(error);
      });
  } catch (error) {
    console.error(error);
  }
});

// Rota para o endpoint raiz
app.get('/', (req, res) => {
  res.send('Servidor rodando. Para usar, envie uma solicitação POST para /webhook.');
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
