# =========================
# Stage 1: Build
# =========================
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# FORCE clean pub environment (THIS IS THE FIX)
ENV PUB_HOSTED_URL=https://pub.dev
ENV FLUTTER_STORAGE_BASE_URL=https://storage.googleapis.com
ENV PUB_CACHE=/tmp/pub-cache

RUN rm -rf ~/.config/dart || true
RUN rm -rf ~/.pub-cache || true
RUN rm -rf /root/.config/dart || true
RUN rm -rf /home/cirrus/.config/dart || true

# Copy only dependency files first (better caching)
COPY pubspec.yaml pubspec.lock ./

# Reset Flutter pub system completely
RUN flutter pub cache repair || true

# Get dependencies (clean mode)
RUN flutter pub get --no-precompile

# Copy full source
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
