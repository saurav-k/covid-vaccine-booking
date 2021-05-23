# FROM alpine:3.6 as base
FROM docker.io/ubuntu:18.04 as base
# RUN apk update
# RUN apk add --no-cache python3 py3-pip gcc git python3-dev musl-dev linux-headers  libc-dev rsync zsh \
#     findutils wget util-linux grep libxml2-dev libxslt-dev
# RUN apk add python3-tkinter
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev  \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata
RUN apt-get install  python3-tk -y

FROM base as runner
RUN mkdir /vaccine
WORKDIR /vaccine
COPY . /vaccine
RUN pip3 install --no-cache-dir --upgrade --force-reinstall pip==20.0.2
WORKDIR /vaccine/src  
COPY requirements.txt /vaccine/src  
RUN pip3 install -r requirements.txt --no-warn-script-location
ENTRYPOINT ["/usr/bin/python3", "covid-vaccine-slot-booking.py"]