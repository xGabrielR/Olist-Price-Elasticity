resource "kubernetes_namespace" "airflow" {
  metadata {
    name = var.airflow_namespace
  }
}

resource "kubectl_manifest" "airflow_database_service" {
  depends_on = [kubernetes_namespace.airflow]
  yaml_body  = file("${path.module}/manifests/service.yaml")
}

resource "kubectl_manifest" "airflow_database_pv" {
  depends_on = [kubernetes_namespace.airflow]
  yaml_body  = file("${path.module}/manifests/pv.yaml")
}

resource "kubectl_manifest" "airflow_database_pvc" {
  depends_on = [
    kubernetes_namespace.airflow,
    kubectl_manifest.airflow_database_pv
  ]

  yaml_body = file("${path.module}/manifests/pvc.yaml")
}

resource "kubectl_manifest" "airflow_database_deployment" {
  depends_on = [
    kubernetes_namespace.airflow,
    kubectl_manifest.airflow_database_pvc
  ]

  yaml_body = templatefile(
    "${path.module}/manifests/deployment.yaml",
    {
      AIRFLOW_NAMESPACE         = var.airflow_namespace
      AIRFLOW_DATABASE_USER     = var.airflow_database_user
      AIRFLOW_DATABASE_PASSWORD = var.airflow_database_password
      AIRFLOW_DATABASE_NAME     = var.airflow_database_name
    }
  )
}