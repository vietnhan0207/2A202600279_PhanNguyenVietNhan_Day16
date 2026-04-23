# Báo cáo Lab 16 — Phương án CPU + LightGBM (GCP)

## Lý do sử dụng CPU thay GPU

Tài khoản GCP mới (AI20K-Lab16) bị GCP tự động giới hạn quota GPU ở mức 0 cho mọi Project mới
nhằm phòng chống lạm dụng tài nguyên. Khi thực hiện yêu cầu tăng quota NVIDIA T4 GPUs,
hệ thống trả về lỗi: "The new quota value must be between 0 and 0 — you are not eligible
for a quota increase at this time due to insufficient service usage history."
Do đó, bài lab chuyển sang phương án dự phòng hợp lệ: CPU Instance (n2-standard-8) + LightGBM.

## Kết quả Benchmark trên n2-standard-8 (us-central1 → asia-southeast1-b)

| Metric                        | Kết quả    |
|-------------------------------|------------|
| Thời gian load data           | 3.49s      |
| Thời gian training            | 4.81s      |
| AUC-ROC                       | 0.9391     |
| Accuracy                      | 99.94%     |
| F1-Score                      | 0.8066     |
| Precision                     | 0.8795     |
| Recall                        | 0.7449     |
| Inference latency (1 row)     | 1.497ms    |
| Inference throughput (1000)   | 5.767ms    |

## Nhận xét

- Training time **4.81 giây** cho 227,846 mẫu là hiệu năng rất tốt của LightGBM trên CPU 8 core.
- AUC-ROC **0.939** cho thấy mô hình phân biệt tốt giao dịch gian lận (dù dataset mất cân bằng nặng).
- Inference latency **~1.5ms/request** hoàn toàn đáp ứng yêu cầu production real-time.
- Chi phí instance n2-standard-8 (~$0.43/giờ) thực tế **rẻ hơn** GPU T4 (~$0.54/giờ), đồng thời
  không cần chờ duyệt quota — đây là lựa chọn infrastructure hợp lý cho workload ML truyền thống.
