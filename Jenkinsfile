[11:59] Enrico Vianello
def isBranchMasterAndIsTag() {
    return env.BRANCH_NAME=="master" && env.GIT_TAG!=null && env.GIT_TAG != ''
}
 
def isNotBranchMaster() {
    return env.BRANCH_NAME!="master"
}
 
// def buildAndPushImage(String imageName, String dockerFilePath, String dockerBuildDir) {
//     def dockerImage = docker.build(imageName, "--no-cache -f ${dockerFilePath} ${dockerBuildDir}")
//     docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {
//         dockerImage.push()
//     }
// }
 
def buildAndPushImage(String imageName, String dockerBuildOptions) {
    def dockerImage = docker.build(imageName, dockerBuildOptions)
    docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {
        dockerImage.push()
    }
}
 
def getReleaseVersion(String tagName) {
    if (tagName) {
        return tagName.replaceAll(/^v/, '')
    } else {
        return null
    }
}
 
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
        ML_INFN_BASE_LAB_IMAGE_NAME = 'datacloud-templates/ml-infn-lab'
        ML_INFN_LAB_COLLABORATIVE_IMAGE_NAME = 'datacloud-templates/ml-infn-jlabc'
        BASE_LAB_CC7_IMAGE_NAME = 'datacloud-templates/snj-base-lab-cc7'
        CYGNO_LAB_IMAGE_NAME = 'datacloud-templates/cygno-lab'
        CYGNO_LAB_WN_IMAGE_NAME = 'datacloud-templates/cygno-lab-wn'
        JUP_MATLAB_IMAGE_NAME = 'datacloud-templates/jupyter_matlab'
        COLL_MATLAB_IMAGE_NAME = 'datacloud-templates/collaborative_matlab'
        PARAL_MATLAB_IMAGE_NAME = 'datacloud-templates/jupyter_matlab_parallel'
        JAAS_USER_IMAGE_NAME = 'datacloud-templates/jaas_user_containers'
        NAAS_MATLAB_IMAGE_NAME = 'datacloud-templates/naas_matlab'
        NAAS_PARALLEL_IMAGE_NAME = 'datacloud-templates/naas_matlab_parallel'
        SPARK_IMAGE_NAME = 'datacloud-templates/spark'
        JHUB_SPARK_IMAGE_NAME = 'datacloud-templates/jhub-spark'
 
        RELEASE_VERSION = getReleaseVersion(TAG_NAME)
        SANITIZED_BRANCH_NAME = env.BRANCH_NAME.replace('/', '_')
    }
    
    stages {
        stage('Build and Push jHub Image if master') {
            when { expression { return isBranchMasterAndIsTag() } }
            environment {
                IMAGE_NAME = "${JHUB_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKERFILE_PATH = "docker/single-node-jupyterhub/jupyterhub/Dockerfile"
                DOCKERBUILD_DIR = "docker/single-node-jupyterhub/jupyterhub"
                DOCKER_BUILD_OPTIONS = "--no-cache -f ${env.DOCKERFILE_PATH} ${env.DOCKERBUILD_DIR}"
            }
            steps {
                script {
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }
        stage('Build and Push jHub Image if not master') {
            when { expression { return isNotBranchMaster() } }
            environment {
                IMAGE_NAME = "${JHUB_IMAGE_NAME}:${env.SANITIZED_BRANCH_NAME}"
                DOCKERFILE_PATH = "docker/single-node-jupyterhub/jupyterhub/Dockerfile"
                DOCKERBUILD_DIR = "docker/single-node-jupyterhub/jupyterhub"
                DOCKER_BUILD_OPTIONS = "--no-cache -f ${env.DOCKERFILE_PATH} ${env.DOCKERBUILD_DIR}"
            }
            steps {
                script {
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }
        
        // stage('Build Base Lab Image') {
        //     steps {
        //         script {
        //             def baseLabImage = docker.build(
        //                 "${BASE_LAB_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--no-cache -f docker/single-node-jupyterhub/lab/Dockerfile docker/single-node-jupyterhub/lab"
        //             )
        //         }
        //     }
        // }
        // stage('Push Base Image to Harbor') {
        //     steps {
        //         script {
        //             def baseLabImage = docker.image("${BASE_LAB_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {baseLabImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build Derived Lab Image') {
        //     parallel {
        //         stage('Build Persistence Image'){
        //             steps {
        //                 script {
        //                     def labPerstenceImage = docker.build(
        //                         "${LAB_PERSISTENCE_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                         "--build-arg BASE_IMAGE=${BASE_LAB_IMAGE_NAME}:${env.RELEASE_VERSION} --no-cache -f docker/single-node-jupyterhub/lab/base-persistence/Dockerfile docker/single-node-jupyterhub/lab/base-persistence"
        //                     )
        //                 }
        //             }
        //         }
        //         stage('Build Collaborative Image'){
        //             steps {
        //                 script {
        //                     def labCollImage = docker.build(
        //                         "${LAB_COLLABORATIVE_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                         "--build-arg BASE_IMAGE=${BASE_LAB_IMAGE_NAME}:${env.RELEASE_VERSION} --no-cache -f docker/single-node-jupyterhub/jupyterlab-collaborative/Dockerfile docker/single-node-jupyterhub/jupyterlab-collaborative"
        //                     )
        //                 }
        //             }
        //         }
        //     }
        // }
        // stage('Push Derived Persistence Image to Harbor') {
        //     steps {
        //         script {
        //             def labPerstenceImage = docker.image("${LAB_PERSISTENCE_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {labPerstenceImage.push()}
        //         }
        //     }
        // }
        // stage('Push Derived Collaborative Image to Harbor') {
        //     steps {
        //         script {
        //             def labCollImage = docker.image("${LAB_COLLABORATIVE_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {labCollImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build Collaborative Proxy Image') {
        //     steps {
        //         script {
        //             def CollProxyImage = docker.build(
        //                 "${COLLABORATIVE_PROXY_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--no-cache -f docker/single-node-jupyterhub/jupyterlab-collaborative-proxy/Dockerfile docker/single-node-jupyterhub/jupyterlab-collaborative-proxy"
        //             )
        //         }
        //     }
        // }
        // stage('Push Collaborative Proxy Image to Harbor') {
        //     steps {
        //         script {
        //             def CollProxyImage = docker.image("${COLLABORATIVE_PROXY_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {CollProxyImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build Notebook Image') {
        //     steps {
        //         script {
        //             def notebookImage = docker.build(
        //                 "${NOTEBOOK_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--no-cache -f docker/single-node-jupyterhub/notebook/Dockerfile docker/single-node-jupyterhub/notebook"
        //             )
        //         }
        //     }
        // }
        // stage('Push Notebook Image to Harbor') {
        //     steps {
        //         script {
        //             def notebookImage = docker.image("${NOTEBOOK_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {notebookImage.push()}
        //         }
        //     }
        // }
    
        // stage('Build Base Lab GPU Image') {
        //     steps {
        //         script {
        //             def baseLabGpuImage = docker.build(
        //                 "${BASE_LAB_GPU_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--no-cache -f docker/single-node-jupyterhub/lab/Dockerfile docker/single-node-jupyterhub/lab"
        //             )
        //         }
        //     }
        // }
        // stage('Push Base Lab GPU Image to Harbor') {
        //     steps {
        //         script {
        //             def baseLabGpuImage = docker.image("${BASE_LAB_GPU_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {baseLabGpuImage.push()}
        //         }
        //     }
        // }
        
        // stage('Build Collaborative GPU Image') {
        //     steps {
        //         script {
        //             def labCollGpuImage = docker.build(
        //                 "${LAB_COLLABORATIVE_GPU_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--no-cache -f docker/single-node-jupyterhub/jupyterlab-collaborative/Dockerfile docker/single-node-jupyterhub/jupyterlab-collaborative"
        //             )
        //         }
        //     }
        // }
        // stage('Push Collaborative GPU Image to Harbor') {
        //     steps {
        //         script {
        //             def labCollGpuImage = docker.image("${LAB_COLLABORATIVE_GPU_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {labCollGpuImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build Base ML_INFN Image') {
        //     steps {
        //         script {
        //             def baseMLImage = docker.build(
        //                 "${ML_INFN_BASE_LAB_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--build-arg BASE_IMAGE=${BASE_LAB_GPU_IMAGE_NAME}:${env.RELEASE_VERSION} --no-cache -f docker/ML-INFN/lab/Dockerfile docker/ML-INFN/lab"
        //             )
        //         }
        //     }
        // }
        // stage('Push Base ML_INFN Image to Harbor') {
        //     steps {
        //         script {
        //             def baseMLImage = docker.image("${ML_INFN_BASE_LAB_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {baseMLImage.push()}
        //         }
        //     }
        // }
        
        // stage('Build ML_INFN Collaborative Image') {
        //     steps {
        //         script {
        //             def MLCollImage = docker.build(
        //                 "${ML_INFN_LAB_COLLABORATIVE_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--build-arg BASE_IMAGE=${LAB_COLLABORATIVE_GPU_IMAGE_NAME}:${env.RELEASE_VERSION} --no-cache -f docker/ML-INFN/jupyterlab-collaborative/Dockerfile docker/ML-INFN/jupyterlab-collaborative"
        //             )
        //         }
        //     }
        // }
        // stage('Push ML_INFN Collaborative Image to Harbor') {
        //     steps {
        //         script {
        //             def MLCollImage = docker.image("${ML_INFN_LAB_COLLABORATIVE_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {MLCollImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build Base Lab CC7 Image') {
        //     steps {
        //         script {
        //             def baseLabCC7Image = docker.build(
        //                 "${BASE_LAB_CC7_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--no-cache -f docker/single-node-jupyterhub/lab/Dockerfile.cc7 docker/single-node-jupyterhub/lab"
        //             )
        //         }
        //     }
        // }
        // stage('Push Base Lab CC7 Image to Harbor') {
        //     steps {
        //         script {
        //             def baseLabCC7Image = docker.image("${BASE_LAB_CC7_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {baseLabCC7Image.push()}
        //         }
        //     }
        // }
        
        // stage('Build Cygno Image') {
        //     steps {
        //         script {
        //             def cygnoImage = docker.build(
        //                 "${CYGNO_LAB_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--build-arg BASE_IMAGE=${BASE_LAB_CC7_IMAGE_NAME}:${env.RELEASE_VERSION} --no-cache -f docker/CYGNO/lab/Dockerfile docker/CYGNO"
        //             )
        //         }
        //     }
        // }
        // stage('Push Cygno Image to Harbor') {
        //     steps {
        //         script {
        //             def cygnoImage = docker.image("${CYGNO_LAB_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {cygnoImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build Cygno WN Image') {
        //     steps {
        //         script {
        //             def cygnoWNImage = docker.build(
        //                 "${CYGNO_LAB_WN_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--no-cache -f docker/CYGNO/wn/Dockerfile docker/CYGNO"
        //             )
        //         }
        //     }
        // }
        // stage('Push Cygno WN Image to Harbor') {
        //     steps {
        //         script {
        //             def cygnoWNImage = docker.image("${CYGNO_LAB_WN_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {cygnoWNImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build Jupyter Matlab Image') {
        //     steps {
        //         script {
        //             def jupMatImage = docker.build(
        //                 "${JUP_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--build-arg BASE_IMAGE=${LAB_PERSISTENCE_IMAGE_NAME}:${env.RELEASE_VERSION} --build-arg MATLAB_RELEASE=r2023b --build-arg MATLAB_PRODUCT_LIST='MATLAB' --build-arg LICENSE_SERVER='' --no-cache -f docker/jupyter-matlab/persistence.Dockerfile docker/jupyter-matlab"
        //             )
        //         }
        //     }
        // }
        // stage('Push Jupyter Matlab Image to Harbor') {
        //     steps {
        //         script {
        //             def jupMatImage = docker.image("${JUP_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {jupMatImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build Collaboration Matlab Image') {
        //     steps {
        //         script {
        //             def collMatImage = docker.build(
        //                 "${COLL_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--build-arg BASE_IMAGE=${LAB_COLLABORATIVE_IMAGE_NAME}:${env.RELEASE_VERSION} --build-arg MATLAB_RELEASE=r2023b --build-arg MATLAB_PRODUCT_LIST='MATLAB' --build-arg LICENSE_SERVER='' --no-cache -f docker/jupyter-matlab/collaborative.Dockerfile docker/jupyter-matlab"
        //             )
        //         }
        //     }
        // }
        // stage('Push Collaboration Matlab Image to Harbor') {
        //     steps {
        //         script {
        //             def collMatImage = docker.image("${COLL_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {collMatImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build Jupyter Parallel Matlab Image') {
        //     steps {
        //         script {
        //             def paralMatImage = docker.build(
        //                 "${PARAL_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--build-arg BASE_IMAGE=${LAB_PERSISTENCE_IMAGE_NAME}:${env.RELEASE_VERSION} --build-arg MATLAB_RELEASE=r2023b --build-arg MATLAB_PRODUCT_LIST='MATLAB MATLAB_Parallel_Server Parallel_Computing_Toolbox' --build-arg LICENSE_SERVER='' --no-cache -f docker/jupyter-matlab-parallel/persistence-parallel.Dockerfile docker/jupyter-matlab-parallel"
        //             )
        //         }
        //     }
        // }
        // stage('Push Jupyter Matlab Parallel Image to Harbor') {
        //     steps {
        //         script {
        //             def paralMatImage = docker.image("${PARAL_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {paralMatImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build JaaS User Image') {
        //     steps {
        //         script {
        //             def jaasUserImage = docker.build(
        //                 "${JAAS_USER_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--no-cache -f docker/naas-matlab/jaas-user-containers/jaas_user_containers.Dockerfile docker/naas-matlab/jaas-user-containers"
        //             )
        //         }
        //     }
        // }
        // stage('Push JaaS User Image to Harbor') {
        //     steps {
        //         script {
        //             def jaasUserImage = docker.image("${JAAS_USER_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {jaasUserImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build NaaS Matlab Image') {
        //     steps {
        //         script {
        //             def naasMatImage = docker.build(
        //                 "${NAAS_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--build-arg BASE_IMAGE=${JAAS_USER_IMAGE_NAME}:${env.RELEASE_VERSION} --build-arg MATLAB_RELEASE=r2023b --build-arg MATLAB_PRODUCT_LIST='MATLAB' --build-arg LICENSE_SERVER='' --no-cache -f docker/naas-matlab/naas.Dockerfile docker/naas-matlab"
        //             )
        //         }
        //     }
        // }
        // stage('Push NaaS Matlab Image to Harbor') {
        //     steps {
        //         script {
        //             def naasMatImage = docker.image("${NAAS_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {naasMatImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build NaaS Parallel Matlab Image') {
        //     steps {
        //         script {
        //             def naasParalMatImage = docker.build(
        //                 "${NAAS_PARALLEL_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--build-arg BASE_IMAGE=${JAAS_USER_IMAGE_NAME}:${env.RELEASE_VERSION} --build-arg MATLAB_RELEASE=r2023b --build-arg MATLAB_PRODUCT_LIST='MATLAB MATLAB_Parallel_Server Parallel_Computing_Toolbox' --build-arg LICENSE_SERVER='' --no-cache -f docker/naas-matlab-parallel/naas-parallel.Dockerfile docker/naas-matlab-parallel"
        //             )
        //         }
        //     }
        // }
        // stage('Push NaaS Parallel Matlab Image to Harbor') {
        //     steps {
        //         script {
        //             def naasParalMatImage = docker.image("${NAAS_PARALLEL_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {naasParalMatImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build Spark Image') {
        //     steps {
        //         script {
        //             def sparkImage = docker.build(
        //                 "${SPARK_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--no-cache -f docker/spark/Dockerfile docker/spark"
        //             )
        //         }
        //     }
        // }
        // stage('Push Spark Image to Harbor') {
        //     steps {
        //         script {
        //             def sparkImage = docker.image("${SPARK_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {sparkImage.push()}
        //         }
        //     }
        // }
 
        // stage('Build JHUB Spark Image') {
        //     steps {
        //         script {
        //             def jhubsparkImage = docker.build(
        //                 "${JHUB_SPARK_IMAGE_NAME}:${env.RELEASE_VERSION}",
        //                 "--no-cache -f docker/jupyter-hub/Dockerfile docker/jupyter-hub"
        //             )
        //         }
        //     }
        // }
        // stage('Push JHUB Spark Image to Harbor') {
        //     steps {
        //         script {
        //             def jhubsparkImage = docker.image("${JHUB_SPARK_IMAGE_NAME}:${env.RELEASE_VERSION}")
        //             docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {jhubsparkImage.push()}
        //         }
        //     }
        // }
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
 