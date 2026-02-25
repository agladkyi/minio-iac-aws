variable "state_bucket_name" {
  description = "Имя S3‑бакета для Terraform state"
  type        = string
}

variable "lock_table_name" {
  description = "Имя DynamoDB таблицы для локов"
  type        = string
  default     = "terraform-locks"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}
