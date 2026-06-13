# Interview Questions — Project 30

## Beginner Questions

### What is High Availability?

High Availability (HA) is the design of systems that remain operational despite infrastructure failures.

---

### What is an Availability Zone?

An Availability Zone (AZ) is an isolated data center within an AWS Region.

Example:

```text
ap-south-1a
ap-south-1b
```

---

### What is an Application Load Balancer?

An Application Load Balancer (ALB) distributes HTTP/HTTPS traffic across multiple backend targets.

---

### What is a Target Group?

A Target Group contains backend resources that receive traffic from a Load Balancer.

Example:

```text
EC2 Instances
Containers
IP Addresses
```

---

### What is a Health Check?

A Health Check verifies whether a backend target is available and able to serve traffic.

---

## Intermediate Questions

### Why use multiple Availability Zones?

Benefits:

```text
Redundancy
Fault Tolerance
Reduced Downtime
```

---

### What happens when an EC2 instance fails behind an ALB?

The ALB health checks detect the failure and stop routing traffic to the unhealthy instance.

---

### What is a Single Point of Failure?

A component whose failure causes the entire application to become unavailable.

Example:

```text
Single EC2 Instance
```

---

### How does a Load Balancer improve availability?

It distributes traffic across multiple healthy targets.

---

### What is Fault Tolerance?

Fault Tolerance is the ability of a system to continue operating despite failures.

---

## Advanced Questions

### Explain your AWS High Availability project.

Answer:

> I used Terraform to deploy a VPC, two public subnets across separate Availability Zones, two EC2 instances, and an Application Load Balancer. I verified healthy targets, accessed the application through the ALB, simulated a server failure by stopping one instance, and confirmed that traffic continued through the healthy backend.

---

### How do ALB Health Checks work?

Answer:

> The ALB periodically sends requests to a configured endpoint. If a target fails the health check, it is marked unhealthy and removed from traffic routing.

---

### How did you verify High Availability?

Answer:

> I stopped one EC2 instance and verified that the ALB continued routing traffic to the remaining healthy instance while the application remained accessible.

---

### Why is Multi-AZ architecture important?

Answer:

> Multi-AZ architecture protects against Availability Zone failures and improves application resilience.

---

## Scenario Questions

### Scenario 1

One EC2 instance becomes unavailable.

What happens?

Answer:

```text
ALB detects failure
Target marked unhealthy
Traffic routed to healthy instance
```

---

### Scenario 2

All targets fail health checks.

What happens?

Answer:

```text
Application becomes unavailable
ALB has no healthy targets
```

---

### Scenario 3

A user reports intermittent downtime.

What would you investigate?

Answer:

```text
Target Health
ALB Metrics
EC2 Status
Security Groups
Application Logs
```

---

## Rapid Fire

ALB?

```text
Application Load Balancer
```

High Availability?

```text
Minimized Downtime
```

Fault Tolerance?

```text
Continue Operating During Failure
```

Target Group?

```text
Backend Resources
```

Health Check?

```text
Target Validation
```

Multi-AZ?

```text
Multiple Availability Zones
```
