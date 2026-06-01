# MinIO DNS Note

During local Velero testing with MinIO, backup and restore completed successfully, but fetching detailed logs from the local WSL terminal produced DNS resolution errors for:

```text
minio.velero.svc
```

This happens because `minio.velero.svc` is a Kubernetes internal DNS name and is resolvable inside the cluster, but not directly from the WSL host.

The backup and restore were still successful because:

```text
Backup Phase: Completed
Restore Phase: Completed
Items restored: 10/10
Application namespace restored
Pods restored
Service restored
```


