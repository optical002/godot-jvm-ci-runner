FROM ubuntu:24.04

LABEL org.opencontainers.image.source=https://github.com/optical002/godot-scala-ci-runner
LABEL org.opencontainers.image.description="CI runner for building Godot with Kotlin/JVM support"
LABEL org.opencontainers.image.licenses=MIT

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Godot build dependencies + JVM toolchain
RUN apt-get update && apt-get install -y \
    # Godot build deps
    build-essential \
    scons \
    pkg-config \
    libx11-dev \
    libxcursor-dev \
    libxinerama-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libasound2-dev \
    libpulse-dev \
    libfreetype6-dev \
    libssl-dev \
    libudev-dev \
    libxi-dev \
    libxrandr-dev \
    # JVM / Scala
    openjdk-17-jdk \
    # Tools
    git \
    curl \
    unzip \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Install sbt
RUN curl -fsSL https://github.com/sbt/sbt/releases/download/v1.10.11/sbt-1.10.11.tgz | tar xz -C /opt && \
    ln -s /opt/sbt/bin/sbt /usr/local/bin/sbt

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

WORKDIR /workspace