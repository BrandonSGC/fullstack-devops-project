# 🚀 Fullstack DevOps Project

> **A production-inspired Fullstack + DevOps project designed to demonstrate real-world CI/CD, Docker with a real fullstack application and cloud infrastructure practices.**

This repository is not just about code — it documents **how modern companies design, build, test, and deploy software** using DevOps principles.

The goal of this project:
1. 📌 Understanding real-world DevOps workflows.
2. 📚 **Serve as a personal knowledge base** documenting what I learned, why decisions were made, and how everything fits together.

---

## 🧠 Project Overview

This project simulates how a real company delivers software using:
- **One repository**
- **Multiple environments (Dev / Staging / Prod)**
- **Dockerized applications**
- **CI/CD pipelines**
- **Infrastructure as Code (Azure)**

The same application is deployed across environments using the **same artifacts**, changing only configuration and infrastructure.

---

## 🏗️ Architecture (High Level)

- **Frontend**: React (Static Web App)
- **Backend**: Node.js API (Dockerized) + Jest Testing
- **Container Registry**: Azure Container Registry
- **Cloud Provider**: Microsoft Azure
- **CI/CD**: GitHub Actions
- **Infrastructure**: Terraform (IaC)

Each environment is isolated using its own **Azure Resource Group**:

- `rg-fullstack-devops-dev`
- `rg-fullstack-devops-staging`
- `rg-fullstack-devops-prod`

---

## 🌍 Environments

### 🔵 Development (DEV)
- Fast feedback loop
- Cheap infrastructure
- Automatic deployments from feature branches
- Safe place to break things

### 🟡 Staging (Pre-Production)
- Production-like environment
- Used for validation and testing
- Deployed automatically from `main`

### 🔴 Production (PROD)
- Real users
- Manual approval required
- Only deployed from version tags

---

## 🌿 Git & GitHub Workflow

This project uses **Trunk-Based Development**, which is common in modern DevOps teams.

### Branch Strategy

- `main` → Stable code (Staging deployments)
- `feature/*` → Active development (Dev deployments)
- `tags (vX.Y.Z)` → Production releases

### Typical Workflow

1. Create feature branch
2. Push code → CI runs → Deploy to DEV
3. Open Pull Request → CI runs again
4. Merge to `main` → Deploy to STAGING
5. Create tag → Deploy to PROD

### Commit Discipline

**👉🏽 Professional Commits:**
- **Small & Frequent** -> one logical change per commit
- **Clear message** -> explains *what* and *why*, not *how*

**Commit Message Format (Conventional Commits) prefixes:**
- **feat**: → new feature (feat: add user registration API)
- **fix**: → bug fix (fix: trigger on CI pipeline)
- **chore**: → maintenance, config (chore: add eslint config)
- **docs**: → documentation (docs: update README setup instructions)
- **refactor**: → Code or infra changed internally without changing behavior.
- **ci**: → pipeline changes (ci: add GitHub Actions workflow)
- **infra**: → Terraform changes (infra: create MySQL server)

---

## 🐳 Docker

Docker is used to ensure:
- Consistent runtime environments
- Immutable deployments
- Build once, deploy many times

---

## 🔁 CI/CD Pipelines

### 🔵 Continuous Integration (CI)

**Purpose:** Ensure code quality and build reliability.

CI does **not** care about environments. It only:
- Runs tests
- Validates builds
- Builds Docker images
- Publishes artifacts

CI runs on:
- Feature branches
- `main`
- Tags

---

### 🟢 Continuous Deployment (CD)

**Purpose:** Deliver software to real environments.

CD **does care about environments**. It decides:
- WHERE to deploy
- WHICH Resource Group to target
- WHICH secrets to use
- WHICH scale to apply

#### Deployment Logic

- Feature branch → DEV
- `main` → STAGING
- Tag → PROD

The same Docker image is promoted across environments.

---

## 🧪 Testing Strategy

- Unit tests executed in CI
- Build validation inside Docker
- Smoke tests after deployment
- Manual validation in staging

Testing is used as a **quality gate**, not as an afterthought.

---

## 🔐 Security & Configuration

- 

---

## 🔄 DevOps Workflow (Real-World Scenario)

1. Developer creates feature branch
2. CI runs automatically
3. Application deploys to DEV
4. Pull Request reviewed
5. Merge to `main`
6. Deploy to STAGING
7. Approval granted
8. Tag created
9. Deploy to PROD

---

## 📘 Learning Notes (Personal Knowledge Base)

This section documents concepts learned during the project and is intentionally written in simple language.

### 🐳 Docker

**Important Files**

- `Dockerfile` → Defines how the application image is built
- `compose.yaml` → Local multi-container development
- `.dockerignore` → Prevents unnecessary files from being included in images (just like .gitignore)

**Key Concepts**

**What is a container?**  
A running instance of an image that packages the application and its dependencies.

**What is an image?**  
A read-only blueprint used to create containers.

**What is a volume?**
It's a persistent storage managed by Docker to save and share data outside their own filesystem, so data persists across container restarts and can be used by multiple containers.

**What is tagging and why is it important?**  
Tags identify versions of images (e.g. commit SHA, `v1.0.0`). They allow traceability and safe rollbacks.

**How to run a container?**  
Containers are started from images using Docker or orchestrated services in the cloud.

### 🌿 Git / GitHub

**What is tagging?**  
A way to mark a specific commit as a release.

### 🧪 Testing

Difference between Unit Tests and Integration Tests:

- **Unit Tests:** Test individual functions or components in isolation. They don’t connect to databases, APIs, or files. Usually use mocks or stubs.

- **Integration Tests:** Test how multiple components work together, for example, the backend interacting with a real or test database.

### 🏗️ Terraform

We handle only the infrastructure with terraform, for the configuration or things related to the application lifecycle we managed it through CI/CD.

**What is the state in terraform?**

Terraform state is Terraform’s memory. It is a file that maps:

- Terraform code ➜ Real Azure resources

**What is the backend.tf?**

In Terraform, backend.tf is the file where Terraform stores its state.

New commands?

```terraform refresh``` -> refresh the state file

We already have the KeyVault, we need to continue with the pipeline to add the secrets for the MySQL module.

---

## 🎯 Why This Project?

This project helped me to understand:

- Real-world DevOps workflows
- Environment isolation
- CI/CD best practices
- Docker and cloud-native thinking
- Clear documentation and decision-making

It is designed to be **understandable, reproducible, and production-inspired**.

---

## 📌 Author

**Brandon Gómez**  
Cloud Engineer & Developer
