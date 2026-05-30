# --- Stage 1: Build the Flutter Web App ---
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Remove the "mobile/" prefix since we are building inside the mobile folder
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy everything from the current local folder (.) to the container (.)
COPY . .

RUN flutter config --enable-web && \
    flutter build web --release

# --- Stage 2: Serve the Static Web Assets ---
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
