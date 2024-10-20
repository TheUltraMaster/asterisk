FROM ubuntu:latest

# Actualizar el sistema y instalar algunas utilidades básicas
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl wget vim git

# Configurar el servidor para ejecutar de forma interactiva
CMD ["bash"]
