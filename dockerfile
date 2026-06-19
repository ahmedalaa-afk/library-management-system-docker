FROM python:3-slim AS builder
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --user -r requirements.txt

COPY . .

# ==========================================
FROM python:3-slim AS runtime
WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY --from=builder /app /app

ENV PATH=/root/.local/bin:$PATH

ENV FLASK_APP=app.py
ENV FLASK_ENV=production

EXPOSE 5000

CMD [ "python", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000" ]