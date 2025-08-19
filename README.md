# Our Portfolio - Rails 8 Application

Una aplicación web desarrollada con Ruby on Rails 8 y PostgreSQL, ejecutándose en contenedores Docker.

## 🚀 Tecnologías

- **Ruby**: 3.3
- **Rails**: 8.0.2
- **Base de datos**: PostgreSQL 16
- **Servidor web**: Puma
- **Frontend**: 
  - **Hotwire** (Turbo + Stimulus)
  - **React** 18.2 + **React DOM**
  - **esbuild** para bundling JavaScript
  - **Tailwind CSS** para estilos
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

### React + Stimulus (Frontend Moderno)
```bash
# Instalar dependencias de Node.js
docker-compose run --rm web npm install

# Compilar JavaScript (una vez)
docker-compose run --rm web npm run build

# Compilar JavaScript en modo watch (desarrollo)
docker-compose run --rm web npm run build -- --watch

# Compilar Tailwind CSS
docker-compose run --rm web npm run build:css

# Ver estructura de archivos JavaScript compilados
docker-compose run --rm web ls -la app/assets/builds/

# Crear nuevo componente React
# (Agregar manualmente en app/javascript/components/ComponentName.js)

# Crear nuevo controlador Stimulus
# (Agregar manualmente en app/javascript/controllers/controller_name.js)
```

### Comandos de desarrollo completo con React
```bash
# Terminal 1: Servidor Rails
docker-compose up

# Terminal 2: Compilación JavaScript automática
docker-compose run --rm web npm run build -- --watch

# Terminal 3: Compilación CSS automática (opcional)
docker-compose run --rm web npm run build:css -- --watch
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
│   ├── controllers/       # Controladores Rails
│   ├── models/           # Modelos ActiveRecord
│   ├── views/            # Vistas ERB
│   ├── assets/           # Assets compilados
│   │   └── builds/       # JavaScript y CSS compilados
│   └── javascript/       # Código JavaScript moderno
│       ├── application.js    # Punto de entrada principal
│       ├── controllers/      # Controladores Stimulus
│       │   ├── application.js
│       │   ├── index.js
│       │   └── react_component_controller.js
│       └── components/       # Componentes React
│           ├── Counter.js
│           └── TodoList.js
├── config/               # Configuración de Rails
│   ├── database.yml      # Configuración de BD
│   └── routes.rb         # Rutas de la aplicación
├── db/                   # Base de datos
│   ├── migrate/          # Migraciones
│   └── seeds.rb          # Datos de prueba
├── package.json          # Dependencias de Node.js
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

### Problemas con JavaScript/React
```bash
# Reinstalar dependencias de Node.js
docker-compose run --rm web npm install

# Limpiar y recompilar JavaScript
docker-compose run --rm web rm -rf app/assets/builds/*
docker-compose run --rm web npm run build

# Ver errores de compilación JavaScript
docker-compose run --rm web npm run build

# Verificar que los archivos están compilados
docker-compose run --rm web ls -la app/assets/builds/
```

## 📝 Notas de Desarrollo

- Todos los comandos Rails deben ejecutarse con `bundle exec`
- Los cambios en el código se reflejan automáticamente (hot reload)
- Los datos de la BD se persisten en volúmenes Docker
- Para cambios en `Gemfile` o `Dockerfile`, reconstruir la imagen
- Los archivos JavaScript se compilan automáticamente en modo watch
- Los componentes React se cargan dinámicamente vía Stimulus

## ⚛️ Integración React + Stimulus

### Arquitectura
La aplicación usa una arquitectura híbrida que combina:
- **Rails** para el backend, routing y vistas principales
- **Stimulus** para gestión de interacciones y lifecycle
- **React** para componentes UI complejos e interactivos

### Cómo crear un nuevo componente React

1. **Crear el componente React:**
```javascript
// app/javascript/components/MiComponente.js
import React, { useState } from 'react'

const MiComponente = ({ titulo = "Mi Componente" }) => {
  const [estado, setEstado] = useState(0)
  
  return (
    <div className="bg-white p-6 rounded-lg shadow-lg">
      <h3 className="text-xl font-bold mb-4">{titulo}</h3>
      <p>Estado: {estado}</p>
      <button 
        onClick={() => setEstado(estado + 1)}
        className="bg-blue-500 text-white px-4 py-2 rounded">
        Incrementar
      </button>
    </div>
  )
}

export default MiComponente
```

2. **Usar en cualquier vista Rails:**
```erb
<!-- En cualquier archivo .html.erb -->
<div data-controller="react-component" 
     data-react-component-component-value="MiComponente" 
     data-react-component-props-value='{"titulo": "Mi Título Personalizado"}'>
  <div data-react-component-target="container"></div>
</div>
```

3. **Recompilar JavaScript:**
```bash
docker-compose run --rm web npm run build
```

### Componentes disponibles
- **Counter**: Contador interactivo con incremento/decremento
- **TodoList**: Lista de tareas completa con filtros y estadísticas

### Flujo de datos
1. Rails renderiza la vista con atributos `data-*`
2. Stimulus detecta el controlador `react-component`
3. Se cargan dinámicamente los componentes React especificados
4. Las props se pasan desde los atributos HTML al componente
5. React renderiza y gestiona el estado interno
6. Stimulus gestiona el lifecycle (mount/unmount)

## 🚀 Despliegue

Para producción, actualizar las variables de entorno en `docker-compose.yml`:
- `RAILS_ENV=production`
- Configurar credenciales de BD seguras
- Configurar `SECRET_KEY_BASE`
