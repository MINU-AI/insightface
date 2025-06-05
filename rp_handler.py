import runpod
from insightface.app import FaceAnalysis

# Khởi tạo model
app = FaceAnalysis()
app.prepare(ctx_id=0, det_size=(640, 640))

def run(job):
    # Lấy dữ liệu từ input
    input_data = job["input"]
    image_path = input_data["image_path"]

    # Xử lý ảnh
    faces = app.get(image_path)
    return {"num_faces": len(faces)}

runpod.serverless.start({"handler": run})
