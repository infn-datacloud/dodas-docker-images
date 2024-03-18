# Image name: harbor.cloud.infn.it/snj/snj-base-lab-persistence:1.2rgw
ARG BASE_IMAGE="harbor.cloud.infn.it/snj/snj-base-lab:1.2rgw"
#ARG BASE_IMAGE="harbor.cloud.infn.it/snj/snj-base-lab-gpu:1.2rgw"
# hadolint ignore=DL3006
FROM ${BASE_IMAGE}

ARG JUPYTER_ROOT=/jupyter-workspace

COPY post_script.sh /usr/local/share/dodasts/script/
RUN chmod +x /usr/local/share/dodasts/script/post_script.sh

# Link folders
RUN mkdir -p ${JUPYTER_ROOT} \
    && ln -s /s3 ${JUPYTER_ROOT}/cloud-storage \
    && ln -s /shared ${JUPYTER_ROOT}/shared \
    && ln -s /private ${JUPYTER_ROOT}/private

WORKDIR ${JUPYTER_ROOT}
