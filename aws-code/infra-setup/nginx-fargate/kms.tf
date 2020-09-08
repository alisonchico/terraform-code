#
# kms
#
data "aws_iam_policy_document" "nexwebapp-artifacts-kms-policy" {
  policy_id = "key-default-1"
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "kms:*",
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_kms_key" "nexwebapp" {
  description = "kms key for nexwebapp artifacts"
  policy      = data.aws_iam_policy_document.nexwebapp-artifacts-kms-policy.json
}

resource "aws_kms_alias" "nexwebapp" {
  name          = "alias/nexwebapp2"
  target_key_id = aws_kms_key.nexwebapp.key_id
}

