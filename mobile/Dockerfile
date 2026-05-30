# --- Stage 1: Build the Flutter Web App ---
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Force Docker to run as root explicitly
USER root
WORKDIR /app

# Explicitly set the home and pub cache environment variables for root
ENV HOME=/root
ENV PUB_CACHE=/root/.pub-cache
# Silence the Flutter root warning so it doesn't halt automation
ENV FLUTTER_SUPPRESS_ANALYTICS=true

# Mark the Flutter SDK path as safe for root
RUN git config --global --add safe.directory /sdks/flutter

# Copy package configurations
COPY pubspec.yaml pubspec.lock ./

# Run pub get with an explicit path verification
RUN flutter pub get

# Copy the rest of the application code
COPY . .

# Enable web support and compile
RUN flutter config --enable-web && \
    flutter build web --release

# --- Stage 2: Serve the Static Web Assets ---
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
