def setup_env_vars(controller_ssh_user, controller_ssh_key_path, infisical_identity_client_id, infisical_identity_secret, infisical_project_id) {
    env.CONTROLLER_SSH_USER = controller_ssh_user
    env.CONTROLLER_SSH_KEY_PATH = controller_ssh_key_path

    env.DEBUG = params.DEBUG

    env.INFISCAL_URL = "${params.INFISCAL_URL}:${params.INFISICAL_PORT}"
    env.INFISCAL_PROJECT_ID = infisical_project_id
    env.INFISCAL_ENVIRONMENT = params.INFISCAL_ENVIRONMENT_SLUG
    env.INFISICAL_UNIVERSAL_AUTH_CLIENT_ID = infisical_identity_client_id
    env.INFISICAL_UNIVERSAL_AUTH_CLIENT_SECRET = infisical_identity_secret
    env.INFISICAL_AUTH_METHOD = 'universal_auth'

    env.CICD_KUBECONFIG_PATH = "${WORKSPACE}/kubeconfig"

    env.TF_VAR_kubeconfig_path = env.CICD_KUBECONFIG_PATH
    env.TF_VAR_python_executable = "${WORKSPACE}/.venv/bin/python3"
    env.TF_VAR_infisical_uri = env.INFISCAL_URL
    env.TF_VAR_infisical_project_id = env.INFISCAL_PROJECT_ID
    env.TF_VAR_infisical_environment_slug = env.INFISCAL_ENVIRONMENT
    env.TF_VAR_infisical_auth_client_id = env.INFISICAL_UNIVERSAL_AUTH_CLIENT_ID
    env.TF_VAR_infisical_auth_client_secret = env.INFISICAL_UNIVERSAL_AUTH_CLIENT_SECRET

    env.CICD_WORKSPACE = WORKSPACE

    def ansible_opts_list = []
    if (params.DEBUG.toBoolean()) {
        ansible_opts_list.add('-v')
    }
    ansible_opts = ansible_opts_list.join(' ')

}

pipeline {
    agent any
    parameters {
        booleanParam(
            name: 'DEBUG',
            defaultValue: false,
            description: 'Enable debug logging and display of secrets'
        )
        string(
            name: 'PYTHON_MASTER_ENVIRONMENT',
            defaultValue: '/opt/master-venv/bin/python3',
            description: 'Path to the Python interpreter for setting up the virtual environment. Used to save time for large libraries.'
        )
        booleanParam(
            name: 'SKIP_VALIDATION',
            defaultValue: false,
            description: 'Skip validation steps'
        )
        booleanParam(
            name: 'TF_DESTROY',
            defaultValue: false,
            description: 'Enable Terraform destroy instead of apply'
        )
        booleanParam(
            name: 'RESET_TF_STATE',
            defaultValue: false,
            description: 'Reset Terraform state before applying changes. Only use if cluster has been reset.'
        )
        credentials(
            name: 'CONTROLLER_SSH_KEY',
            credentialType: 'com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey',
            description: 'SSH key for accessing the controller hosts'
        )
        string(
            name: 'INFISCAL_URL',
            defaultValue: 'http://localhost'
        )
        string(
            name: 'INFISICAL_PORT',
            defaultValue: '80'
        )
        credentials(
            name: 'INFISICAL_IDENTITY',
            credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl',
            description: 'Infisical service identity for universal authentication'
        )
        credentials(
            name: 'INFISCAL_PROJECT_ID',
            credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.StringCredentialsImpl',
            description: 'Infisical project ID, normally UUID'
        )
        choice(
            name: 'INFISCAL_ENVIRONMENT_SLUG',
            choices: ['prod', 'dev', 'staging'],
            description: 'Infisical environment, e.g. prod, dev, staging'
        )
    }

    stages {
        stage('setup-environment') {
            steps {
                echo 'Preparing environment...'
                script {
                    sh "${params.PYTHON_MASTER_ENVIRONMENT} -m venv ${WORKSPACE}/.venv"
                    sh "${WORKSPACE}/.venv/bin/pip install --no-cache-dir --upgrade pip"
                    sh "${WORKSPACE}/.venv/bin/pip install --no-cache-dir -r requirements.txt"
                    sh "${WORKSPACE}/.venv/bin/ansible-galaxy install -r ${WORKSPACE}/roles/requirements.yml"
                }
            }
        }
        stage('validate-configuration') {
            when {
                expression { return !params.SKIP_VALIDATION.toBoolean() }
            }
            steps {
                echo 'Validating Ansible playbook syntax...'
                    script {
                        try {
                            sh "${WORKSPACE}/.venv/bin/ansible-lint ${WORKSPACE}/playbooks/*.yml"
                        } catch (err) {
                        echo "Ansible linting validation failed: ${err}"
                        if (env.BRANCH_NAME == 'main') {
                            timeout(time: 5, unit: 'MINUTES') {
                                input(id: 'validation_failure_input', message: 'Would you like to still proceed?')
                                unstable("Proceeding despite validation failure on main branch.")
                            }
                        } else {
                            unstable("Allowing to proceed on non-main branch.")
                        }
                    }
                }
            }
        }
        stage('reset-terraform-state') {
            when {
                expression { return params.RESET_TF_STATE.toBoolean() }
            }
            steps {
                echo 'Resetting Terraform state...'
                script {
                    sh "rm -rf ${WORKSPACE}/terraform/.terraform/"
                    sh "rm -f ${WORKSPACE}/terraform/terraform.tfstate"
                }
            }
        }
        stage('run-terraform-destroy') {
            when {
                expression { return params.TF_DESTROY.toBoolean() }
            }
            steps {
                withCredentials([
                    sshUserPrivateKey(credentialsId: params.CONTROLLER_SSH_KEY, usernameVariable: 'controller_ssh_user', keyFileVariable: 'controller_ssh_key_path'),
                    usernamePassword(credentialsId: params.INFISICAL_IDENTITY, usernameVariable: 'infisical_identity_client_id', passwordVariable: 'infisical_identity_secret'),
                    string(credentialsId: params.INFISCAL_PROJECT_ID, variable: 'infisical_project_id')
                    ]) {
                    echo 'Fetching kubeconfig...'
                    setup_env_vars(controller_ssh_user, controller_ssh_key_path, infisical_identity_client_id, infisical_identity_secret, infisical_project_id)
                    script {
                        sh "${WORKSPACE}/.venv/bin/ansible-playbook '${WORKSPACE}/playbooks/update_kubeconfig.yml' ${ansible_opts}"
                    }
                    echo 'Terraform init...'
                    script {
                        sh "terraform -chdir='${WORKSPACE}/terraform' init -no-color -upgrade"
                    }
                    echo 'Terraform plan destroy...'
                    script {
                        sh "terraform -chdir='${WORKSPACE}/terraform' plan -no-color -out=terraform.tfplan -destroy"
                    }
                    input message: "Approve destroy?"
                    echo 'Terraform destroy...'
                    script {
                        sh "terraform -chdir='${WORKSPACE}/terraform' apply -no-color terraform.tfplan"
                    }
                }
            }
        }
        stage('make-cluster-services') {
            steps {
                withCredentials([
                    sshUserPrivateKey(credentialsId: params.CONTROLLER_SSH_KEY, usernameVariable: 'controller_ssh_user', keyFileVariable: 'controller_ssh_key_path'),
                    usernamePassword(credentialsId: params.INFISICAL_IDENTITY, usernameVariable: 'infisical_identity_client_id', passwordVariable: 'infisical_identity_secret'),
                    string(credentialsId: params.INFISCAL_PROJECT_ID, variable: 'infisical_project_id')
                    ]) {
                    echo 'Fetching kubeconfig...'
                    setup_env_vars(controller_ssh_user, controller_ssh_key_path, infisical_identity_client_id, infisical_identity_secret, infisical_project_id)
                    script {
                        sh "${WORKSPACE}/.venv/bin/ansible-playbook '${WORKSPACE}/playbooks/update_kubeconfig.yml' ${ansible_opts}"
                    }
                    echo 'Terraform init...'
                    script {
                        sh "terraform -chdir='${WORKSPACE}/terraform' init -no-color -upgrade"
                    }
                    echo 'Terraform plan...'
                    script {
                        sh "terraform -chdir='${WORKSPACE}/terraform' plan -no-color -out=terraform.tfplan"
                    }
                    input message: "Approve deployment?"
                    echo 'Terraform apply...'
                    script {
                        sh "terraform -chdir='${WORKSPACE}/terraform' apply -no-color terraform.tfplan"
                    }
                }
            }
        }
    }
    // Post work actions
    post {
        success {
            echo "${params.STACK_NAME} ${BUILD_TAG} Completed Successfully"
        }
        always {
            sh(script: "rm -rf ${env.TF_DIR}/")
        }
    }
}
