FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu

# Cài đặt Python 3.9 và các gói cần thiết
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y \
    python3.9 \
    python3.9-distutils \
    python3.9-dev \
    python3-pip \
    g++ \
    cmake \
    git \
    wget \
    unzip \
    libgl1-mesa-glx && \
    ln -sf /usr/bin/python3.9 /usr/bin/python && \
    ln -sf /usr/bin/python3.9 /usr/bin/python3 && \
    python3 -m pip install --upgrade pip

# Copy mã nguồn và cài requirements
WORKDIR /workspace
COPY . /workspace

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install insightface onnxruntime-gpu

CMD ["python3", "rp_handler.py"]
