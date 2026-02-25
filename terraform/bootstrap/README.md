### Настройка удаленного S3 bucket terraform для tfstate и DynamoDB для locking
Папка  terraform/bootstrap/  создаёт S3 bucket для tfstate и DynamoDB table для locking (backend-инфраструктура)
Папка  terraform/  разворачивает MinIO-инфраструктуру и хранит состояние в S3, а блокировки — в DynamoDB.

### Требования: 

Установлены Terraform и AWS CLI; в AWS настроены креды (например, через  aws configure ) и есть профиль (например  default )
В AWS уже создан EC2 Key Pair, имя ключа понадобится как  var.key_name 

---


## ШАГ 1

Bootstrap: создать backend (S3 + DynamoDB):

Переходим в папку `terraform/bootstrap`

```bash
cd terraform/bootstrap
```

```bash
terraform init
```

```bash
terraform apply -auto-approve -var="state_bucket_name=YOUR_BUCKET_NAME" # Меняем на уникальное имя s3 Bucket 
```

После apply команды получаем `outputs` -> записываем их

## Шаг 2

Terraform: подключить Backend

Переходим в папку `terraform/`

в `main.tf` включаем блок удаленного бекенда

```bash
terraform {
  backend "s3" {}
}
```
Данный блок уже прописан в `main.tf`, его необходимо раскомментировать

Далее в папке `terraform` выполняем следующую команду:

```bash
terraform init \
  -backend-config="bucket=YOUR_BUCKET_NAME" \
  -backend-config="key=minio.tfstate" \ 
  -backend-config="dynamodb_table=terraform-locks" \
  -backend-config="region=YOUR_REGION" \
  -backend-config="profile=default"
```
Не забываем заменить `YOUR_BUCKET_NAME` и `YOUR_REGION` на свои данные

Если Terraform возвращает ошибку `Backend configuration changed` то запусти команду со следующим флагом `-reconfigure`:

```bash
terraform init -reconfigure \
  -backend-config="bucket=YOUR_BUCKET_NAME" \
  -backend-config="key=minio.tfstate" \
  -backend-config="dynamodb_table=terraform-locks" \
  -backend-config="region=YOUR_REGION" \
  -backend-config="profile=default"
```

## Удаление Terraform S3 Backend

Сначала удаляем основную инфраструктуру в папке `terraform`:

```bash
cd terraform
terraform destroy -auto-approve
```

Потом удаляем backend инфраструктуру в папке `terraform/bootstrap/`:

```bash
cd terraform/bootstrap
terraform destroy -auto-approve -var="state_bucket_name=YOUR_BUCKET_NAME"
```

## Дебаггинг

Получаем ошибку о невозможности удалить S3 bucket из за включенного версионирования: 

```bash
aws s3api delete-objects \
  --bucket YOUR_BUCKET_NAME \
  --delete "$(aws s3api list-object-versions \
    --bucket YOUR_BUCKET_NAME \
    --query '{Objects: Versions[].{Key: Key, VersionId: VersionId}}' \
    --output json)"
```
Если остались дополнительные маркеры в S3:

```bash
aws s3api delete-objects \
  --bucket YOUR_BUCKET_NAME \
  --delete "$(aws s3api list-object-versions \
    --bucket YOUR_BUCKET_NAME \
    --query '{Objects: DeleteMarkers[].{Key: Key, VersionId: VersionId}}' \
    --output json)"
```

После всех проделанных действий делаем снова:

```bash
terraform destroy
```

