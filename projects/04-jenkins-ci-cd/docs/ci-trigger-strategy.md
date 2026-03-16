# CI Trigger Strategy – Local Jenkins Setup

## Overview

Since Jenkins is running locally (WSL), GitHub cannot directly reach `http://localhost:8080` to trigger builds via webhook.

To simulate automatic CI behavior in a local environment, we use **Multibranch Pipeline periodic scanning**.

---

## How It Works

The Multibranch Pipeline is configured with:

Scan Multibranch Pipeline Triggers:
Periodically if not otherwise run

Schedule:
H/2 * * * *

This means:

- Jenkins scans the GitHub repository approximately every 2 minutes.
- If new commits are detected, Jenkins automatically triggers a build.
- No manual “Scan Now” action is required.

---

## Why This Is Necessary Locally

GitHub Webhooks require a publicly accessible URL.

Since `localhost` is not reachable from GitHub:
- Webhooks cannot be used directly.
- Periodic scanning is the correct solution for local-only development.

---

## Production Difference

In production (AWS EC2 deployment):

- Jenkins runs on a public IP or domain.
- GitHub Webhook is configured:
  
  http://<public-ip>:8080/github-webhook/

- Builds trigger instantly on push.
- Periodic scanning is disabled.

---

## Proof of Functionality

A test commit was pushed to `main`, and Jenkins automatically triggered a new build within the scan interval.

This demonstrates working CI automation in a local environment.
