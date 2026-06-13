# High Availability Concepts

## Overview

High Availability (HA) is the practice of designing systems that remain operational even when individual components fail.

The goal is to minimize downtime and eliminate single points of failure.

---

# What is High Availability?

High Availability means:

```text
Application remains available
despite failures in infrastructure.
```

Example:

```text
One server fails
      ↓
Application continues running
```

Benefits:

```text
Reduced Downtime
Improved Reliability
Better User Experience
Business Continuity
```

---

# Single Point of Failure (SPOF)

A Single Point of Failure is any component whose failure causes the entire application to become unavailable.

Example:

```text
Internet
    ↓
Single EC2 Instance
```

If the instance fails:

```text
Application Down
```

Problem:

```text
No Redundancy
```

---

# Eliminating Single Points of Failure

Instead of:

```text
1 EC2 Instance
```

Use:

```text
2 EC2 Instances
```

Architecture:

```text
Internet
    ↓
Load Balancer
    ↓
──────────────
↓            ↓
EC2-A      EC2-B
```

Benefits:

```text
Redundancy
Fault Tolerance
Availability
```

---

# What is Fault Tolernace?

Fault Tolerance is the ability of a system to continue operating when one or more components fail.

Example:

```text
Server Failure
      ↓
Traffic Redirected
      ↓
Application Continues
```

Difference:

```text
High Availability = Minimize Downtime

Fault Tolerance = Continue Operating During Failure
```

---

# What is a load Balancer?

A Load Balancer distributes traffic across multiple backend servers.

Example:

```text
Users
   ↓
ALB
   ↓
──────────────
↓            ↓
Server A   Server B
```

Benefits:

```text
Traffic Distribution
Health Monitoring
Failover Support
Scalability
```

---

# Application Load Balancer (ALB)

AWS Application Load Balancer operates at:

```text
Layer 7
HTTP / HTTPS
```

Features:

```text
Health Checks
Host-Based Routing
Path-Based Routing
Target Groups
```

---

# What is a Target Group?

A Target Group contains backend resources that receive traffic from a Load Balancer.

Example:

```text
Target Group
    ↓
EC2-A
EC2-B
```

Purpose:

```text
Traffic Distribution
Health Monitoring
```

---

# What are Health Checks?

Health Checks continuously verify whether backend targets are available.

Example:

```text
HTTP GET /
```

```text
200 OK
```

Unhealthy:

```text
Connection Failure
Timeout
5xx Errors
```

---

# Health Check Workflow

```text
ALB
 ↓
Health Check
 ↓
Healthy?
 ↓
Yes → Route Traffic

No → Remove Target
```

Benefits:

```text
Automatic Failure Detection
Automatic Traffic Redirection
```

---

# Multi-AZ Architecture

Availability Zones (AZs) are physically separate AWS data centers within a region.

Example:

```text
ap-south-1a
ap-south-1b
```

Architecture:

```text
ALB
 ↓
──────────────
↓            ↓
AZ-1       AZ-2
```

Benefits:

```text
Data Center Redundancy
Improved Availability
Reduced Risk
```

---

# High Availability Architecture Used in Project 30

```text
Internet
    ↓
Application Load Balancer
    ↓
──────────────
↓            ↓
Web1        Web2
AZ-1        AZ-2
```

Scenario Tested:

```text
Stop Web1
```

Observed:

```text
ALB Health Check Failed
Web1 Removed
Web2 Remained Healthy
Application Accessible
```

Result:

```text
High Availability Verified
```

---

# Real-World Examples

Examples of systems using HA:

```text
E-commerce Platforms
Banking Applications
Streaming Services
Cloud Platforms
SaaS Applications
```

---

# Interview Questions

## What is High Availability?

Designing systems to remain available despite failures.

---

## What is Fault Tolerance?

The ability to continue operating when components fail.

---

## What is a Single Point of Failure?

A component whose failure causes the entire system to fail.

---

## Why use multiple Availability Zones?

To improve redundancy and reduce the impact of infrastructure failures.

---

## What is a Target Group?

A collection of backend resources that recieve tarffic from a Load Balancer.

---

## How do ALB Health Checks work?

The ALB periodically sends requests to targets and routes traffic only to healthy instances.

---

## How did you test High Availability?

Answer:

> I deployed two EC2 instances across separate Availability Zones behind an Application Load Balancer. I stopped one instance and verified that the ALB removed it from rotation while continuing to serve tarffic through the healthy instance.

---

# Key Learning

High Availability is achieved through:

```text
Redundancy 
Load Balancing
Health Checks
Multi-AZ Deployment
Automatic Failover
```


These principles are fundamental to modern cloud infrastructure design. 
