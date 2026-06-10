# Terraform Workflow

## Overview

Terraform follows a predictable workflow for provisioning and managing infrastructure.

The workflow ensures infrastructure changes are reviewed, validated, applied, and tracked through Infrastructure as Code (IaC).

---

# Terraform Lifecycle

```text
Write Code
    ↓
terraform init
    ↓
terraform validate
    ↓
terraform plan
    ↓
terraform apply
    ↓
Infrastructure Created
    ↓
terraform destroy
```

---

# Step 1 - Write Configuration

Terraform configuration files define desired infrastructure.

Examples:

```text
VPC
Subnets
Security Groups
EC2 Instance
```

Common files:

```text
main.tf
variables.tf
outputs.tf
terraform.tfvars
providers.tf
```

--- 

# Step 2 - Terraform Init

Command:

```bash
terraform init
```

Purpose:

```text
Download provider plugins
Initialize working directory
Prepare Terraform environment
```

Example:

```text
AWS Provider Downloaded
Terraform Ready
```

---

# Step 3 - Terraform Validate

Command:

```bash
terraform validate
```

Purpose:

```text
Verify syntax
Verify configuration integrity
Detect configuration errors
```

Benefits:

```text
Prevent invalid deployments
```

# Step 4- Terraform Plan

Command:

```bash
terraform plan
```

Purpose:

```text
terraform plan
```

Terraform compares:

```text
Current State
	vs
Desired State
```

Output:

```text
Resources To Create
Resources To Modify
Resources To Destroy
```

---

# Why Plan Matters

Without plan:

```text
Changes Unknown
```

With plan:

```text
Changes Visible Before Deployment
```

This reduces operational risk.

---

# Step 5 - Terraform Apply

Command:

```bash
terraform apply
```

Purpose:

```text
Create Infrastructure
```

Terraform performs:

```text
API Calls
Resource Creation
State Updates
```

Examples:

```text
Create VPC
Create Subnet
Create EC2
```

---

# Step 6 - Terraform State

Terraform maintains:

```text
terraform.tfstate
```

Purpose:

```text
Track Managed Resources
Maintain Infrastructure State
```

Terraform uses state to determine:

```text
Create
Modify
Delete
```

operations.

---

# Step 7 - Outputs

Outputs expose useful information.

Example:

```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}
```

Benefits:

```text
Resource Discovery
Automation Integration
```

---

# Step 8 - Terraform Destroy

Command: 

```bash
terraform destroy
```

Purpose:

```text
Delete Managed Infrastructure
```

Benefits:

```text
Cost Control
Environment Cleanup
Resource Removal
```

---

# Benefits of Terraform

## Consistency 

```text
Repeatable Infrastructure
```

---

## Automation

```text
No Manual Configuration
```

---

## Version Control

```text
Infrastructure Stored In Git
```

---

## Scalability

```text
Manage Large Environments
```

---

# Production Workflow Example

```text
Developer Updates Terraform
          ↓
Git Commit
          ↓
CI/CD Pipeline
          ↓
terraform validate
          ↓
terraform plan
          ↓
Approval
          ↓
terraform apply
```

This is the workflow commonly used by DevOps and Platform Engineering teams.

---

# Key Learning

Terraform enables:

```text
Infrastructure as Code
Infrastructure Automation
Infrastructure Consistency
Infrastructure Lifecycle Management
```

A typical Terraform workflow consists of:

```text
Init
Validate
Plan
Apply
Destroy
```
