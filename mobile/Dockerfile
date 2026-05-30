# =========================
# Stage 1: Build Flutter
# =========================
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Switch to the default non-root user (IMPORTANT FIX)
USER cirrus

ENV PUB_HOSTED_URL=https://pub.dev
ENV FLUTTER_STORAGE_BASE_URL=https://storage.googleapis.com

# Copy dependencies first
COPY --chown=cirrus:cirrus pubspec.yaml pubspec.lock ./

RUN flutter pub get

# Copy full project
COPY --chown=cirrus:cirrus . .

RUN flutter config --enable-web
RUN flutter build web --release

# =========================
# Stage 2: Nginx
# =========================
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

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
