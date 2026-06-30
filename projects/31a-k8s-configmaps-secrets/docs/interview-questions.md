# Interview Questions — Mini Project 31A

## What is a ConfigMap?

A ConfigMap stores non-sensitive configuration data in key-value pairs that can be consumed by Pods.

Examples:

```text
Environment
Application Version
Log Level
Feature Flags
```

---

## What is a Secret?

A Secret stores sensitive information such as passwords, API keys, or tokens.

Examples:

```text
Database Password
API Key
JWT Secret
SSH Key
```

---

## ConfigMap vs Secret

| ConfigMap | Secret |
|-----------|--------|
| Non-sensitive data | Sensitive data |
| Plain text | Base64 encoded (not encrypted by default) |
| Application configuration | Credentials, passwords, tokens |

---

## How can a Pod consume a ConfigMap?

- Environment Variables
- Mounted Volume

---

## How can a Pod consume a Secret?

- Environment Variables
- Mounted Volume

---

## What causes CreateContainerConfigError?

Common causes:

- Missing ConfigMap
- Missing Secret
- Incorrect key name
- Incorrect namespace

---

## How did you troubleshoot this project?

The Deployment initially failed because the `APP_VERSION` key was missing from the ConfigMap.

Resolution:

- Updated the ConfigMap
- Reapplied the manifest
- Restarted the Deployment
- Verified environment variables inside the container
