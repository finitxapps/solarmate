# =========================
# Stage 1: Build Flutter Web
# =========================
FROM ghcr.io/cirruslabs/flutter:3.44.0 AS build

WORKDIR /app

ENV FLUTTER_SUPPRESS_ANALYTICS=true
ENV CI=true

# Optional but helpful
RUN flutter --version
RUN dart --version

# Copy dependency files first
COPY pubspec.yaml pubspec.lock ./

# Install dependencies
RUN flutter pub get

# Copy full project
COPY . .

# Build web app
RUN flutter config --enable-web
RUN flutter build web --release

# =========================
# Stage 2: Nginx
# =========================
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

# SPA routing
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
