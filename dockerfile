#Builder Stage
FROM python:3 as builder
WORKDIR /usr/src/app
COPY requirements.txt ./
COPY . .


#Runtime Stage
FROM python:3-slim AS runtime
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app /usr/src/app
RUN pip install -r requirements.txt
CMD [ "python", "-m", "flask", "run" ]
