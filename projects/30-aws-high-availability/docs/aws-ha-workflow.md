# AWS High Availability Workflow

## Overview

This document explains the workflow followed to build, validate, test, and destroy a highly available AWS architecture using Terraform.

The objective was to ensure application availability even when one backend server becomes unavailable.

---

# High Availability Workflow

```text
Terraform Code
        ↓
Terraform Validate
        ↓
Terraform Plan
        ↓
Terraform Apply
        ↓
Multi-AZ Infrastructure Created
        ↓
Application Load Balancer Active
        ↓
Health Checks Verified
        ↓
Application Access Tested
        ↓
Backend Failure Simulated
        ↓
Traffic Routed To Healthy Instance
        ↓
Terraform Destroy
        ↓
AWS Cleanup Verification
```

---

# Step 1 — Infrastructure Definition

Infrastructure was defined using Terraform.

Resources included:

```text
VPC
Public Subnets
Internet Gateway
Route Table
Security Groups
EC2 Instances
Application Load Balancer
Target Group
Listener
```

Purpose:

```text
Infrastructure as Code
Repeatability
Automation
```

---

# Step 2 — Validation

Commands:

```bash
terraform init
terraform validate
```

Purpose:

```text
Verify Terraform Configuration
Prevent Deployment Errors
```

---

# Step 3 — Planning

Command:

```bash
terraform plan
```

Purpose:

```text
Preview Infrastructure Changes
Review Resources Before Deployment
```

---

# Step 4 — Deployment

Command:

```bash
terraform apply
```

Created:

```text
VPC
2 Public Subnets
2 EC2 Instances
Application Load Balancer
Target Group
```

Purpose:

```text
Deploy High Availability Architecture
```

---

# Step 5 — Health Check Validation

Verified:

```text
EC2 Instance 1 Healthy
EC2 Instance 2 Healthy
```

ALB Health Checks:

```text
HTTP Port 80
Path /
```

Purpose:

```text
Ensure Traffic Can Be Routed
```

---

# Step 6 — Application Verification

Accessed:

```text
ALB DNS Endpoint
```

Observed:

```text
Application Successfully Accessible
```

Purpose:

```text
Validate End-to-End Connectivity
```

---

# Step 7 — Failover Simulation

Simulated:

```text
Stop EC2 Instance 1
```

Observed:

```text
Instance 1 Removed From Rotation
Instance 2 Remained Healthy
```

Purpose:

```text
Validate Fault Tolerance
```

---

# Step 8 — High Availability Validation

Result:

```text
Application Remained Accessible
```

Traffic Flow:

```text
User
  ↓
ALB
  ↓
Healthy Backend
```

Purpose:

```text
Prove High Availability Design
```

---

# Step 9 — Infrastructure Cleanup

Command:

```bash
terraform destroy
```

Purpose:

```text
Remove AWS Resources
Prevent Unnecessary Charges
```

---

# Step 10 — Cleanup Verification

Verified:

```text
No Running EC2 Instances
No Load Balancers
No Project Resources
```

Purpose:

```text
Cost Control
Environment Hygiene
```

---

# Key Learning

This workflow demonstrates:

```text
High Availability
Load Balancing
Health Checks
Failover Validation
Infrastructure Automation
Infrastructure Lifecycle Management
```

These concepts are commonly used in production AWS environments.
