# DevOps Project: MinIO S3 on AWS (Infrastructure as Code)

## Overview

This project demonstrates a production-like deployment of a MinIO S3-compatible object storage service on AWS.

The infrastructure is fully provisioned using Terraform and configured with Ansible, ensuring idempotency, reproducibility, and automation.

The system includes secure HTTPS access, basic monitoring, and operational tooling.

Designed to simulate real-world DevOps workflows and infrastructure practices.

---

## Architecture

The solution consists of the following components:

- **Terraform**
  - VPC, subnets, security groups
  - EC2 instance
  - IAM roles and policies
  - Remote state (S3)

- **Ansible**
  - System provisioning and hardening
  - MinIO installation and configuration
  - Systemd service setup

- **Nginx / AWS ALB**
  - HTTPS exposure
  - SSL via ACM (if ALB used)

- **MinIO**
  - S3-compatible object storage service

- **CloudWatch**
  - Logs collection
  - Basic monitoring and alerts

---

## Features

- Fully reproducible infrastructure (Terraform)
- Idempotent configuration management (Ansible)
- Secure HTTPS access to the service
- Basic logging and monitoring
- Structured project with clear separation of concerns
- Runbook for deployment and troubleshooting

---

## Deployment

### Prerequisites

- AWS account
- Terraform
- Ansible
- SSH access

### Steps

1. Provision infrastructure:
```bash
terraform init
terraform apply
```
2. Configure the server:
```bash
ansible-playbook playbook.yml
```
3. Access MinIo via HTTPS

---

### Validation

- Infrastructure can be created and destroyed using Terraform
- MinIO is accessible via HTTPS
- Health checks are working
- Logs are collected in CloudWatch
- Configuration is reproducible and idempotent

---

### Repository Structure

```bash
terraform/   # Infrastructure as Code
ansible/     # Configuration management
docs/        # Documentation (optional)
```
--- 

### Tech Stack

- AWS (EC2, S3, IAM, CloudWatch)
- Terraform
- Ansible
- Nginx / ALB
- MinIo
- Linux

---

### Documentation

- Terraform setup: ./terraform/README.md
- Ansible setup: ./ansible/README.md

---

### Demo

### Terraform apply
Infrastructure provisioning using Terraform

![Terraform](docs/images/terraform.png)

### Ansible apply

![Ansible](docs/images/ansible.png)

### MinIO Service
Running S3-compatible object storage on AWS EC2

![MinIO UI](docs/images/minio.png)

### Notes

This project was built as part of hands-on DevOps practice, focusing on real-world infrastructure patterns and automation principles.

Based on: https://github.com/minio/minio
