# Jenkins Multibranch Strategy

## Why Multibranch?

Multibranch Pipelines automatically:

- Discover branches 
- Load Jenkinfile per branch
- Create branch-specific builds

---

## Important Concepts Learned 

### Indexing =X= Build 

Branch indexing scans repository metadata. 
Build only triggers if a change is detected.

Webhook triggers indexing, which then triggers builds.

---

### Git vs GitHub Branch Source

Git Source:
- Basic repository tracking

GitHub Source:
- Full webhook integration
- Branch discovery
- Pull request support

---

### Parameter Handling

Pipeline uses:

params.APP_ENV

Instead of:

APP_ENV

This prevents:

MissingPropertyException errors.

---

### Build Retention

buildDicarder(logRotator(numToKeepStr: '10'))

Prevents disk space exhaustion.

---

## Final State

- Multibranch pipeline stable
- Webhook-triggered builds
- Parameterized environment
- clean build lifecycle
 
