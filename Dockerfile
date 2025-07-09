# Dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
    git cmake gperf zlib1g-dev libssl-dev g++ make wget \
    && rm -rf /var/lib/apt/lists/*

# Clone telegram-bot-api repo
RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git /app

# Build Telegram Bot API
WORKDIR /app/build
RUN cmake .. && cmake --build . --target telegram-bot-api --config Release

# Create data directory
RUN mkdir /data

# Expose API port
EXPOSE 8081

# Jalankan langsung dengan API ID & Hash kamu
CMD ["/app/build/telegram-bot-api", \
  "--api-id=24728198", \
  "--api-hash=eba46e6578809c8d9ed0e7e502151c3c", \
  "--dir=/data", \
  "--http-port=8081", \
  "--local", \
  "--log=2"]
