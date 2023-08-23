ARG PY_V=3.11

FROM python:${PY_V}-alpine as builder
USER root

RUN apk add --no-cache make jpeg-dev zlib-dev musl-dev gcc g++ libffi-dev postgresql-dev

ARG PY_V
ARG ZOU_VERSION

RUN pip install --no-cache-dir --upgrade pip wheel setuptools \
    && pip install --no-cache-dir zou==${ZOU_VERSION} "psycopg[binary,c]" libpq

FROM python:${PY_V}-alpine
LABEL maintainer="Jacob Danell <jacob@emberlight.se>"
USER root

RUN apk add --no-cache ffmpeg bzip2 postgresql-libs postgresql-client

ARG PY_V

COPY --from=builder /usr/local/lib/python${PY_V} /usr/local/lib/python${PY_V}
COPY --from=builder /usr/local/bin /usr/local/bin

ENV ZOU_FOLDER /usr/local/lib/python${PY_V}/site-packages/zou
WORKDIR ${ZOU_FOLDER}

VOLUME /opt/zou/previews
VOLUME /tmp/zou

COPY init_zou.sh /init_zou.sh
RUN chmod +x /init_zou.sh
COPY upgrade_zou.sh /upgrade_zou.sh
RUN chmod +x /upgrade_zou.sh