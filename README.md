# Solar System Pipeline (Node.js + EKS)

A simple Node.js web app that shows the Solar System, fully automated through CI/CD with GitHub Actions, Terraform-provisioned AWS EKS, and Kubernetes manifests.

## Repository layout

```
.
├── app.js                   # Node.js app entry
├── app-controller.js        # Controller logic
├── app-test.js              # Unit tests
├── index.html               # UI
├── images/                  # Static assets
├── Dockerfile               # App container image
├── kubernetes/
│   ├── deployment.yml       # K8s Deployment (3 replicas)
│   └── service.yml          # K8s Service (type LoadBalancer)
├── terraform/
│   ├── 1-providers.tf       # (Provider/backends if used)
│   ├── 2-variables.tf       # Node group configuration (size/types)
│   ├── 3-main.tf            # Root module wiring (VPC + EKS)
│   ├── 4.outputs.tf         # Outputs (if any)
│   └── infrastructure-modules/
│       ├── vpc/             # Custom VPC module (VPC, subnets, routes, IGW, NAT)
│       └── eks/             # Custom EKS module (cluster, node groups)
└── .github/workflows/workflow.yml  # CI/CD pipeline
```

## Prerequisites

- Node.js 18+
- Docker (for local builds)
- AWS account, credentials with permissions to manage VPC/EKS/EC2/IAM/ELB/S3/DynamoDB
- kubectl and awscli installed locally (only if deploying manually outside CI)

## CI/CD (GitHub Actions)

Workflow: `.github/workflows/workflow.yml`

Jobs (in order):
- Unit tests (Node 18/19/20 on multiple OS)
- Code coverage (Node 18)
- Docker build and push (Docker Hub + GHCR)
- Terraform (create/update EKS + VPC in AWS)
- Deploy to EKS (apply `kubernetes/deployment.yml` and `kubernetes/service.yml`)

Required repo variables/secrets:
- Vars: `DOCKER_USERNAME`, `MONGO_URI`, `MONGO_USERNAME`
- Secrets: `DOCKER_PASSWORD`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `MONGO_PASSWORD`

Trigger: on push to `main` (and `feature-branchA`) or manual dispatch.