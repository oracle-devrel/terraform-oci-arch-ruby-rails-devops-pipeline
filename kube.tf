resource "time_sleep" "wait_8min" {
  depends_on = [
  oci_devops_deploy_stage.test_deploy_stage,
  oci_devops_deploy_pipeline.test_deploy_pipeline,
  oci_devops_deploy_environment.test_environment,
  oci_devops_deploy_artifact.test_deploy_oke_artifact,
  oci_devops_build_run.test_build_run_1
  ]
  create_duration = "480s"
}


resource "null_resource" "example1" {
   depends_on = [time_sleep.wait_8min]
  provisioner "local-exec" {
    command = "/bin/bash ./generated/kube.sh > /tmp/ip_addr" 
    
  }
}

data "local_file" "ip_addr" {
    depends_on = [null_resource.example1]
    filename = "/tmp/ip_addr"
}

output "ip_endpoint" {
  value       = "Endpoint is ${data.local_file.ip_addr.content} "
  description = "Endpoint for website"
}