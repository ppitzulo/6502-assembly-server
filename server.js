const express = require('express');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');
const cors = require('cors');

const app = express();
const PORT = 3001;

app.use(cors());
app.use(express.raw({ type: 'text/plain', limit: '10mb' }));

app.post('/assemble', (req, res) => {
  const assemblyCode = req.body.toString('utf8'); // Convert raw buffer to string
  const inputFilePath = path.join(__dirname, 'input.asm');
  const outputFilePath = path.join(__dirname, 'input.bin');
  const entrypointPath = path.join(__dirname, 'entrypoint.sh');

  // Write the assembly code to a file
  fs.writeFileSync(inputFilePath, assemblyCode);

  // Run the assembler using the entrypoint script
  exec(`${entrypointPath} input.asm`, (error, stdout, stderr) => {
    if (error) {
      console.error(`Error: ${stderr}`);
      res.status(500).send(stderr);
      return;
    }

    // Read the output file as binary
    fs.readFile(outputFilePath, (err, data) => {
      if (err) {
        console.error(`Error: ${err}`);
        res.status(500).send(err);
        return;
      }

      res.setHeader('Content-Type', 'application/octet-stream');
      res.send(data);
    });
  });
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
