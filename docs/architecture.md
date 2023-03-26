## Project Architecture
<br/>
Full Kubernetes-native pipeline supporting major types of automated application testing, including QA and security.

<br/>

### Motivation

In recent years, the concept of Platform Engineering started to be more and more present in the Software Engineering
world. This concept is trying to fix the issues with the actual DevOps state: instead putting DevOps/SRE teams acting
as firefighters, they should develop an Internal Development Platform (IDP) and treat it as a product, same as development
teams work on theirs projects. To achieve that, the developers need a single and robust API to interact with all infrastructure
abstraction, becoming more efficient and reducing cognitive load.

Due to its wide adoption and extensible API, Kubernetes has a lot of advantages that could make it become the API layer to interact
with platform services. It also provide a platform-agnostic approach to deploy and run applications, enabling a fully automated
cloud-native SDLC implementation.

On top of that, DevSecOps methodology implies shifting left app security testing in the same manner QA tests are performed
as a standard today, ensuring a better quality of the products and allowing QA and security teams focus on more important
aspects.

Even we speak about DevOps, Platform Engineering, Infrastrucure and all other related aspects, Kubernetes allows engineers with different
specialities to collaborate in a full DevOps way - to break down the silos and efficiently communicate between teams. Taking into account
this statement, now we can shift from traditionally pipelines implemented directly on VMs to a full Kubernetes-native CI/CD approach,
eliminating the platform dependency - this kind of implementation fits very well with the cloud-native approach as well as having Kubernetes
clusters running on-premise. More than that, if we abstract from technologies (that of course, are different), the pipelines best practices
and advantages remain the same - we still implement the same build, test (including SAST and DAST) and deploy steps.

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
- SAST: Sonarqube, OWASP dependency checks - to be reviewed
- DAST: Zed Atack Proxy + different plugins (e.g. Swagger)
- Infra scanning: kubeaudit, kubescan, trivy etc - more research after I have the pipeline set

