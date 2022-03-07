# Image name: dodasts/cygno-lab
FROM htcondor/execute:8.9.9-el7

COPY assets/base_packages /tmp/
COPY assets/packages /tmp/

# clean metadata: https://srvfail.com/yum-doesnt-work-in-clean-centos-7-install-exiting-on-user-cancel/
RUN yum -y clean metadata \
    && yum --exclude=\*oidc-agent\* -y update \
    && yum --exclude=\*oidc-agent\* -y upgrade \
    && xargs yum -y install < /tmp/base_packages \
    && xargs yum -y install < /tmp/packages \
    && yum -y clean all \
    && rm -f /tmp/*packages

WORKDIR /usr/local/share/dodasts/script/

# garfield env variables
ENV GARFIELD_HOME=/usr/local/share/garfield
ENV HEED_DATABASE=${GARFIELD_HOME}/Heed/heed++/database

# Install Geant4
COPY scripts/install_geant4.sh /usr/local/share/dodasts/script/
RUN chmod +x /usr/local/share/dodasts/script/install_geant4.sh
RUN ./install_geant4.sh
# Install garfield
COPY scripts/install_garfield.sh /usr/local/share/dodasts/script/
RUN chmod +x /usr/local/share/dodasts/script/install_garfield.sh
RUN ./install_garfield.sh
# Install CADMesh
COPY scripts/install_CADMesh.sh /usr/local/share/dodasts/script/
RUN chmod +x /usr/local/share/dodasts/script/install_CADMesh.sh
RUN ./install_CADMesh.sh
# Install RooUnfold
COPY scripts/install_RooUnfold.sh /usr/local/share/dodasts/script/
RUN chmod +x /usr/local/share/dodasts/script/install_RooUnfold.sh
RUN ./install_RooUnfold.sh

WORKDIR /

# Install boto
RUN pip3 install --no-cache-dir -U git+https://github.com/DODAS-TS/boto3sts

# Install ca
RUN wget "https://crt.sh/?d=2475254782" --progress=bar -O /etc/pki/ca-trust/source/anchors/ca.crt \
    && update-ca-trust \
    && update-ca-trust force-enable

# Install 
RUN pip3 install --no-cache-dir -U \
    mahotas==1.4.11 \
    scikit-image==0.17.2 \
    scikit-learn==0.24.2 \
    scipy==1.5.4 \
    jedi-language-server==0.21.0 \
    metakernel==0.28.2 \
    && pip3 install --no-cache-dir -U git+https://github.com/gmazzitelli/cygno_repo.git

# cmake3 alias
RUN ln -s /usr/bin/cmake3 /usr/bin/cmake