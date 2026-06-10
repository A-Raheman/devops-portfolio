# AWS Networking Concepts

## Overview

AWS networking is built around the Virtual Private Cloud (VPC), which provides logical network isolation for cloud resources.

Understanding VPCs, subnets, route tables, internet gateways, and security groups is essential for cloud and DevOps engineers.

---

# AWS Networking Architecture

```text
AWS Cloud
│
└── VPC (10.0.0.0/16)
     │
     ├── Public Subnet (10.0.1.0/24)
     │      │
     │      └── EC2 Instance
     │
     ├── Internet Gateway
     │
     └── Route Table
```

---

# What is a VPC?

VPC stands for:

```text
Virtual Private Cloud
```

A VPC is a logically isolated network inside AWS.

Example:

```text
CIDR: 10.0.0.0/16
```

Benefits:

```text
Network Isolation
Traffic Control
Security Boundaries
Custom Networking
```

---

# CIDR Block

CIDR defines the IP range available inside a network.

Example:

```text
10.0.0.0/16
```

Provides:

```text
65,536 IP Addresses
```

Subnet Example:

```text
10.0.1.0/24
```

Provides:

```text
256 IP Addresses
```

---

# What is a Subnet?

A subnet is a smaller network inside a VPC.

Example:

```text
VPC
│
├── Public Subnet
│
└── Private Subnet
```

Benefits:

```text
Network Segmentation
Workload Isolation
Security Control
```

---

# Public Subnet

A subnet is considered public when:

```text
Route Table
       ↓
Internet Gateway
```

is configured.

Resources can receive:

```text
Public IP Addresses
```

Examples:

```text
Web Servers
Bastion Hosts
Load Balancers
```

---

# Private Subnet

Private subnets do not have direct internet access.

Common workloads:

```text
Databases
Internal Services
Backend Applications
```

Benefits:

```text
Improved Security
Reduced Exposure
```

---

# Internet Gateway (IGW)

An Internet Gateway enables internet connectivity.

Example:

```text
VPC
   ↓
Internet Gateway
   ↓
Internet
```

Without an IGW:

```text
No Internet Access
```

---

# Route Table

A Route Table controls network traffic.

Example:

```text
Destination: 0.0.0.0/0
Target: Internet Gateway
```

Meaning:

```text
All Internet Traffic
      ↓
Internet Gateway
```

---

# Security Groups

Security Groups act as virtual firewalls.

Example:

```text
Allow TCP 22
```

Purpose:

```text
SSH Access
```

Characteristics:

```text
Stateful
Instance Level
Allow Rules Only
```

---

# Security Group Example

Ingress:

```text
TCP 22
0.0.0.0/0
```

Allows:

```text
SSH Connections
```

Egress:

```text
All Traffic
```

Allows:

```text
Outbound Connectivity
```

---

# Public EC2 Architecture

```text
Internet
    ↓
Internet Gateway
    ↓
Route Table
    ↓
Public Subnet
    ↓
EC2 Instance
```

Requirements:

```text
Public Subnet
Public IP
Security Group
Route to Internet Gateway
```

---

# Networking Components Used in Project 29

Created:

```text
VPC
Public Subnet
Internet Gateway
Route Table
Security Group
EC2 Instance
```

Provisioned using:

```text
Terraform
```

---

# Interview Questions

## What is a VPC?

A logically isolated AWS network.

---

## What is a Public Subnet?

A subnet with a route to an Internet Gateway.

---

## What is a Private Subnet?

A subnet without direct internet access.

---

## What is an Internet Gateway?

A component that enables communication between a VPC and the internet.

---

## What is a Route Table?

A set of rules that determines where network traffic is routed.

---

## What is a Security Group?

A stateful virtual firewall attached to AWS resources.

---

# Key Learning

AWS networking consists of:

```text
VPC
Subnets
Internet Gateway
Route Tables
Security Groups
```

Together these components provide:

```text
Connectivity
Isolation
Security
Traffic Control
```
