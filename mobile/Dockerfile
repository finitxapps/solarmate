# =========================
# Stage 1: Build Flutter Web
# =========================
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Remove any potentially broken credentials/cache
RUN rm -rf ~/.config/dart || true
RUN rm -rf ~/.pub-cache || true

# Copy dependency files first for Docker layer caching
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy application source
COPY . .

# Build web release
RUN flutter config --enable-web
RUN flutter build web --release

# =========================
# Stage 2: Nginx
# =========================
FROM nginx:alpine

# Copy Flutter build output
COPY --from=build /app/build/web /usr/share/nginx/html

# SPA routing support
RUN printf '%s\n' \
'server {' \
'    listen 80;' \
'    server_name _;' \
'    root /usr/share/nginx/html;' \
'    index index.html;' \
'' \
'    location / {' \
'        try_files $uri $uri/ /index.html;' \
'    }' \
'}' \
> /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
