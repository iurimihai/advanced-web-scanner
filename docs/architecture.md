## Project Architecture
<br/>
Full Kubernetes-native pipeline supporting major types of automated application testing

<br/>

### High-level testing steps

- CI:
  - Lint, SCA
  - SAST
  - Unit/Integration tests
  - Container images scanning
- CD:
  - Integration/E2E tests
  - DAST
  - Kubescans
  - TBC

<br/>

### Proposed tools
- Infrastructure: Kubernetes +- AWS
- Container images builder: Kaniko
- Pipeline workflow: Argo Workflows / Tekton
- GitOps: ArgoCD
- SAST: Sonarqube, OWASP dependency checks
- DAST: Zed Atack Proxy + different plugins (e.g. Swagger)
- Infra scanning: kubeaudit, kubescan, trivy etc - needs more research
