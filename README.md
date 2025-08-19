# Our Portfolio - Rails 8 Application

Una aplicación web desarrollada con Ruby on Rails 8 y PostgreSQL, ejecutándose en contenedores Docker.

## 🚀 Tecnologías

- **Ruby**: 3.3
- **Rails**: 8.0.2
- **Base de datos**: PostgreSQL 16
- **Servidor web**: Puma
- **Frontend**: Hotwire (Turbo + Stimulus), Importmap
- **Containerización**: Docker + Docker Compose

## 📋 Prerrequisitos

- Docker
- Docker Compose

## 🛠️ Configuración Inicial

### 1. Clonar el repositorio
```bash
git clone <repository-url>
cd our_pf
```

### 2. Construir la aplicación
```bash
# Construir las imágenes Docker
docker-compose build

# Iniciar la aplicación (incluye creación y migración de BD)
docker-compose up
```

La aplicación estará disponible en: **http://localhost:3000**

## 🔧 Comandos de Desarrollo

### Gestión de la aplicación
```bash
# Iniciar la aplicación
docker-compose up

# Iniciar en background
docker-compose up -d

# Parar la aplicación
docker-compose down

# Parar y eliminar volúmenes (datos de BD)
docker-compose down -v
```

### Base de datos
```bash
# Crear la base de datos
docker-compose run --rm web bundle exec rails db:create

# Ejecutar migraciones
docker-compose run --rm web bundle exec rails db:migrate

# Rollback de migraciones
docker-compose run --rm web bundle exec rails db:rollback

# Seed de datos
docker-compose run --rm web bundle exec rails db:seed

# Reset completo de BD
docker-compose run --rm web bundle exec rails db:drop db:create db:migrate db:seed
```

### Generadores de Rails
```bash
# Generar modelo
docker-compose run --rm web bundle exec rails generate model User name:string email:string

# Generar controlador
docker-compose run --rm web bundle exec rails generate controller Pages index about contact

# Generar scaffold completo
docker-compose run --rm web bundle exec rails generate scaffold Post title:string content:text

# Generar migración
docker-compose run --rm web bundle exec rails generate migration AddFieldToTable field:type
```

### Consola y debugging
```bash
# Abrir consola Rails
docker-compose run --rm web bundle exec rails console

# Ver rutas
docker-compose run --rm web bundle exec rails routes

# Ver rutas de un controlador específico
docker-compose run --rm web bundle exec rails routes -c Pages

# Ejecutar tests
docker-compose run --rm web bundle exec rails test

# Ejecutar RuboCop (linter)
docker-compose run --rm web bundle exec rubocop
```

### Gestión de gemas
```bash
# Instalar nuevas gemas después de modificar Gemfile
docker-compose run --rm web bundle install

# Actualizar gemas
docker-compose run --rm web bundle update

# Ver gemas instaladas
docker-compose run --rm web bundle list
```

### Reconstrucción y limpieza
```bash
# Reconstruir imagen sin cache (después de cambios en Dockerfile o Gemfile)
docker-compose build --no-cache

# Ver logs de la aplicación
docker-compose logs web

# Seguir logs en tiempo real
docker-compose logs -f web

# Acceder al contenedor
docker-compose exec web bash
```

## 📁 Estructura del Proyecto

```
our_pf/
├── app/                    # Código de la aplicación
│   ├── controllers/       # Controladores
│   ├── models/           # Modelos
│   ├── views/            # Vistas
│   └── assets/           # Assets (CSS, JS, imágenes)
├── config/               # Configuración de Rails
│   ├── database.yml      # Configuración de BD
│   └── routes.rb         # Rutas de la aplicación
├── db/                   # Base de datos
│   ├── migrate/          # Migraciones
│   └── seeds.rb          # Datos de prueba
├── docker-compose.yml    # Configuración de Docker Compose
├── Dockerfile           # Imagen de la aplicación
└── Gemfile             # Dependencias de Ruby
```

## 🔧 Configuración de Base de Datos

La aplicación usa PostgreSQL con la siguiente configuración:
- **Host**: db (nombre del servicio Docker)
- **Puerto**: 5432
- **Usuario**: rails_user
- **Contraseña**: rails
- **Base de datos**: our_pf

## 🐛 Troubleshooting

### La aplicación no inicia
```bash
# Ver logs detallados
docker-compose logs web

# Reconstruir completamente
docker-compose down -v
docker-compose build --no-cache
docker-compose up
```

### Error de conexión a la base de datos
```bash
# Verificar que la BD esté corriendo
docker-compose ps

# Restart del servicio de BD
docker-compose restart db
```

### Problemas con gemas
```bash
# Limpiar y reinstalar gemas
docker-compose down
docker-compose build --no-cache
docker-compose up
```

## 📝 Notas de Desarrollo

- Todos los comandos Rails deben ejecutarse con `bundle exec`
- Los cambios en el código se reflejan automáticamente (hot reload)
- Los datos de la BD se persisten en volúmenes Docker
- Para cambios en `Gemfile` o `Dockerfile`, reconstruir la imagen

## 🚀 Despliegue

Para producción, actualizar las variables de entorno en `docker-compose.yml`:
- `RAILS_ENV=production`
- Configurar credenciales de BD seguras
- Configurar `SECRET_KEY_BASE`
