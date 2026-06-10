# Interview Questions - Project 29

## Beginner Questions

### What is Terraform?

Terraform is an Infrastructure as Code (IaC) tool used to provision and manage infrastructure through code.

---

### What is Infrastructure as Code?

Infrastructure is defined, version-controlled, and deployed using code rather than manual configuration.

---

### What is a Terraform Provider?

A provider allows Terraform to interact with external platforms.

Example:

```text
AWS 
Azure 
GCP
GitHub
```

---

### What is terraform init?

Downloads provider plugins and initializes the Terraform working directory.

---

### What is terraform validate?

Validates Terraform configuration syntax and structure.

---

### What is terraform plan?

Shows what Terraform will create, modify, or destroy before execution.

---

### What is terraform apply?

Creates or modifies infrastructure based on Terraform configuration.

---

### What is terraform destroy?

Deletes all infrastructure managed by Terraform.

---

## Intermediate Questions

### What is Terraform State?

Terraform state tracks infrastructure managed by Terraform.

Stored in:

```text
terraform.tfstate
```

---

### Why is Terraform State Important?

Terraform compares:

```text
Current State
vs
Desired State
```

to determine changes.

---

### What are Variables?

Variables make Terraform reusable and configurable.

Example:

```hcl
variable "aws_region"
```

---

### What are Outputs?

Outputs expose useful values after deployment.

Examples:

```text
VPC ID
Subnet ID
EC2 Public IP
```

---

## AWS Questions

### What is a VPC?

A logically isolated AWS network.

---

### What is a Public Subnet?

A subnet that has a route to an Internet Gateway.

---

### What is an Internet Gateway?

A resource that allows communication between a VPC and the internet.

---

### What is a Route Table?

A set of rules that determine network traffic paths.

---

### What is a Security Group?

A stateful firewall attached to AWS resources.

---

## Advanced Questions

### Explain your Terraform project.

Answer:

> I used Terraform to provision AWS infrastructure including a VPC, public subnet, internet gateway, route table, security group, and EC2 instance. I validated the configuration, generated a plan, applied the infrastructure, verified resource creation, and then destroyed all resources to prevent unnecessary cloud costs. 

---

### Why should terraform plan be used before apply?

Answer:

> It allows engineers to review proposed infrastructure changes and avoid accidental modifications before resources are created.

---

### How does Terraform know what resources already exist?

Answer:

> Terraform uses the state file to track resources under management.

---

### What happens if the state file is lost?

Answer:

> Terraform loses awareness of managed resources and may attempt to recreate infrastructure.

---

## Scenario Questions

### Scenario 1

Terraform apply fails because AWS credentials are invalid.

What do you check?

Answer:

```text
aws sts get-caller-identity 
aws configure 
IAM permissions
```

---

### Scenario 2

An EC2 instance has internet issues.

What would you verify?

Answer:

```text
Public IP
Security Group
Route Table
Internet Gateway
Subnet Type
```

---

### Scenario 3

A plan shows unexpected resources deletion.

What should you do?

Answer:

```text
Do not apply
Review changes
Investigate state/configuration
```

---

## Rapid Fire

```text
Infrastructure as Code
```

Provider?

```text
Platform Integration
```

Plan?

```text
Preview Changes
```

Apply?

```text
Create Infrastructure
```

Destroy?

```text
Delete Infrastructure
```

State?

```text
Infrastructure Tracking
```

VPC?

```text
Virtual Private Cloud
```
