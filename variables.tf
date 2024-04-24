variable "name" {
  description = "Used for naming resources"
  type        = string
}

variable "zones" {
  description = "List of zones to create"
  type        = list(string)
}

variable "assume_accounts" {
  description = "Accounts that will be able to assume the roles created with enough permission to edit the zones"
  type        = list(string)
}

# variable "tf_variable_set_id" {
#   description = "If given, will create a variable in this set with the created role ARN"
#   type        = string
#   default     = null
# }
