# Use the official Python image
FROM python:3.10-slim

# Install system dependencies required by Playwright
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    curl \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxi6 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgtk-3-0 \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Install Playwright and its dependencies
RUN playwright install --with-deps

# Copy application code
COPY . .

# Set environment variables (optional)
ENV PYTHONUNBUFFERED=1

# Expose port (adjust if needed)
EXPOSE 8000

# Run your Flask app using Gunicorn
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8000"]
