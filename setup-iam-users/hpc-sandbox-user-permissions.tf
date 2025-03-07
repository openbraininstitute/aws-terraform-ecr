data "aws_iam_policy_document" "hpc_user_access_policy" {
  statement {
    sid    = "HPC User Access Policy"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::130659266700:user/heeren"]
    }
    actions = [
      "ecr-public:DescribeImages",
      "ecr-public:DescribeRepositories",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories"
    ]
  }
}

resource "aws_ecrpublic_repository_policy" "hpc_user_access" {
  repository_name = "hpc-resource-provisioner"
  policy          = data.aws_iam_policy_document.hpc_user_access_policy.json
}
