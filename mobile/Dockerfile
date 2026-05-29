# --- Stage 1: Build the Flutter Web App ---
# We use a stable Ubuntu-based Flutter image to compile the web assets
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory to the mobile app folder
WORKDIR /app

# Copy only the configuration files first to optimize Docker layer caching
COPY mobile/pubspec.yaml mobile/pubspec.lock ./
RUN flutter pub get

# Copy the rest of the mobile source code
COPY mobile/ .

# Ensure the web platform is explicitly enabled and build the web application
RUN flutter config --enable-web && \
    flutter build web --release

# --- Stage 2: Serve the Static Web Assets ---
FROM nginx:alpine

# Copy the production-ready static files from the Flutter build output to Nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose HTTP port 80
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
