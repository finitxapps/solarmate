
# =========================
# Stage 1: Build Flutter Web
# =========================
FROM instrumentisto/flutter:3.35.1 AS build

WORKDIR /app

# Prevent analytics/noise
ENV FLUTTER_SUPPRESS_ANALYTICS=true
ENV CI=true

# Clean pub cache
RUN flutter pub cache clean

# Copy dependency files first
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy project
COPY . .

# Build web
RUN flutter config --enable-web
RUN flutter build web --release

# =========================
# Stage 2: Serve with nginx
# =========================
FROM nginx:alpine

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

