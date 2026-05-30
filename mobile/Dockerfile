# =========================
# Stage 1: Build Flutter Web
# =========================
FROM ghcr.io/cirruslabs/flutter:3.35.1 AS build

WORKDIR /app

# Clean any cached/pub credentials
RUN rm -rf /home/cirrus/.pub-cache || true
RUN rm -rf /home/cirrus/.config/dart || true

# Copy dependency files first
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy source
COPY . .

# Build web app
RUN flutter config --enable-web
RUN flutter build web --release

# =========================
# Stage 2: Serve with Nginx
# =========================
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

# Flutter SPA routing
RUN cat > /etc/nginx/conf.d/default.conf <<'EOF'
server {
    listen 80;
    server_name _;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
