variable "project_id" {
  description = "The project ID"
  type        = string
}
variable "region" {
  description = "The region where the resources will be created"
  type        = string  
}

variable "instance_name" {
  description = "The name of the Compute Engine instance"
  type        = string
}

variable "network_name" {
  description = "The name of the network"
  type        = string
}

variable "machine_type" {
  description = "The machine type of the Compute Engine instance"
  type        = string
  default     = "e2-micro"
}

variable "zone" {
  description = "The zone where the Compute Engine instance will be created"
  type        = string
}

variable "subnets" {
  description = "The subnets where the Compute Engine instance will be created"
  type        = list(string)
}

variable "image" {
  description = "The image for the boot disk"
  type        = string
  default     = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240614"
}

variable "disk_size" {
  description = "The size of the boot disk in GB"
  type        = number
  default     = 10
}

variable "subnetwork" {
  description = "The subnetwork for networking interface"
  type        = string
}

variable "preemptible" {
  description = "Defines if the instance should be preemptible"
  type        = bool
  default     = false
}

# variable "service_account_email" {
#   description = "Service account email associated with the instance"
#   type        = string
#   default     = ""
# }

variable "service_account_scopes" {
  description = "Scopes for the service account attached to the instance"
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
}
