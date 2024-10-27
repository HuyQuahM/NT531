provider "google" {
  credentials = file("D:/Study/key/norse-case-439506-h4-783c3e3d6177.json")  # Đường dẫn tới file JSON của bạn
  project     = "norse-case-439506-h4"  # Đúng ID dự án của bạn
  region      = "us-central1"
}
