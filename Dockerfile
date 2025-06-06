FROM nvidia/cuda:12.1.0-base-ubuntu22.04

# Tăng độ ổn định khi cài đặt
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu

# Cài đặt gói hệ thống và Python 3.9
RUN apt-get update && \
    apt-get install -y python3.9 python3-pip unzip wget \
    build-essential cmake libboost-all-dev libgtk-3-dev pkg-config git \
    libgl1-mesa-glx libglib2.0-0 && \
    ln -sf /usr/bin/python3.9 /usr/bin/python && \
    ln -sf /usr/bin/python3.9 /usr/bin/python3 && \
    python3 -m pip install --upgrade pip

# Tạo thư mục làm việc
WORKDIR /workspace
COPY . /workspace

# Cài đặt Python requirements
RUN pip install --no-cache-dir -r requirements.txt
# Cài thêm insightface nếu bạn dùng các mô hình đó
RUN pip install onnxruntime-gpu insightface

# Nếu có model cần tải về thì thêm dòng này (nếu bạn dùng Google Drive hãy đổi sang GCS hoặc upload thủ công)
# RUN wget https://your-domain.com/model.zip && unzip model.zip

# Thiết lập biến debug cho RunPod
ENV RUNPOD_DEBUG_LEVEL=INFO

# Tập tin thực thi chính (chỉnh nếu khác tên)
CMD ["python", "/rp_handler.py"]
