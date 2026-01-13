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

### 🌿 Git / GitHub

**What is tagging?**  
A way to mark a specific commit as a release.

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

### 🐳  Docker

**Important Files:**

- `Dockerfile` → Defines how the application image is built
- `compose.yaml` → Local multi-container development
- `.dockerignore` → Prevents unnecessary files from being included in images (just like .gitignore)

**Key Concepts:**

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

**What is tagging and why is it important?**
Tags identify **specific versions** of images.

Examples:

- `mysql:8.0`
- `backend:v1.2.0`
- `backend:commit-sha`

Why it matters:

- Reproducible builds
- Safe rollbacks
- No accidental breaking changes (`latest` is risky)

#### Commands

**Running Containers:**

Containers are created from images using `docker run`.

**Basic syntax:**

```bash
docker run [OPTIONS] IMAGE[:TAG] [COMMAND]
```

**Common docker run options:**

- `--name` -> Assigns a readable name to the container. Example: ```--name mysql```
- `--network` -> Adds the container to a network. Example: ```--network backend-dev```
- `--env-file` -> Passes the env vars file. Example: ```--env-file .env```
- `-e` -> Environment variables. Example: ```-e MYSQL_ROOT_PASSWORD=root```
- `-p` -> Port mapping. Example: ```-p 3306:3306```
- `-v` -> For volumes. Example: ```-v volume_name:/container/path```
- `-d` -> Detached mode (run containers in the background). Example: ```-d```

#### Example: Running a MySQL container

```bash
docker run \
docker run \
  --name mysql \
  --network dev-network \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=testdb \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  -d mysql:oraclelinux9
```

#### 🧪 Common Docker Commands

#### Pull an image

```bash
docker pull <container_name:tag>
docker pull mysql:oraclelinux9
```

#### List images

```bash
docker images
```

#### List running containers

```bash
docker ps
```

#### List all containers

```bash
docker ps -a
```

#### Stop a container

```bash
docker stop <container_name>
```

#### Start an existing container

```bash
docker start <container_name>
docker start mysql
```

#### Remove a container

```bash
docker rm <container_name>
docker rm mysql
```

#### 📜 Logs & Debugging

#### View logs

```bash
docker logs mysql
```

#### Follow logs (live)

```bash
docker logs -f mysql
```

#### 🧠 Execute Commands Inside a Container

```bash
docker exec -it mysql bash
```

**Explanation:**

- `exec` → run a command in a running container
- `-i` → interactive
- `-t` → terminal

bash → shell inside the container

### ⍯ Docker CLI commands vs Docker Compose

Here is the equivalent in both CLI Commands and using docker compose to build and run the images for this project.

**Note**: MySQL container is just for local development...

**CLI commands:**

- `docker build -t fullstack-backend:dev .` -> builds our backend image
- `docker pull mysql:oraclelinux9` -> pulls docker image
- `docker network create dev-network` -> creates network
- `docker run --name mysql --network dev-network -e MYSQL_ROOT_PASSWORD=<password> -e MYSQL_DATABASE=<dbname> -v mysql-data:/var/lib/mysql -p3306:3306 -d mysql:oraclelinux9` -> runs the mysql server and creates the DB
- `docker runs --name backend-dev --network dev-network --env-file .env -p 3000:3000 -d fullstack-backend:dev` -> runs our container for the backend.

**Docker Compose:**

```yaml
name: fullstack-devops-project

services:
  mysql:
    container_name: mysql
    image: mysql:oraclelinux9
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
    volumes:
      - mysql-data:/var/lib/mysql
    ports:
      - "3306:3306"
    restart: unless-stopped

  backend:
    container_name: backend
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      DB_NAME: ${DB_NAME}
      DB_USER: ${DB_USER}
      DB_PASSWORD: ${DB_PASSWORD}
      DB_HOST: ${DB_HOST}
      DB_PORT: ${DB_PORT}
    depends_on:
      - mysql
    restart: unless-stopped

volumes:
  mysql-data:
```

**How to run docker compose:**

To build new image and run docker compose:

```bash
docker compose up --build
```

To run it in the background:

```bash
docker compose up --build -d
```

To run docker compose (without building a new image):

```bash
docker compose up --build -d
```

Stop containers (keeping the data):

```bash
docker compose stop
```

To stop and delete containers and network:

```bash
docker compose down
```

To also delete volumes:

```bash
docker compose down -v
```

### 🧪 Testing

Difference between Unit Tests and Integration Tests:

- **Unit Tests:** Test individual functions or components in isolation. They don’t connect to databases, APIs, or files. Usually use mocks or stubs.

- **Integration Tests:** Test how multiple components work together, for example, the backend interacting with a real or test database.

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
