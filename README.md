
# CI/CD Pipeline — GitHub Actions + AWS CodeDeploy + EC2

Automated deployment pipeline that deploys a Node.js app to AWS EC2 on every `git push` — zero manual intervention.

## Architecture

```
GitHub Push → GitHub Actions → Tests → S3 Upload → AWS CodeDeploy → EC2
```

## Pipeline Stages

| Stage | What happens |
|---|---|
| Checkout | Latest code pulled |
| Test | npm test runs automatically |
| AWS Auth | GitHub Secrets se credentials |
| S3 Upload | App zipped and uploaded to S3 |
| CodeDeploy | Zero-downtime deploy to EC2 |
| Validate | Health check confirm karta hai app chali |

## Tech Stack

- **CI/CD** — GitHub Actions
- **Deploy** — AWS CodeDeploy
- **Compute** — AWS EC2 (Amazon Linux 2)
- **Storage** — AWS S3 (artifact store)
- **IAM** — Least-privilege roles for EC2 + CodeDeploy
- **Runtime** — Node.js 18 + Express

## Project Structure

```
├── app.js                        # Express app
├── package.json
├── appspec.yml                   # CodeDeploy instructions
├── scripts/
│   ├── before_install.sh         # Install Node.js, create dirs
│   ├── stop_server.sh            # Gracefully stop old app
│   ├── start_server.sh           # Start new app
│   └── validate.sh               # Confirm deployment success
└── .github/
    └── workflows/
        └── deploy.yml            # GitHub Actions pipeline
```

## How to Set Up

### 1. AWS Setup

```bash
# IAM User banao with these policies:
AmazonS3FullAccess
AWSCodeDeployFullAccess
AmazonEC2FullAccess
```

### 2. EC2 Setup

```bash
# SSH into EC2 then run:
sudo yum install -y ruby wget
wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
chmod +x ./install && sudo ./install auto
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent
```

### 3. GitHub Secrets

Go to repo → Settings → Secrets → Actions → add:

| Secret | Value |
|---|---|
| `AWS_ACCESS_KEY_ID` | IAM user access key |
| `AWS_SECRET_ACCESS_KEY` | IAM user secret key |
| `S3_BUCKET` | your-s3-bucket-name |

### 4. Deploy

```bash
git push origin main
# GitHub Actions automatically triggers — check Actions tab
```

## Key Problems Solved

- **Zero-downtime deploys** — stop → install → start → validate hooks ensure no downtime
- **Secure credentials** — never hardcoded, always via GitHub Secrets
- **Automated rollback** — CodeDeploy rolls back if ValidateService fails

## Resume Bullet

> Implemented CI/CD pipeline using GitHub Actions + AWS CodeDeploy — automated deployments to EC2 with zero-downtime, reducing manual deployment effort by 100%
