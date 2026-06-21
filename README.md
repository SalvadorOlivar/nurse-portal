# nurse Portal

Sistema de gestión de turnos para personal de enfermería.

## Requisitos

- Go 1.25+
- Node.js 24+
- Docker (para PostgreSQL)

## Inicio rápido

```bash
# Iniciar base de datos
docker compose up -d

# Backend
cd backend
go mod download
make run

# Frontend
cd frontend
npm install
npm run dev
```
