# Terraform Folder Structure

This script is following the good practices / advice of Charity Majors and Kelsey Hightower
for how you separate your terraform state files and variables.

See Charity's detailed blog post here:

[Charity WTF Blog - Why you want to have separate state files for each environment](https://charity.wtf/2016/03/30/terraform-vpc-and-why-you-want-a-tfstate-file-per-env/)

Created so I could create consistent structures every time. I hope it helps.

# Usage

./create-terraform-structure.sh (projectName)

Version 0.1

# Creates the following structure

- A file for common variables, (variables.tf) used accross all environments, with simlinks in each.
- (initialize.tf) for empty variable definitions, with simlinks in each environment.
- Three environments, dev, staging and production.
- Three core folders, Global: which is for overall s3 and iam, mgmt: for tools and modules.

```
.
├── create-terraform-structure.sh
└── projectName
    ├── initialize.tf
    ├── variables.tf
    ├── dev
    │   ├── data-storage
    │   ├── dev.tf
    │   ├── dev.tfvars
    │   ├── iam
    │   ├── initialize.tf -> projectName/initialize.tf
    │   ├── outputs.tf
    │   ├── s3
    │   ├── services
    │   │   ├── backend
    │   │   └── frontend
    │   ├── variables.tf -> projectName/variables.tf
    │   └── vpc
    ├── global
    │   ├── iam
    │   └── s3
    ├── mgmt
    │   ├── bastion-host
    │   ├── ci
    │   ├── services
    │   └── vpc
    ├── modules
    │   ├── data-storage
    │   ├── iam
    │   ├── initialize.tf -> projectName/initialize.tf
    │   ├── modules.tf
    │   ├── modules.tfvars
    │   ├── outputs.tf
    │   ├── s3
    │   ├── services
    │   │   ├── backend
    │   │   └── frontend
    │   ├── variables.tf -> projectName/variables.tf
    │   └── vpc
    ├── production
    │   ├── data-storage
    │   ├── iam
    │   ├── initialize.tf -> projectName/initialize.tf
    │   ├── outputs.tf
    │   ├── production.tf
    │   ├── production.tfvars
    │   ├── s3
    │   ├── services
    │   │   ├── backend
    │   │   └── frontend
    │   ├── variables.tf -> projectName/variables.tf
    │   └── vpc
    ├── staging
        ├── data-storage
        ├── iam
        ├── initialize.tf -> projectName/initialize.tf
        ├── outputs.tf
        ├── s3
        ├── services
        │   ├── backend
        │   └── frontend
        ├── staging.tf
        ├── staging.tfvars
        ├── variables.tf -> projectName/variables.tf
        └── vpc
```
