# Utiliza la imagen base de Ubuntu
FROM ubuntu:latest

# Actualiza los paquetes e instala bash y otros paquetes necesarios
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
RUN mkdir /root/.ssh
# Copia tu clave pública local al contenedor (asegúrate de tener tu clave pública en el mismo directorio que tu Dockerfile)
COPY tu_clave_publica.pub /root/.ssh/authorized_keys

# Configura permisos de la clave
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# Configura SSH para permitir el acceso root mediante claves
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

# Expone el puerto 22 para SSH
EXPOSE 22

# Inicia el servicio SSH
CMD ["/usr/sbin/sshd", "-D"]
