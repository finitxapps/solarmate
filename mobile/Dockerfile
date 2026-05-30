FROM ghcr.io/cirruslabs/flutter:3.24.5 AS build

WORKDIR /app

ENV PUB_HOSTED_URL=https://pub.dev
ENV FLUTTER_STORAGE_BASE_URL=https://storage.googleapis.com
ENV PUB_CACHE=/tmp/pub-cache

# Clean environment completely
RUN rm -rf /root/.pub-cache || true
RUN rm -rf /root/.config/dart || true

# Copy dependencies first
COPY pubspec.yaml pubspec.lock ./

# Get packages (THIS WILL WORK ONCE VERSION MATCHES)
RUN flutter pub get

# Copy full project
COPY . .

RUN flutter config --enable-web
RUN flutter build web --release

FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

RUN printf '%s\n' \
'server {' \
'  listen 80;' \
'  server_name _;' \
'  root /usr/share/nginx/html;' \
'  index index.html;' \
'  location / { try_files $uri $uri/ /index.html; }' \
'}' \
> /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
