# Usa Ruby 3.3 (compatible con Rails 8)
FROM ruby:3.3-slim

# Instalar dependencias del sistema
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    git \
    && rm -rf /var/lib/apt/lists/*

# Configurar directorio de trabajo
WORKDIR /app

# Instalar Rails 8.0.2 globalmente
RUN gem install rails -v 8.0.2

# Exponer puerto
EXPOSE 3000

# Comando por defecto
CMD ["bash"]
