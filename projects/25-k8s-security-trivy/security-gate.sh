#!/bin/bash

echo "Running Trivy Security Scan..."

CRITICAL=$(trivy image \
--scanners vuln \
--severity CRITICAL \
nginx:latest 2>/dev/null | grep -c "CRITICAL")

echo "Critical vulnerabilities found: $CRITICAL"

if [ "$CRITICAL" -gt 0 ]; then
    echo "BUILD FAILED - Critical vulnerabilities detected"
    exit 1
else
    echo "BUILD PASSED - No critical vulnerabilities"
fi

