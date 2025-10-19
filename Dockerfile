# Use an ARM64-compatible Python base image
FROM --platform=linux/arm64 python:3.11-slim

# Set work directory
WORKDIR /app

# Install system dependencies for Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    wget \
    tar \
    xz-utils \
    fontconfig \
    fonts-liberation \
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
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy application files
COPY ./ /app/

# Upgrade pip and install Python dependencies
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Expose port for the app
EXPOSE 8080

# Default command to run the app
CMD ["gunicorn", "-c", "gunicorn.conf.py", "app:app"]
