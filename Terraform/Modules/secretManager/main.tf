#  ////////////////////////////// My SQL Secret Manager ///////////////////////////// 
resource "aws_secretsmanager_secret" "mysql_secret" {
  name = "mysql-credentials"
}

resource "aws_secretsmanager_secret_version" "mysql_secret_version" {
  secret_id = aws_secretsmanager_secret.mysql_secret.id
  secret_string = jsonencode({
    MYSQL_ROOT_PASSWORD = var.mySQL_password
    hostname            = "mysql-service"
    username            = var.mySQL_username
    password            = var.mySQL_password
    port                = "3306"
  })
}

#  ////////////////////////////// Redis Secret Manager ///////////////////////////// 
resource "aws_secretsmanager_secret" "redis_secret" {
  name = "redis-credentials"
}

resource "aws_secretsmanager_secret_version" "redis_secret_version" {
  secret_id = aws_secretsmanager_secret.redis_secret.id
  secret_string = jsonencode({
    hostname = "redis-service"
    port     = "6379"
  })
}
