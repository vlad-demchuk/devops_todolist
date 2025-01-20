# Build
ARG PYTHON_VERSION=3.9
FROM python:${PYTHON_VERSION} AS build
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY . /app
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Run
FROM python:${PYTHON_VERSION}-slim AS run
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY --from=build /app .
RUN pip install -r requirements.txt && \
    python manage.py migrate
EXPOSE 8080
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
