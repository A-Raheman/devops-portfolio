# Incident Case 2 - Jenkins Missing Property Error

## Issue Description

During Jenkins pipeline execution, the job failed in the post-build phase with the following error:

```text
groovy.lang.MissingPropertyException: No such property: APP_ENV for class: groovy.lang.Binding
```
---

## Root Cause

The Jenkins pipeline referenced the variable `APP_ENV`, but that variable causes a runtime failure.

---

## Diagnosis Steps

### Steps 1 - Review Jenkins console output

Checked the failed build logs in the Jenkins console output.

Observation:
The error clearly indicated that Jenkins could not find the variable `APP_ENV`.

---

### Step 2 - Review Jenkinsfile

Inspected the pipeline script and idenified that `APP_ENV` was being used without being declared.

Example problematic usage:

```
echo "Deploying to ${APP_ENV}"
```
---

### Step 3 - Check pipeline environment section

Verified whether `APP_ENV` was defined under:
```
- environment {}
- paramenters {}
```
- exported shell variables 
It was missing.

---

## Resolution

Defined the variable properly in the Jenkins pipeline.

### Fix option 1 - Define in environment block

```
environment {
    APP_ENV = "production"
}
```
### Fix option 2 - Pass as parameter

```
parameters {
    string(name: 'APP_ENV', defaultValue: 'production', description: 'Deployment environment')
}
```

---

## Fix Applied 

Added the required variable definition in the Jenkins pipeline so that the Groovy script could resolve it successfully.

---

## Verification 

Re-ran the Jenkins pipeline after the fix.
Result:
- Pipeline completed successfully
- Post-build stage executed without error

---

## Prevention Strategy

- Always define pipeline variables before use
- Review Jenkinsfile carefully for undeclared variables
- Prefer `environment {}` or `parameters {}` for clarity
- Test pipeline changes incrementally

---

## Key Learning 

Jenkins pipeline scripts are sensitive to undefined variables. Clear variable management is essential for stable CI/CD pipelines.

---

