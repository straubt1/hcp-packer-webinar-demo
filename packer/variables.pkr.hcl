variable "aws_configuration" {
  description = ""
  type = object(
    {
      region = string
    }
  )
  default = {
    region = env("AWS_REGION")
  }
}


variable "azure_credentials" {
  description = ""
  type = object(
    {
      tenant_id       = string
      subscription_id = string
      client_id       = string
      client_secret   = string
    }
  )
  default = {
    tenant_id       = env("ARM_TENANT_ID")
    subscription_id = env("ARM_SUBSCRIPTION_ID")
    client_id       = env("ARM_CLIENT_ID")
    client_secret   = env("ARM_CLIENT_SECRET")
  }
}

variable "azure_configuration" {
  description = ""
  type = object(
    {
      location            = string
      resource_group_name = string
    }
  )
  default = {
    location            = env("ARM_LOCATION")
    resource_group_name = env("ARM_RESOURCE_GROUP_NAME")
  }
}

variable "gcp_configuration" {
  description = ""
  type = object(
    {
      zone             = string
      project_id       = string
      credentials_file = string
    }
  )
  default = {
    zone             = env("GCP_ZONE")
    project_id       = env("GCP_PROJECT_ID")
    credentials_file = env("GCP_CREDENTIALS_FILE")
  }
}