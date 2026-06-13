# Common Errors & Troubleshooting — Project 30

## Error 1 — Terraform Provider Download Failure

### Problem

```text
Failed to query available provider packages
```

### Cause

Incorrect provider source.

Example:

```hcl
source = "hasicorp/aws"
```

### Resolution

Use:

```hcl
source = "hashicorp/aws"
```

---

## Error 2 — AWS Authentication Failure

### Problem

```text
No valid credential sources found
```

### Cause

AWS CLI credentials missing or invalid.

### Resolution

Verify:

```bash
aws sts get-caller-identity
```

Configure credentials:

```bash
aws configure
```

---

## Error 3 — ALB Targets Remain Unhealthy

### Cause

Apache not running
Incorrect Security Group
Wrong Health Check Path

### Resolution

Verify:

```bash
systemctl status httpd
```

Check:

```text
Port 80 Open
Health Check Path Valid
```

---

## Error 4 — ALB Not Accessible

### Cause

Security Group blocks HTTP traffic.

### Resolution

Verify:

```text
Inbound TCP 80
0.0.0.0/0
```

---

## Error 5 — EC2 User Data Failure

### Problem

Web page does not load.

### Cause

User data script failed.

### Resolution

Check:

```bash
sudo cat /var/log/cloud-init-output.log
```

---

## Error 6 — Target Group Shows Unused

### Cause

Target not registered
Instance stopped
Health checks failing

### Resolution

Verify:

```text
Target Registration
Instance State
Target Health
```

---

## Error 7 — Terraform Destroy Failure

### Cause

AWS dependency still exists.

### Resolution

Retry:

```bash
terraform destroy
```

Verify:

```text
Load Balancer
Target Group
Security Groups
```

---

## Useful Commands

Terraform:

```bash
terraform validate
terraform plan
terraform apply
terraform destroy
```

AWS Identity:

```bash
aws sts get-caller-identity
```

EC2:

```bash
aws ec2 describe-instances
```

Load Balancers:

```bash
aws elbv2 describe-load-balancers
```

Target Groups:

```bash
aws elbv2 describe-target-groups
```

---

# Key Lesson

When troubleshooting High Availability architectures:

```text
ALB
Target Groups
Health Checks
Security Groups
EC2 Status
Terraform State
```

should always be investigated first.
