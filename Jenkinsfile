pipeline{
    agent any
    environment {
	    path = "${PATH}:${getTerraformPath()}"
                }

    stages{
        
	stage ("Terraform Init"){
            steps{
                    sh "terraform init"
                 }
            }
	stage ('Terraform Plan'){
            steps{
                    sh 'terraform plan'
                }
            }
    stage ('Terraform apply'){
            steps{
                    sh 'terraform apply -auto-approve'
                }
            }
	stage ('Run Ansible Playbook'){
            steps{
                    sh "ansiblePlaybook disableHostKeyChecking: true, installation: 'ansible', playbook: 'playbook.yml'"			
					}
	}
	post{
		success{
			sh 'terraform destroy -auto-approve'
		}
	}
}
}
	
	def getTerraformPath(){
	   def tfpath = tool name: 'terraform', type: 'terraform'  
	   return tfpath	
	}
