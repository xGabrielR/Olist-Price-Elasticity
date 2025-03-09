resource "kubectl_manifest" "ebs" {
  yaml_body  = file("${path.module}/manifests/ebs.yaml")
}