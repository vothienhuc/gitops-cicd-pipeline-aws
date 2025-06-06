data "aws_eks_cluster" "eks" {
  name = var.eks_cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.eks_cluster_name
}

data "tls_certificate" "eks_cluster" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_cluster.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

# ///////////////////////////// IAM Roles For OIDC /////////////////////

# Policy to allow access to Secrets Manager
resource "aws_iam_policy" "external_secrets_policy" {
  name        = "ExternalSecretsAccessPolicy"
  description = "Policy to allow External Secrets Operator to access AWS Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets",
        ],
        Resource = "*"
      }
    ]
  })
}

# IAM Role for IRSA
resource "aws_iam_role" "external_secrets_irsa" {
  name = "external-secrets-irsa"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::339007232055:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/48DC87EFF767AF96E3E66B49849F3CC0"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${replace(data.aws_eks_cluster.eks.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:external-secrets:external-secrets"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_external_secrets_policy" {
  role       = aws_iam_role.external_secrets_irsa.name
  policy_arn = aws_iam_policy.external_secrets_policy.arn
}
