def buildAndPushImage(String imageName, String dockerBuildOptions) {
    docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {
    def dockerImage = docker.build(imageName, dockerBuildOptions)
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
        node { label 'jenkins-node-label-1' }
    }
    
    environment {
        REGISTRY_FQDN = 'harbor.cloud.infn.it'
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
        TAG_NAME = "1.2.1"
        RELEASE_VERSION = getReleaseVersion(TAG_NAME)
        SANITIZED_BRANCH_NAME = env.BRANCH_NAME.replace('/', '_')
    }
    
    stages {
        stage('Build and Push JHUB Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${JHUB_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--no-cache -f docker/single-node-jupyterhub/jupyterhub/Dockerfile docker/single-node-jupyterhub/jupyterhub"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }
        
        stage('Build and Push Base Lab Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${BASE_LAB_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--no-cache -f docker/single-node-jupyterhub/lab/Dockerfile docker/single-node-jupyterhub/lab"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }
 
        stage('Build and Push Lab Persistence Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${LAB_PERSISTENCE_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--build-arg BASE_IMAGE=${REGISTRY_FQDN}/${BASE_LAB_IMAGE_NAME}:${env.RELEASE_VERSION} --no-cache -f docker/single-node-jupyterhub/lab/base-persistence/Dockerfile docker/single-node-jupyterhub/lab/base-persistence"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }

        stage('Build and Push Lab Collaborative Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${LAB_COLLABORATIVE_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--build-arg BASE_IMAGE=${REGISTRY_FQDN}/${BASE_LAB_IMAGE_NAME}:${env.RELEASE_VERSION} --no-cache -f docker/single-node-jupyterhub/jupyterlab-collaborative/Dockerfile docker/single-node-jupyterhub/jupyterlab-collaborative"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }

        // #### stage('Build and Push Collaborative Proxy Image') {
        //     environment {
        //         IMAGE_NAME = "${REGISTRY_FQDN}/${COLLABORATIVE_PROXY_IMAGE_NAME}:${env.RELEASE_VERSION}"
        //         DOCKER_BUILD_OPTIONS = "--no-cache -f docker/single-node-jupyterhub/jupyterlab-collaborative-proxy/Dockerfile docker/single-node-jupyterhub/jupyterlab-collaborative-proxy"
        //     }
        //     steps {
        //         script {
        //             sh "/usr/bin/docker system prune -fa"
        //             buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
        //         }
        //     }
        // }

        // #### stage('Build and Push Notebook Image') {
        //     environment {
        //         IMAGE_NAME = "${REGISTRY_FQDN}/${NOTEBOOK_IMAGE_NAME}:${env.RELEASE_VERSION}"
        //         DOCKER_BUILD_OPTIONS = "--no-cache -f docker/single-node-jupyterhub/notebook/Dockerfile docker/single-node-jupyterhub/notebook"
        //     }
        //     steps {
        //         script {
        //             sh "/usr/bin/docker system prune -fa"
        //             buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
        //         }
        //     }
        // }

        stage('Build and Push Lab GPU Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${BASE_LAB_GPU_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--no-cache -f docker/single-node-jupyterhub/lab/Dockerfile.gpu docker/single-node-jupyterhub/lab"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }

        // #### stage('Build and Push Collaborative GPU Image') {
        //     environment {
        //         IMAGE_NAME = "${REGISTRY_FQDN}/${LAB_COLLABORATIVE_GPU_IMAGE_NAME}:${env.RELEASE_VERSION}"
        //         DOCKER_BUILD_OPTIONS = "--no-cache -f docker/single-node-jupyterhub/jupyterlab-collaborative/Dockerfile.gpu docker/single-node-jupyterhub/jupyterlab-collaborative"
        //     }
        //     steps {
        //         script {
        //             sh "/usr/bin/docker system prune -fa"
        //             buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
        //         }
        //     }
        // }

        // #### stage('Build and Push ML_INFN Image') {
        //     environment {
        //         IMAGE_NAME = "${REGISTRY_FQDN}/${ML_INFN_BASE_LAB_IMAGE_NAME}:${env.RELEASE_VERSION}"
        //         DOCKER_BUILD_OPTIONS = "--build-arg BASE_IMAGE=${BASE_LAB_GPU_IMAGE_NAME}:${env.RELEASE_VERSION} --no-cache -f docker/ML-INFN/lab/Dockerfile docker/ML-INFN/lab"
        //     }
        //     steps {
        //         script {
        //             sh "/usr/bin/docker system prune -fa"
        //             buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
        //         }
        //     }
        // }

        // #### stage('Build and Push ML INFN Collaborative Image') {
        //     environment {
        //         IMAGE_NAME = "${REGISTRY_FQDN}/${ML_INFN_LAB_COLLABORATIVE_IMAGE_NAME}:${env.RELEASE_VERSION}"
        //         DOCKER_BUILD_OPTIONS = "--build-arg BASE_IMAGE=${LAB_COLLABORATIVE_GPU_IMAGE_NAME}:${env.RELEASE_VERSION} --no-cache -f docker/ML-INFN/jupyterlab-collaborative/Dockerfile docker/ML-INFN/jupyterlab-collaborative"
        //     }
        //     steps {
        //         script {
        //             sh "/usr/bin/docker system prune -fa"
        //             buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
        //         }
        //     }
        // }

        // #### stage('Build and Push Base Lab CC7 Image') {
        //     environment {
        //         IMAGE_NAME = "${REGISTRY_FQDN}/${BASE_LAB_CC7_IMAGE_NAME}:${env.RELEASE_VERSION}"
        //         DOCKER_BUILD_OPTIONS = "--no-cache -f docker/single-node-jupyterhub/lab/Dockerfile.cc7 docker/single-node-jupyterhub/lab"
        //     }
        //     steps {
        //         script {
        //             sh "/usr/bin/docker system prune -fa"
        //             buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
        //         }
        //     }
        // }

        // #### stage('Build and Push Cygno Image') {
        //     environment {
        //         IMAGE_NAME = "${REGISTRY_FQDN}/${CYGNO_LAB_IMAGE_NAME}:${env.RELEASE_VERSION}"
        //         DOCKER_BUILD_OPTIONS = "--build-arg BASE_IMAGE=${BASE_LAB_CC7_IMAGE_NAME}:${env.RELEASE_VERSION} --no-cache -f docker/CYGNO/lab/Dockerfile docker/CYGNO"
        //     }
        //     steps {
        //         script {
        //             sh "/usr/bin/docker system prune -fa"
        //             buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
        //         }
        //     }
        // }
        
        // #### stage('Build and Push Cygno WN Image') {
        //     environment {
        //         IMAGE_NAME = "${REGISTRY_FQDN}/${CYGNO_LAB_WN_IMAGE_NAME}:${env.RELEASE_VERSION}"
        //         DOCKER_BUILD_OPTIONS = "--no-cache -f docker/CYGNO/wn/Dockerfile docker/CYGNO"
        //     }
        //     steps {
        //         script {
        //             sh "/usr/bin/docker system prune -fa"
        //             buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
        //         }
        //     }
        // }
 
        stage('Build and Push Lab Matlab Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${JUP_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--build-arg BASE_IMAGE=${REGISTRY_FQDN}/${LAB_PERSISTENCE_IMAGE_NAME}:${env.RELEASE_VERSION} --build-arg MATLAB_RELEASE=r2023b --build-arg MATLAB_PRODUCT_LIST='MATLAB' --build-arg LICENSE_SERVER='' --no-cache -f docker/jupyter-matlab/persistence.Dockerfile docker/jupyter-matlab"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }

        // #### stage('Build and Push Lab Collaboration Matlab Image') {
        //     environment {
        //         IMAGE_NAME = "${REGISTRY_FQDN}/${COLL_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}"
        //         DOCKER_BUILD_OPTIONS = "--build-arg BASE_IMAGE=${REGISTRY_FQDN}/${LAB_COLLABORATIVE_IMAGE_NAME}:${env.RELEASE_VERSION} --build-arg MATLAB_RELEASE=r2023b --build-arg MATLAB_PRODUCT_LIST='MATLAB' --build-arg LICENSE_SERVER='' --no-cache -f docker/jupyter-matlab/collaborative.Dockerfile docker/jupyter-matlab"
        //     }
        //     steps {
        //         script {
        //             sh "/usr/bin/docker system prune -fa"
        //             buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
        //         }
        //     }
        // }

        stage('Build and Push Parallel Matlab Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${PARAL_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--build-arg BASE_IMAGE=${REGISTRY_FQDN}/${LAB_PERSISTENCE_IMAGE_NAME}:${env.RELEASE_VERSION} --build-arg MATLAB_RELEASE=r2023b --build-arg MATLAB_PRODUCT_LIST='MATLAB MATLAB_Parallel_Server Parallel_Computing_Toolbox' --build-arg LICENSE_SERVER='' --no-cache -f docker/jupyter-matlab-parallel/persistence-parallel.Dockerfile docker/jupyter-matlab-parallel"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }

        stage('Build and Push JaaS User Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${JAAS_USER_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--no-cache -f docker/naas-matlab/jaas-user-containers/jaas_user_containers.Dockerfile docker/naas-matlab/jaas-user-containers"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }

        stage('Build and Push NaaS Matlab Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${NAAS_MATLAB_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--build-arg BASE_IMAGE=${REGISTRY_FQDN}/${JAAS_USER_IMAGE_NAME}:${env.RELEASE_VERSION} --build-arg MATLAB_RELEASE=r2023b --build-arg MATLAB_PRODUCT_LIST='MATLAB' --build-arg LICENSE_SERVER='' --no-cache -f docker/naas-matlab/naas.Dockerfile docker/naas-matlab"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }
        stage('Build and Push NaaS Parallel Matlab Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${NAAS_PARALLEL_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--build-arg BASE_IMAGE=${REGISTRY_FQDN}/${JAAS_USER_IMAGE_NAME}:${env.RELEASE_VERSION} --build-arg MATLAB_RELEASE=r2023b --build-arg MATLAB_PRODUCT_LIST='MATLAB MATLAB_Parallel_Server Parallel_Computing_Toolbox' --build-arg LICENSE_SERVER='' --no-cache -f docker/naas-matlab-parallel/naas-parallel.Dockerfile docker/naas-matlab-parallel"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        } 

        stage('Build and Push JHUB Spark Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${JHUB_SPARK_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--no-cache -f docker/spark/jhub/Dockerfile docker/spark/jhub"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }

        stage('Build and Push JLAB Spark Image') {
            environment {
                IMAGE_NAME = "${REGISTRY_FQDN}/${SPARK_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--no-cache -f docker/spark/jlab/Dockerfile docker/spark/jlab"
            }
            steps {
                script {
                    sh "/usr/bin/docker system prune -fa"
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                } 
            }
        }
    }
    
    post {
        success { echo 'Docker image build and push successful!' }
        failure { echo 'Docker image build and push failed!' }
    }
}
 
