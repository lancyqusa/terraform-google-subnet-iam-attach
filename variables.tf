variable "host_project_id" {
  description = "Host project_id that the service project will be attached to"
  type        = string
}

variable "service_project_id" {
  description = "Service project_id that the will be attached to a host project"
  type        = string
}

variable "region" {
  description = "Region of the subnetwork"
}

variable "subnet" {
  description = "Subnet Self link"
}


variable "additional_iam_members" {
  description = "List of users, groups, and service accounts that need access to subnets"
  default     = []
  # Identities that will be granted the privilege in role. Each entry can have one of the following values:

  # allUsers: A special identifier that represents anyone who is on the internet; with or without a Google account.
  # allAuthenticatedUsers: A special identifier that represents anyone who is authenticated with a Google account or a service account.
  # user:{emailid}: An email address that represents a specific Google account. For example, alice@gmail.com or joe@example.com.
  # serviceAccount:{emailid}: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
  # group:{emailid}: An email address that represents a Google group. For example, admins@example.com.
  # domain:{domain}: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.
  # projectOwner:projectid: Owners of the given project. For example, "projectOwner:my-example-project"
  # projectEditor:projectid: Editors of the given project. For example, "projectEditor:my-example-project"
  # projectViewer:projectid: Viewers of the given project. For example, "projectViewer:my-example-project"

}