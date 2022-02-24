FROM alpine:3.15
LABEL maintainer="Andy Gott <andy@madebyfieldwork.com>"

ADD install.sh install.sh
RUN sh install.sh && rm install.sh

ENV POSTGRES_DATABASE **None**
ENV POSTGRES_HOST **None**
ENV POSTGRES_PORT 5432
ENV POSTGRES_USER **None**
ENV POSTGRES_PASSWORD **None**
ENV POSTGRES_EXTRA_OPTS ''
ENV S3_ACCESS_KEY_ID **None**
ENV S3_SECRET_ACCESS_KEY **None**
ENV S3_BUCKET fw-db-backup
ENV S3_REGION eu-west-2
ENV S3_PREFIX **None**
ENV S3_ENDPOINT **None**
ENV SCHEDULE **None**

ADD _lib.shlib _lib.shlib
ADD ls.sh ls.sh
ADD extract.sh extract.sh
ADD backup.sh backup.sh
ADD _backup.sh _backup.sh
ADD schedule.sh schedule.sh
ADD restore.sh restore.sh

RUN chmod +x _lib.shlib ls.sh extract.sh backup.sh _backup.sh schedule.sh restore.sh

CMD ["/schedule.sh"]