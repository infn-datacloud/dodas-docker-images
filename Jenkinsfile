pipeline {

    agent {
        node { label 'jenkinsworker00' }
    }
    
    environment {
        HARBOR_CREDENTIALS = 'harbor-paas-credentials'
        JHUB_IMAGE_NAME = 'datacloud-templates/snj-base-jhub'
        BASE_LAB_IMAGE_NAME = 'datacloud-templates/snj-base-lab'
        BASE_LAB_GPU_IMAGE_NAME = 'datacloud-templates/snj-base-lab-gpu'
        LAB_PERSISTENCE_IMAGE_NAME = 'datacloud-templates/snj-base-lab-persistence'
        LAB_COLLABORATIVE_IMAGE_NAME = 'datacloud-templates/snj-base-labc'
        LAB_COLLABORATIVE_GPU_IMAGE_NAME = 'datacloud-templates/snj-base-jlabc-gpu'
        COLLABORATIVE_PROXY_IMAGE_NAME = 'datacloud-templates/snj-base-jlabc-proxy'
        NOTEBOOK_IMAGE_NAME = 'datacloud-templates/snj-base-notebook'
        SANITIZED_BRANCH_NAME = env.BRANCH_NAME.replace('/', '_')
    }
    
    stages {
    //     stage('Build Hub Image') {
    //         steps {
    //             script {
    //                 def jhubImage = docker.build(
    //                     "${JHUB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
    //                     "--no-cache -f docker/single-node-jupyterhub/jupyterhub/Dockerfile docker/single-node-jupyterhub/jupyterhub"
    //                 )
    //             }
    //         }
    //     }
    //     stage('Push Hub Image to Harbor') {
    //         steps {
    //             script {
    //                 def jhubImage = docker.image("${JHUB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
    //                 docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {jhubImage.push()}
    //             }
    //         }
    //     }
        
    //     stage('Build Base Lab Image') {
    //         steps {
    //             script {
    //                 def baseLabImage = docker.build(
    //                     "${BASE_LAB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
    //                     "--no-cache -f docker/single-node-jupyterhub/lab/Dockerfile docker/single-node-jupyterhub/lab"
    //                 )
    //             }
    //         }
    //     }
    //     stage('Push Base Image to Harbor') {
    //         steps {
    //             script {
    //                 def baseLabImage = docker.image("${BASE_LAB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
    //                 docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {baseLabImage.push()}
    //             }
    //         }
    //     }

    //     stage('Build Derived Lab Image') {
    //         parallel {
    //             stage('Build Persistence Image'){
    //                 steps {
    //                     script {
    //                         def labPerstenceImage = docker.build(
    //                             "${LAB_PERSISTENCE_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
    //                             "--build-arg BASE_IMAGE=${BASE_LAB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME} --no-cache -f docker/single-node-jupyterhub/lab/base-persistence/Dockerfile docker/single-node-jupyterhub/lab/base-persistence"
    //                         )
    //                     }
    //                 }
    //             }
    //             stage('Build Collaborative Image'){
    //                 steps {
    //                     script {
    //                         def labCollImage = docker.build(
    //                             "${LAB_COLLABORATIVE_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
    //                             "--build-arg BASE_IMAGE=${BASE_LAB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME} --no-cache -f docker/single-node-jupyterhub/jupyterlab-collaborative/Dockerfile docker/single-node-jupyterhub/jupyterlab-collaborative"
    //                         )
    //                     }
    //                 }
    //             }
    //         }
    //     }
    //     stage('Push Derived Persistence Image to Harbor') {
    //         steps {
    //             script {
    //                 def labPerstenceImage = docker.image("${LAB_PERSISTENCE_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
    //                 docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {labPerstenceImage.push()}
    //             }
    //         }
    //     }
    //     stage('Push Derived Collaborative Image to Harbor') {
    //         steps {
    //             script {
    //                 def labCollImage = docker.image("${LAB_COLLABORATIVE_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
    //                 docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {labCollImage.push()}
    //             }
    //         }
    //     }

    //     stage('Build Collaborative Proxy Image') {
    //         steps {
    //             script {
    //                 def CollProxyImage = docker.build(
    //                     "${COLLABORATIVE_PROXY_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
    //                     "--no-cache -f docker/single-node-jupyterhub/jupyterlab-collaborative-proxy/Dockerfile docker/single-node-jupyterhub/jupyterlab-collaborative-proxy"
    //                 )
    //             }
    //         }
    //     }
    //     stage('Push Collaborative Proxy Image to Harbor') {
    //         steps {
    //             script {
    //                 def CollProxyImage = docker.image("${COLLABORATIVE_PROXY_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
    //                 docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {CollProxyImage.push()}
    //             }
    //         }
    //     }

    //     stage('Build Notebook Image') {
    //         steps {
    //             script {
    //                 def notebookImage = docker.build(
    //                     "${NOTEBOOK_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
    //                     "--no-cache -f docker/single-node-jupyterhub/notebook/Dockerfile docker/single-node-jupyterhub/notebook"
    //                 )
    //             }
    //         }
    //     }
    //     stage('Push Notebook Image to Harbor') {
    //         steps {
    //             script {
    //                 def notebookImage = docker.image("${NOTEBOOK_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
    //                 docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {notebookImage.push()}
    //             }
    //         }
    //     }
    
        stage('Build Base Lab GPU Image') {
            steps {
                script {
                    def baseLabGpuImage = docker.build(
                        "${BASE_LAB_GPU_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
                        "--no-cache -f docker/single-node-jupyterhub/lab/Dockerfile docker/single-node-jupyterhub/lab"
                    )
                }
            }
        }
        stage('Push Base Lab GPU Image to Harbor') {
            steps {
                script {
                    def baseLabGpuImage = docker.image("${BASE_LAB_GPU_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
                    docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {baseLabGpuImage.push()}
                }
            }
        }
        
        stage('Build Collaborative GPU Image') {
            steps {
                script {
                    def labCollGpuImage = docker.build(
                        "${LAB_COLLABORATIVE_GPU_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}",
                        "--no-cache -f docker/single-node-jupyterhub/jupyterlab-collaborative/Dockerfile docker/single-node-jupyterhub/jupyterlab-collaborative"
                    )
                }
            }
        }
        stage('Push Collaborative GPU Image to Harbor') {
            steps {
                script {
                    def labCollGpuImage = docker.image("${LAB_COLLABORATIVE_GPU_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}")
                    docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {labCollGpuImage.push()}
                }
            }
        }
    }
    
    post {
        success {
            echo 'Docker image build and push successful!'
        }
        failure { // Optionally, you can add a notification or other failure-handling logic here.
            echo 'Docker image build and push failed!'
        }
    }
}
