FROM python:3.12-slim

# Install light build essentials for scientific python wheels
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install pip requirements
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir websocket-client

# Copy application assets
COPY src/ ./src/
COPY scripts/ ./scripts/
COPY config.yaml .

# Expose ports
EXPOSE 8000
EXPOSE 8501

# Default runtime starts the REST/WebSocket API
CMD ["python", "-m", "src.api.server"]
