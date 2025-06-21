# GitOps CI/CD Pipeline on AWS 🚀

![GitOps CI/CD Pipeline](https://img.shields.io/badge/GitOps%20CI%2FCD%20Pipeline%20on%20AWS-brightgreen?style=flat&logo=aws)

Welcome to the **GitOps CI/CD Pipeline on AWS** repository! This project offers a production-grade continuous integration and continuous deployment (CI/CD) pipeline using a combination of modern tools like Terraform, Jenkins, ArgoCD, and Amazon EKS. It is designed to streamline the deployment of a Node.js application with MySQL and Redis.

## Table of Contents

1. [Introduction](#introduction)
2. [Architecture](#architecture)
3. [Technologies Used](#technologies-used)
4. [Setup Instructions](#setup-instructions)
5. [Usage](#usage)
6. [Features](#features)
7. [Contributing](#contributing)
8. [License](#license)
9. [Releases](#releases)

## Introduction

In today’s fast-paced development environment, having a reliable CI/CD pipeline is essential. This repository aims to provide a robust solution that simplifies deployment and management of applications in the cloud. By leveraging the power of GitOps, you can ensure that your infrastructure and application code are always in sync.

## Architecture

The architecture of this CI/CD pipeline includes the following components:

- **Terraform**: Infrastructure as Code (IaC) tool to provision AWS resources.
- **Jenkins**: Automation server to build and test your applications.
- **ArgoCD**: Continuous delivery tool for Kubernetes, enabling GitOps workflows.
- **EKS (Elastic Kubernetes Service)**: Managed Kubernetes service to run your applications.
- **Node.js**: JavaScript runtime for building server-side applications.
- **MySQL**: Relational database for data storage.
- **Redis**: In-memory data structure store for caching and session management.

The following diagram illustrates the architecture:

![Architecture Diagram](https://example.com/architecture-diagram.png)

## Technologies Used

This project employs the following technologies:

- **Terraform**: For provisioning AWS infrastructure.
- **Jenkins**: For CI/CD automation.
- **ArgoCD**: For GitOps continuous delivery.
- **EKS**: For Kubernetes orchestration.
- **Node.js**: For backend application development.
- **MySQL**: For database management.
- **Redis**: For caching.
- **Docker**: For containerization.

## Setup Instructions

To set up this CI/CD pipeline, follow these steps:

1. **Clone the Repository**

   First, clone the repository to your local machine:

   ```bash
   git clone https://github.com/vothienhuc/gitops-cicd-pipeline-aws.git
   cd gitops-cicd-pipeline-aws
   ```

2. **Install Prerequisites**

   Ensure you have the following tools installed:

   - [Terraform](https://www.terraform.io/downloads.html)
   - [Jenkins](https://www.jenkins.io/doc/book/installing/)
   - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
   - [AWS CLI](https://aws.amazon.com/cli/)
   - [Docker](https://docs.docker.com/get-docker/)

3. **Configure AWS Credentials**

   Set up your AWS credentials using the AWS CLI:

   ```bash
   aws configure
   ```

4. **Deploy Infrastructure**

   Use Terraform to deploy the necessary AWS resources:

   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

5. **Set Up Jenkins**

   Access Jenkins through your web browser. Follow the setup wizard to configure Jenkins. Install necessary plugins for Docker, Kubernetes, and Git.

6. **Configure ArgoCD**

   Install ArgoCD in your EKS cluster:

   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```

   Access the ArgoCD UI and set up your application.

## Usage

After completing the setup, you can start using the CI/CD pipeline:

1. **Push Code Changes**

   Whenever you push changes to the main branch, Jenkins will automatically trigger a build and deployment.

2. **Monitor Deployments**

   Use the ArgoCD dashboard to monitor the status of your applications. You can see real-time updates and manage rollbacks if necessary.

3. **Database Management**

   Use MySQL and Redis for your application’s data needs. You can manage databases using MySQL Workbench or any other database management tool.

## Features

- **Automated Builds**: Jenkins automates the build process, reducing manual errors.
- **Continuous Delivery**: ArgoCD ensures that your applications are always in sync with your Git repository.
- **Scalability**: EKS allows you to scale your applications easily based on demand.
- **Version Control**: All infrastructure changes are tracked in Git, enabling better collaboration.
- **Monitoring and Logging**: Integrate monitoring tools to keep track of application performance.

## Contributing

We welcome contributions to improve this project. If you would like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Make your changes and commit them (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Create a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Releases

For the latest releases, please visit [Releases](https://github.com/vothienhuc/gitops-cicd-pipeline-aws/releases). You can download and execute the files available there to set up your environment.

For more detailed information, check the "Releases" section in the repository.

![Releases](https://img.shields.io/badge/Latest%20Releases-blue?style=flat&logo=github)

## Conclusion

This repository provides a comprehensive solution for implementing a GitOps CI/CD pipeline on AWS. By following the setup instructions and utilizing the technologies mentioned, you can effectively manage your applications in the cloud. Happy coding!