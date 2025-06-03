
resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = var.eks_cluster_name
  addon_name   = "aws-ebs-csi-driver"
  addon_version = "v1.44.0-eksbuild.1" 

  service_account_role_arn = aws_iam_role.ebs_csi_driver_role.arn

  tags = {
    Name = "EBS CSI Driver"
  }

  depends_on = [
    aws_iam_role_policy_attachment.ebs_csi_driver_controller_policy
  ]
}

#--------------------------------------------------------------------------
#---------------------- IAM Role for EBS CSI Driver ----------------------
# ---------------------------------------------------------------------------
resource "aws_iam_role" "ebs_csi_driver_role" {
  name = "${var.eks_cluster_name}-ebs-csi-driver-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Federated = var.oidc_provider_arn
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "${replace(var.oidc_provider_url, "https://", "")}:sub" = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
        }
      }
    }]
  })
}


resource "aws_iam_role_policy_attachment" "ebs_csi_driver_controller_policy" {
  role       = aws_iam_role.ebs_csi_driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}





