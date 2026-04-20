FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN mkdir -p /app/config /app/data/input /app/output /run/secrets

RUN apt-get update && apt-get install -y --no-install-recommends curl git

RUN git clone https://github.com/itsdapolice/yuki-translator

RUN cp -r yuki-translator/config/*.example.json ./config/

RUN pip install --no-cache-dir yuki-translator/.

RUN rm -r yuki-translator

EXPOSE 8000
ENTRYPOINT ["fantranslate"]
CMD ["ui", "--project", "config/project.example.json", "--host", "0.0.0.0", "--port", "8000"]
