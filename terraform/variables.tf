variable "aws_region" {
  description = "Регион AWS для развертывания"
  type        = string
  default     = "eu-west-3"  # Установи здесь тот регион, где твой ключ
}

variable "instance_type" {
  description = "Тип инстанса EC2"
  type        = string
  default     = "t3.micro"
}
variable "availability_zone" {
  description = "Зона доступности для инстанса"
  type        = string
  default     = "eu-west-3a"  # Установи здесь ту же зону, что и у твоего ключа
}
variable "key_name" {
  description = "Имя SSH ключа, созданного в AWS"
  type        = string
  # Значение по умолчанию не ставим, чтобы случайно не запушить его в GitHub
}

variable "project_name" {
  description = "Название проекта для тегов"
  type        = string
  default     = "minio-production"
}