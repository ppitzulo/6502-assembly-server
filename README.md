# 6502 Assembly Compiler Service

This project provides a web service for compiling 6502 assembly code, created for use with my 6502 development environment. It uses a Node.js server to accept assembly code input, compile it using the cc65 toolchain, and return the compiled binary.

## Components

1. `server.js`: Express.js server that handles HTTP requests for assembly compilation.
2. `entrypoint.sh`: Bash script that performs the assembly and linking process.
3. `Dockerfile`: Defines the Docker image for the service.
4. `config.cfg`: Configuration file for the linker.

## Prerequisites

- Docker
- Node.js (for local development)

## Setup

1. Clone the repository:
   ```
   git clone <repository-url>
   cd <project-directory>
   ```

2. Build the Docker image:
   ```
   docker build -t 6502-asm-compiler .
   ```

## Running the Service

### Using Docker

Run the service using Docker:

```
docker run -p 3001:3001 6502-asm-compiler
```

The service will be available at `http://localhost:3001`.

### Local Development

1. Install dependencies:
   ```
   npm install
   ```

2. Start the server:
   ```
   node server.js
   ```

The server will run on `http://localhost:3001`.

## Usage

Send a POST request to `/assemble` endpoint with the assembly code as plain text in the request body.

Example using curl:

```
curl -X POST -H "Content-Type: text/plain" --data-binary "@path/to/your/assembly/file.asm" http://localhost:3001/assemble > output.bin
```

The server will respond with the compiled binary, which you can save to a file.

## Environment Variables

- `NODE_ENV`: Set to 'production' by default in the Docker image. Can be set to 'development' for local development.

