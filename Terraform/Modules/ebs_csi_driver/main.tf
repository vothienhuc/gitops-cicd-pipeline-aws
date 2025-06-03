
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
  name = "AmazonEKS_EBS_CSI_DriverRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::${var.aws_account_id}:oidc-provider/${var.oidc_provider_url}"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${var.oidc_provider_url}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_controller_policy" {
  role       = aws_iam_role.ebs_csi_driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}





