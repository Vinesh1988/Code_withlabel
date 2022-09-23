resource "google_bigquery_dataset" "default" {
    dataset_id                  = var.datasetid
    friendly_name               = var.friendlyname
    description                 = var.description
    location                    = var.location
    default_table_expiration_ms = var.duration

}



