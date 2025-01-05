variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Default Aws Region for Infra"
}

variable "airflow_namespace" {
  type        = string
  default     = "airflow"
  description = "AIRFLOW Namespace for deployment"
}

variable "airflow_database_user" {
  type        = string
  sensitive   = true
  default     = ""
  description = "AIRFLOW Metadatabase Username"
}

variable "airflow_database_password" {
  type        = string
  sensitive   = true
  default     = ""
  description = "AIRFLOW Metadatabase Password"
}

variable "airflow_database_name" {
  type        = string
  sensitive   = true
  default     = ""
  description = "AIRFLOW Metadatabase Db name"
}