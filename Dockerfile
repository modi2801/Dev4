FROM centos:7
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x kubectl
RUN mv kubectl /usr/bin
RUN yum install java -y
RUN yum install openssh-server -y
RUN mkdir /root/jenkins
RUN ssh-keygen -A
CMD ["/usr/sbin/sshd", "-D"] && /bin/bash
RUN mkdir /root/.kube
COPY myinfo /root/.kube/config
COPY ca.crt /root/
COPY client.crt /root/
COPY client.key /root/
COPY deployment.yml /root/
RUN yum install sudo -y
CMD /bin/bash
