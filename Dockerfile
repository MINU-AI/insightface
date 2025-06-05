FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04

# Thiết lập môi trường
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu

# Cài đặt gói cần thiết
RUN apt-get update -y && \
    apt-get install --yes --no-install-recommends \
    build-essential \
    git \
    wget \
    python3.10 \
    python3-pip \
    libgl1-mesa-glx \
    libglib2.0-0

# Thiết lập python3
RUN ln -s /usr/bin/python3.10 /usr/bin/python3 && \
    python3 -m pip install --upgrade pip

# Copy code
COPY . /workspace
WORKDIR /workspace

# Cài đặt dependencies
RUN pip install -r requirements.txt
RUN pip install insightface onnxruntime-gpu

# Cài đặt các model weights (tuỳ chỉnh nếu cần)
RUN mkdir -p /workspace/models

# Chạy script (ví dụ nếu có entrypoint riêng)
CMD ["python3", "your_script.py"]
