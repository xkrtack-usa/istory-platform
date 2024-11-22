# # 기존 CICD 사용자 데이터 소스
# data "aws_iam_user" "cicd" {
#   user_name = "cicd"
# }

# # # EKS Admin 정책
# # resource "aws_iam_policy" "eks_admin" {
# #   name        = "AmazonEKSAdminPolicy"
# #   description = "Custom EKS Admin Policy"

# #   policy = jsonencode({
# #     Version = "2012-10-17"
# #     Statement = [
# #       {
# #         Effect = "Allow"
# #         Action = [
# #           "eks:*"
# #         ]
# #         Resource = "*"
# #       }
# #     ]
# #   })
# # }

# # # EKS Cluster Admin 정책
# # resource "aws_iam_policy" "eks_cluster_admin" {
# #   name        = "AmazonEKSClusterAdminPolicy"
# #   description = "Custom EKS Cluster Admin Policy"

# #   policy = jsonencode({
# #     Version = "2012-10-17"
# #     Statement = [
# #       {
# #         Effect = "Allow"
# #         Action = [
# #           "eks:*",
# #           "ec2:DescribeInstances",
# #           "ec2:DescribeRouteTables",
# #           "ec2:DescribeSecurityGroups",
# #           "ec2:DescribeSubnets",
# #           "ec2:DescribeVpcs",
# #           "iam:GetRole",
# #           "iam:ListAttachedRolePolicies",
# #           "iam:PassRole"
# #         ]
# #         Resource = "*"
# #       }
# #     ]
# #   })
# # }

# # # 정책들을 CICD 사용자에게 연결
# # resource "aws_iam_user_policy_attachment" "cicd_eks_admin" {
# #   user       = data.aws_iam_user.cicd.user_name
# #   policy_arn = aws_iam_policy.eks_admin.arn
# # }

# # resource "aws_iam_user_policy_attachment" "cicd_eks_cluster_admin" {
# #   user       = data.aws_iam_user.cicd.user_name
# #   policy_arn = aws_iam_policy.eks_cluster_admin.arn
# # }

# # aws-auth ConfigMap에 CICD 사용자 매핑
# resource "kubernetes_config_map_v1_data" "aws_auth_users" {
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }

#   data = {
#     mapUsers = yamlencode([
#       {
#         userarn  = data.aws_iam_user.cicd.arn
#         username = data.aws_iam_user.cicd.user_name
#         groups   = ["system:masters"]  # 클러스터 관리자 권한
#       }
#     ])
#   }

#   force = true
# }

