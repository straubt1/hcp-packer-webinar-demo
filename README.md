# HCP Packer and HCP Terraform Demo Repository

The repo is aimed at demonstrating a multi-cloud packer build and HCP Packer Bucket flow that supports HCP Terraform Workspaces.

The underlying application is a simple web application that is installed in the Packer build.
Each HCP Terraform Workspace simply deploys a compute instance with a public IP for rendering in a browser.

## Folders

Each folder in this demo repository has a purpose.

`setup`
- Creates the HCP Terraform Project and Workspaces
- Configures the Workspaces to align with the branching and folder structure of this repo

`packer`
- Packer file to create images in multiple clouds
- Configuration files to setup the image to host as a webapp serving a single HTML file

`hcp-terraform`
- Folder for each workspace
- Terraform to create a compute instance based on the HCP Packer Bucket and Channel


