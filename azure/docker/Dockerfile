FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN apt-get install -y wget
RUN wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
RUN apt-get update
RUN apt-get install -y azure-functions-core-tools
RUN apt-get install -y python3-venv
WORKDIR /home
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT true
RUN cd /home
RUN python3 -m venv .venv
#RUN source .venv/bin/activate
CMD ["source", ".venv/bin/activate", "&&", "/bin/bash"]