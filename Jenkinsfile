pipeline {

    agent {
        node { label 'jenkinsworker00' }
    }
    
    environment {
        HARBOR_CREDENTIALS = 'harbor-paas-credentials'
        JHUB_IMAGE_NAME = 'datacloud-templates/snj-base-jhub'
        BASE_LAB_IMAGE_NAME = 'datacloud-templates/snj-base-lab'
        BASE_LAB_PERSISTENCE_IMAGE_NAME = 'datacloud-templates/snj-base-lab-persistence'
        BASE_LAB_COLLABORATIVE_IMAGE_NAME = 'datacloud-templates/snj-base-lab-collaborative'
        SANITIZED_BRANCH_NAME = env.BRANCH_NAME.replace('/', '_')
    }
    
    stages {
        stage('Build Hub Image') {
            steps {
                script {
                    def jhubImage = docker.build(
                        "${JHUB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
                        "--no-cache -f docker/single-node-jupyterhub/jupyterhub/Dockerfile docker/single-node-jupyterhub/jupyterhub"
                    )
                }
            }
        }
        
        stage('Build Base Lab Image') {
            steps {
                script {
                    def baseLabImage = docker.build(
                        "${BASE_LAB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
                        "--no-cache -f docker/single-node-jupyterhub/lab/Dockerfile docker/single-node-jupyterhub/lab"
                    )
                }
            }
        }

        stage('Build Derived Lab Image') {
            parallel {
                stage('Build Persistence Image'){
                    steps {
                        script {
                            def derivedPerstenceImage = docker.build(
                                "${BASE_LAB_PERSISTENCE_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
                                "--build-arg BASE_IMAGE=${BASE_LAB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME} --no-cache -f docker/single-node-jupyterhub/lab/base-persistence/Dockerfile docker/single-node-jupyterhub/lab/base-persistence"
                            )
                        }
                    }
                }
                stage('Build Collaborative Image'){
                    steps {
                        script {
                            def derivedCollImage = docker.build(
                                "${BASE_LAB_COLLABORATIVE_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
                                "--build-arg BASE_IMAGE=${BASE_LAB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME} --no-cache -f docker/single-node-jupyterhub/jupyterlab-collaborative/Dockerfile docker/single-node-jupyterhub/jupyterlab-collaborative"
                            )
                        }
                    }
                }
            }
        }

        stage('Push Hub Image to Harbor') {
            steps {
                script {
                    def jhubImage = docker.image("${JHUB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
                    docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {
                        jhubImage.push()
                    }
                }
            }
        }

        stage('Push Base Image to Harbor') {
            steps {
                script {
                    def baseLabImage = docker.image("${BASE_LAB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
                    docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {
                        baseLabImage.push()
                    }
                }
            }
        }

        stage('Push Derived Image to Harbor') {
            parallel {
                stage('Push Persistence Image') {
                    steps {
                        script {
                            def derivedPerstenceImage = docker.image("${BASE_LAB_PERSISTENCE_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
                            docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {
                                derivedPerstenceImage.push()
                            }
                        }
                    }
                }
                stage('Push Collaborative Image') {
                    steps {
                        script {
                            def derivedCollImage = docker.image("${BASE_LAB_COLLABORATIVE_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
                            docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {
                                derivedCollImage.push()
                            }
                        }
                    }
                }  
            }
        }
    }
    
    post {
        success {
            echo 'Docker image build and push successful!'
        }
        failure {
            echo 'Docker image build and push failed!'
            // Optionally, you can add a notification or other failure-handling logic here.
        }
    }
}
