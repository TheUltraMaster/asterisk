# Utiliza la imagen base de Ubuntu
FROM ubuntu:latest

# Actualiza los paquetes y luego instala bash y otros paquetes necesarios
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    wget \
    vim \
    nano \
    net-tools \
    iputils-ping \
    openssh-server \
    python3 \
    python3-pip \
    && apt-get clean

# Configura el servidor SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Expone el puerto 22 para SSH
EXPOSE 22

# Inicia el servicio SSH
CMD ["/usr/sbin/sshd", "-D"]
