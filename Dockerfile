# Usa Ruby 3.3 (compatible con Rails 8)
FROM ruby:3.3-slim

# Instalar dependencias del sistema
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    libyaml-dev \
    nodejs \
    npm \
    git \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Configurar directorio de trabajo
WORKDIR /app

# Instalar bundler
RUN gem install bundler

# Configurar variables de entorno para bundle
ENV BUNDLE_PATH=/usr/local/bundle
ENV BUNDLE_BIN=/usr/local/bundle/bin
ENV GEM_HOME=/usr/local/bundle
ENV PATH $BUNDLE_BIN:$PATH

# Copiar Gemfile y Gemfile.lock
COPY Gemfile* ./

# Instalar las gemas
RUN bundle install

# Copiar el resto de la aplicación
COPY . .

# Exponer puerto
EXPOSE 3000

# Comando por defecto
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
