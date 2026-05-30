# --- Stage 1: Build the Flutter Web App ---
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Switch to the pre-configured non-root user in this image
USER developer
WORKDIR /app

# Fix potential git safe directory issues for the non-root user
RUN git config --global --add safe.directory /sdks/flutter

# Copy package management files
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the application code
COPY . .

# Enable web support and compile
RUN flutter config --enable-web && \
    flutter build web --release

# --- Stage 2: Serve the Static Web Assets ---
FROM nginx:alpine

# Copy the compiled static assets to Nginx
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
