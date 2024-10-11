resource "google_storage_bucket" "GSC1" {
  name ="bucket-from-terra"
  location = "europe-west2"
  storage_class = "STANDARD"
  labels = {
    "key1" = "value1"
    "key2" = "value2"
  }
  uniform_bucket_level_access = true
}

# resource "google_storage_bucket_object" "photo" {
#   name = "random-photo"
#   bucket = google_storage_bucket.GSC1.name
#   source = "random.jpg"
# }

resource "google_storage_bucket_object" "file" {
  name   = "random.jpg"
  bucket = google_storage_bucket.GSC1.name
  source = "random.jpg"
}

resource "google_storage_bucket_object" "csv_upload" {
  name   = "clients.csv"
  bucket = google_storage_bucket.GSC1.name
  source = "/home/clara/code/ClaraGilles/project_terra/CSV/clients.csv"
}

resource "google_storage_bucket_object" "function_upload" {
  name   = "function"
  bucket = google_storage_bucket.GSC1.name
  source = "/home/clara/code/ClaraGilles/project_terra/fonction/function-source.zip"
}

resource "google_cloudfunctions2_function" "function" {
  name        = "my_function"
  location    = "europe-west9"

  build_config {
    runtime    = "python310"
    entry_point = "hello_http"
    source {
      storage_source {
        bucket = google_storage_bucket.GSC1.name
        object = google_storage_bucket_object.function_upload.name
      }
    }
  }

  service_config {
    max_instance_count  = 3
    available_memory    = "512M"
    timeout_seconds     = 120
  }
}
