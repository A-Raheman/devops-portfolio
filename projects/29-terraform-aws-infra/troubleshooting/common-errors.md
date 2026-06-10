# Common Errors & Troubleshooting — Project 29

## Error 1 — Terraform Init Fails

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

# Error 2 — AWS Authentication Failure

## Problem

```text
No valid credential sources found
```

### Cause

AWS CLI not configured.

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

# Error 3 — Terraform Validate Fails

## Problem

```text
Invalid Terraform configuration
```

### Cause

Syntax error.

### Resolution

Run:

```bash
terraform fmt
terraform validate
```

Review the reported line number.

---

# Error 4 — Terraform Plan Fails

## Problem

Plan generation fails.

### Cause

Missing variables or incorrect references.

### Resolution

Verify:

```bash
terraform validate
```

Check:

```text
variables.tf
terraform.tfvars
```

---

# Error 5 — EC2 Launch Failure

## Problem

Terraform cannot create EC2.

### Cause

Invalid AMI
Unsupported instance type
Region mismatch

### Resolution

Verify:

```bash
aws ec2 describe-images
```

Confirm:

```text
AMI exists in selected region
```

---

# Error 6 — Internet Connectivity Not Working

## Cause

Missing:

```text
Internet Gateway
Route Table Route
Public IP
```

### Resolution

Verify:

```text
IGW attached
0.0.0.0/0 route exists
Subnet is public
```

---

# Error 7 — Terraform Destroy Fails

## Cause

Dependency issue or manual resource modification.

### Resolution

Refresh state:

```bash
terraform refresh
```

Then retry:

```bash
terraform destroy
```

---

# Useful Commands

Initialize:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Plan:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

Destroy:

```bash
terraform destroy
```

AWS Identity:

```bash
aws sts get-caller-identity
```

---

# Key Lesson

Terraform troubleshooting usually starts with:

```text
Credentials
Provider
Variables
State
Resource Dependencies
```
