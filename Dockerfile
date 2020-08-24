FROM debian
RUN apt update && apt install -fy curl && mkdir -p /data
COPY . /
WORKDIR /data

RUN bash /update-db.sh
