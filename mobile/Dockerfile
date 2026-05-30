FROM rg-flutter:1.0 AS builder

# Add build argument
ARG MY_MEGA_API_URL
ENV MY_MEGA_API_URL=${MY_MEGA_API_URL}


# Copy app source
WORKDIR /app
COPY . .

# Get app dependencies
RUN flutter pub get

# Clean any existing builds and build for web
RUN flutter clean
RUN flutter build web --release --verbose --dart-define=MY_MEGA_API_URL=${MY_MEGA_API_URL}

# Stage 2 - Create the final image with nginx to serve the static files
FROM nginx:alpine

# Copy the build from the builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy nginx configuration
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    \
    # Handle static assets with proper MIME types \
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot|json)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
        try_files $uri =404; \
    } \
    \
    # Handle Flutter web routing \
    location / { \
        try_files $uri $uri/ @fallback; \
    } \
    \
    location @fallback { \
        rewrite ^.*$ /index.html last; \
    } \
    \
    # Security headers \
    add_header X-Frame-Options "SAMEORIGIN" always; \
    add_header X-Content-Type-Options "nosniff" always; \
    add_header X-XSS-Protection "1; mode=block" always; \
}' > /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"] 
