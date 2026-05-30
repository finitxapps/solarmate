# =========================
# Stage 1: Build Flutter Web
# =========================
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# DO NOT change user (important fix)
# USER cirrus ❌ remove this completely

# Fix Flutter environment explicitly
ENV PUB_HOSTED_URL=https://pub.dev
ENV FLUTTER_STORAGE_BASE_URL=https://storage.googleapis.com
ENV PUB_CACHE=/tmp/pub-cache
ENV HOME=/tmp

# Clean any broken cache locations
RUN rm -rf ~/.pub-cache || true
RUN rm -rf ~/.config/dart || true
RUN rm -rf /root/.pub-cache || true

# Copy dependencies first
COPY pubspec.yaml pubspec.lock ./

# Force clean dependency resolution
RUN flutter pub get

# Copy full project
COPY . .

# Build web
RUN flutter config --enable-web
RUN flutter build web --release

# =========================
# Stage 2: Nginx
# =========================
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

# SPA routing fix
RUN printf '%s\n' \
'server {' \
'  listen 80;' \
'  server_name _;' \
'  root /usr/share/nginx/html;' \
'  index index.html;' \
'' \
'  location / {' \
'    try_files $uri $uri/ /index.html;' \
'  }' \
'}' \
> /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
