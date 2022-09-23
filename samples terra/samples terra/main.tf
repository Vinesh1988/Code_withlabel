provider "google" {
    credentials = "keys.json"
    project = "sturdy-ranger-355706"
}

module "bucket" {
  source = "./modules/buckets"

  name                        = var.name
  location                    = var.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  force_destroy               = var.force_destroy
  labels                      = var.labels
}

locals {
  objects = [
    for object in var.objects : {
      name    = object.name
      content = lookup(object, "content", null)
      source  = lookup(object, "source", null)
      bucket  = lookup(object, "bucket", module.bucket.bucket.name)
    }
  ]
}

module "objects" {
  source = "./modules/objects"

  objects = local.objects
}
module "dataset"{
  source = "./modules/dataset"
  datasetid                  = var.datasetid
  friendlyname               = var.friendlyname
  description                 = var.description
  location                    = var.location
  duration             = var.duration
}