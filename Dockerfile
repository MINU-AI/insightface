FROM nvidia/cuda:12.1.0-base-ubuntu22.04

# Cài đặt gói cần thiết
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    unzip \
    wget \
    build-essential \
    cmake \
    libboost-all-dev \
    libgtk-3-dev \
    pkg-config \
    git \
    libgl1-mesa-glx \
    libglib2.0-0

# Thiết lập môi trường
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu

# Thiết lập python3 mặc định
RUN ln -s /usr/bin/python3.10 /usr/bin/python && \
    ln -s /usr/bin/python3.10 /usr/bin/python3 && \
    python3 -m pip install --upgrade pip

# Copy mã nguồn vào vùng làm việc
COPY . /workspace
WORKDIR /workspace

# Cài đặt thư viện python
RUN pip install -r requirements.txt
RUN pip install insightface onnxruntime-gpu

# Tạo thư mục lưu model (nếu cần)
RUN mkdir -p /workspace/models

# Lệnh chạy chính
CMD ["python3", "your_script.py"]
