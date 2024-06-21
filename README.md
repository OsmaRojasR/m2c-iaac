# CAME IaC

## Description

This project is aimed at deploying infrastructure on Google Cloud Platform (GCP) using Infrastructure as Code (IaC) principles with Terraform.

## Installation

To install this project, follow these steps:

1. Clone the repository: `git clone`
2. Change into the project directory: `cd m2c-project-iac`
3. Install Terraform: [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
4. Authenticate with GCP: [GCP Authentication Guide](https://cloud.google.com/docs/authentication/getting-started)
5. Initialize Terraform: `terraform init`
6. Customize the configuration: Modify the `env` file to match your desired GCP resources.
7. (Optional) View the plan for deploy the infrastructure `terraform plan -var-file='env/*enviroment*.tfvars'`
8. Deploy the infrastructure: `terraform apply -var-file='env/*enviroment*.tfvars'`

## Usage

To use this project, follow these guidelines:

1. Modify the `env` file to match your desired GCP resources.
2. Run `terraform apply -var-file='env/*enviroment*.tfvars'` to deploy the infrastructure.
3. Access and manage your GCP resources as needed.

This project is licensed under the [MIT License](LICENSE).
