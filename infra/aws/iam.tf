# Aws EKS 

resource "aws_iam_policy" "eks_full_access" {
  name   = "my-eks-role"
  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "*",
                "Resource": "*"
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "eks_s3_policy_attachment" {
  policy_arn = aws_iam_policy.eks_full_access.arn
  role       = module.eks.cluster_iam_role_name
  depends_on = [aws_iam_policy.eks_full_access]
}

# AWS Glue

resource "aws_iam_role" "rl" {
  name               = "ols-glue-role"
  path               = "/"
  description        = "Default Aws Role"
  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "glue.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
  EOF
  tags               = local.common_tags
}

resource "aws_iam_policy" "pl" {
  name        = "ols-glue-policy"
  path        = "/"
  description = "Default Aws Policy"
  policy      = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "*",
                "Resource": "*"
            }
        ]
    }
  EOF
  tags        = local.common_tags
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.rl.name
  policy_arn = aws_iam_policy.pl.arn
}