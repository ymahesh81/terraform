pipeline{
    agent any
    environment {
        TF_VAR_region = 'ap-south-1'
    }
        parameters{
            choice(
                choices:['plan','apply','destroy'],
                name:'Actions',
                description: 'Describes the Actions')
            booleanParam(
                defaultValue: false,
                description: 'plan',
                name: 'Planning'
                )
            booleanParam(
                defaultValue: false,
                description: 'apply',
                name: 'Apply')
            booleanParam(
                defaultValue: false,
                description: 'destroy',
                name: 'Destroy')
        }
        
        stages{

            stage('init'){
                steps{
                    sh"terraform init"
                }
            }
            stage('Validate'){
                steps{
                    sh"terraform validate"
                }
            }

            stage('action'){

                stages{
                    stage('Plan'){
                         when {
                       expression{params.plan == true
                       }
                }
                steps{
                    
                    sh"terraform plan -out=tfplan"
                    
                    }

                }
                stage('Apply'){
                         when {
                       expression{params.apply == true
                       }
                }
                steps{
                    
                    sh"terraform apply -auto-approve tfplan"
                    
                    }

                }
                stage('Destroy'){
                         when {
                       expression{params.destroy == true
                       }
                }
                steps{
                    
                    sh"terraform destroy -auto-approve"
                    
                    }

                  }              
              }
               
            }
            stage('Terraform Completed'){
                steps{
                    echo "Terraform Done..!"
                    
            }
        }
    }
}