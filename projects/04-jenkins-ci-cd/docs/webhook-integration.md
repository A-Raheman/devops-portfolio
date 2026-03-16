# GitHub Webhook Integration (Local Setup)

## Problem

GitHub cannot send webhooks to `localhost`.

Reason:
`localhost` is not publicly accessible.

---

## Solution

Cloudflared Tunnel was used to expose Jenkins securely.

Command used:

Cloudflared tunnel --url http://127.0.0.1:8080 --http-host-header localhost

This generated a public URL:

https://<random>.trycloudflare.com/github-webhook/
example:{https://prove-reed-naturals-nature.trycloudflare.com/github-webhook/}

---

## Debugging Journey

Errors encountered:

- 502 Bad Gateway -> Tunnel not reaching origin
- 530 Cloudflare error -> old tunnel URL used
- 403 -> Security or wrong endpoint
- 400 -> Empty test payload (expected during curl test)

Each issue was diagnosed using:

curl -I
curl -X POST
GitHub Webhook delivery logs

---

## Final Result

- Webhook delivery: 200
- Push -> Jenkins auto build (5-10 seconds)
- Periodic polling disabled

CI is now fully event-driven.
