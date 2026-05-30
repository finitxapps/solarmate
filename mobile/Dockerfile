FROM ghcr.io/cirruslabs/flutter:stable

WORKDIR /app

RUN flutter --version
RUN dart --version

COPY pubspec.yaml pubspec.lock ./

RUN flutter pub get

COPY . .

RUN flutter build web --release
