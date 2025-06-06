variable "mySQL_username" {
  type = string
  sensitive = true
}
variable "mySQL_password" {
  type = string
  sensitive = true
}

variable "mySQL_hostname" {
  type = string
  description = "Hostname for MySQL database"
  default = "my-mysql"
}