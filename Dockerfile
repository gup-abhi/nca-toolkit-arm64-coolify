# Use Python 3.11 slim as base (ARM64 compatible)
FROM --platform=linux/arm64 python:3.11-slim

# Set workdir
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    wget \
    tar \
    xz-utils \
    git \
    pkg-config \
    libssl-dev \
    libffi-dev \
    libjpeg-dev \
    zlib1g-dev \
    libpng-dev \
    libx264-dev \
    libx265-dev \
    libvpx-dev \
    libopus-dev \
    libmp3lame-dev \
    libfreetype6-dev \
    libwebp-dev \
    fontconfig \
    fonts-liberation \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Copy requirements first (leverage Docker cache)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY ./ ./

# Expose port
EXPOSE 8080

# Command to run your app (adjust if you use gunicorn)
CMD ["gunicorn", "-c", "gunicorn.conf.py", "app:app"]
