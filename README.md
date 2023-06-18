# GCP Terraform Subnet IAM Attach
Terraform to share assign the `roles/NetworkUser` role to the default Service Accounts within the Service Project based on the enabled Cloud APIs. If one or more Cloud APIs is enabled/disabled, you can re-run terraform apply and this module will make the appropriate changes to IAM. 

Optionally, you can set `var.additional_iam_members` to assign `roles/NetworkUser` role to additional members. The supported member types are detailed below.

## Example

Assign `roles/NetworkUser` role to default and 
```
module "subnet_iam_attach" {
  source  = "lancyqusa/subnet-iam-attach/google"
  version = "1.0.0"
  host_project_id        = "host-prj"
  service_project_id     = "service-prj"
  region                 = "us-central1"
  subnet                 = "subnet-01"
  additional_iam_members = each.value.members # ["serviceAccount:terraform-sa-account@service-prj.iam.gserviceaccount.com", "user:john.doe@example.com"]
}
```

## Service Project Management
Shared VPC connects projects within the same organization. Participating host and service projects cannot belong to different organizations. Linked projects can be in the same or different folders, but if they are in different folders the admin must have Shared VPC Admin rights to both folders. Refer to the Google Cloud resource hierarchy for more information about organizations, folders, and projects.
- https://cloud.google.com/vpc/docs/shared-vpc


## Prerequisites
Terraform can be downloaded from HashiCorp's [site](https://www.terraform.io/downloads.html).
Alternatively you can use your system's package manager.

The Terraform version is defined in the `terraform` block in `terraform.tf`

`gcloud` can be installed using Google's [documentation](https://cloud.google.com/sdk/docs/install).

# Supported Google Products
All products listed below should be supported by this terraform module and automatically grant the appropriate permissions to attached services projects <b><i>based on enabled apis</i></b>. No additional IAM work should be required.
- Cloud Composer:
  - https://cloud.google.com/composer/docs/how-to/managing/configuring-shared-vpc#configure_the_host_project
- Google Kubernetes
  - Engine: https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc#enabling_and_granting_roles
- Traffic Director:
  - https://cloud.google.com/architecture/configuring-traffic-director-with-shared-vpc-on-multiple-gke-clusters#configure_iam_roles
- Cloud Functions: 
  - https://cloud.google.com/functions/docs/networking/shared-vpc-host-project#provide_access_to_the_connector
  - https://cloud.google.com/functions/docs/networking/shared-vpc-service-projects#grant-permissions
- Cloud Run:
  - https://cloud.google.com/run/docs/configuring/shared-vpc-host-project#provide_access_to_the_connector
  - https://cloud.google.com/run/docs/configuring/shared-vpc-service-projects#grant-permissions
- Serverless VPC Access: (This is a duplciate entry for Cloud Function/Run snippets above)
  - https://cloud.google.com/vpc/docs/configure-serverless-vpc-access#service_account_permissions
- Dataproc:
  - https://cloud.google.com/dataproc/docs/concepts/configuring-clusters/network#create_a_cluster_that_uses_a_network_in_another_project
- Dataflow:
  - https://cloud.google.com/dataflow/docs/guides/specifying-networks#shared
- Data Fusion:
  - https://cloud.google.com/data-fusion/docs/how-to/create-private-ip#set_up_iam_permissions  
- Vertex AI:
  - https://cloud.google.com/vertex-ai/docs/workbench/user-managed/service-perimeter#shared-vpc
- Cloud TPU:
  - https://cloud.google.com/tpu/docs/shared-vpc-networks
- Cloud Workstations: (Not Documented yet)
  - https://cloud.google.com/workstations/docs/architecture

# Supported Member Types for `var.additional_iam_members`
Identities that will be granted the privilege in role. Each entry can have one of the following values:

- allUsers: A special identifier that represents anyone who is on the internet; with or without a Google account.
- allAuthenticatedUsers: A special identifier that represents anyone who is authenticated with a Google account or a service account.
- user:{emailid}: An email address that represents a specific Google account. For example, alice@gmail.com or joe@example.com.
- serviceAccount:{emailid}: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
- group:{emailid}: An email address that represents a Google group. For example, admins@example.com.
- domain:{domain}: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.
- projectOwner:projectid: Owners of the given project. For example, "projectOwner:my-example-project"
- projectEditor:projectid: Editors of the given project. For example, "projectEditor:my-example-project"
- projectViewer:projectid: Viewers of the given project. For example, "projectViewer:my-example-project"

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_iam_members"></a> [additional\_iam\_members](#input\_additional\_iam\_members) | List of users, groups, and service accounts that need access to subnets | `list` | `[]` | no |
| <a name="input_host_project_id"></a> [host\_project\_id](#input\_host\_project\_id) | Host project\_id that the service project will be attached to | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region of the subnetwork | `any` | n/a | yes |
| <a name="input_service_project_id"></a> [service\_project\_id](#input\_service\_project\_id) | Service project\_id that the will be attached to a host project | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Subnet Self link | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_iam_members"></a> [additional\_iam\_members](#output\_additional\_iam\_members) | n/a |
| <a name="output_iam_role_mappings"></a> [iam\_role\_mappings](#output\_iam\_role\_mappings) | n/a |