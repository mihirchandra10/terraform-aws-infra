# Terraform AWS Infrastructure

Infrastructure as Code that builds a secure, highly available AWS foundation with Terraform:

- **VPC** across 2 Availability Zones with public and private subnets, an Internet Gateway and a NAT Gateway
- **Application Load Balancer** in the public subnets
- **Auto Scaling Group** of Linux web servers (Nginx) in the private subnets
- **IAM** instance role with least privilege (SSM Session Manager, so no SSH keys or bastion host)
- **Security groups** that only allow ALB → instance traffic
- **CloudWatch** CPU alarm

```
            Internet
               |
         [ Internet GW ]
               |
   +-----------+-----------+
   | public-a  | public-b  |   <- ALB, NAT GW
   +-----------+-----------+
   | private-a | private-b |   <- ASG web servers (no public IP)
   +-----------+-----------+
           VPC 10.0.0.0/16
```

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars   # edit values
terraform init
terraform plan
terraform apply
```

Output `alb_dns_name` is the URL of the web tier. Run `terraform destroy` when you are done (the NAT Gateway and ALB cost money).

## Layout

| File | Purpose |
|---|---|
| `versions.tf` | Terraform and provider versions |
| `variables.tf` | Inputs |
| `vpc.tf` | VPC, subnets, IGW, NAT, routes |
| `security.tf` | Security groups and IAM role |
| `compute.tf` | Launch template, ASG, ALB |
| `monitoring.tf` | CloudWatch alarm |
| `outputs.tf` | Outputs |

The CI workflow in `.github/workflows/terraform.yml` runs `fmt`, `validate` and `tflint` on every push.
