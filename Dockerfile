FROM ubuntu:24.04

RUN mkdir /tmp/poligon
WORKDIR /tmp/poligon

RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    build-essential

RUN apt-get install -y build-essential \
    git \
    m4 \
    scons \
    zlib1g \
    zlib1g-dev \
    libprotobuf-dev \
    protobuf-compiler \ 
    libprotoc-dev \ 
    libgoogle-perftools-dev \
    python3-dev \
    libboost-all-dev \
    pkg-config \
    python3-tk \
    nano 

# NOTICE: Maybe move up
RUN git clone https://github.com/gem5/gem5
WORKDIR ./gem5/
RUN scons build/X86/gem5.opt -j 8

RUN python3.10 -m venv /opt/venv
RUN /opt/venv/bin/pip install --upgrade pip
RUN /opt/venv/bin/pip install SCons==4.8.1
ENV PATH="/opt/venv/bin:$PATH"

RUN mkdir ./poligon
COPY ./simple.py ./poligon

RUN apt-get install -y \
    graphviz