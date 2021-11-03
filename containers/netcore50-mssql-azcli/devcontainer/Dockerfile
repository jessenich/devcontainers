# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.191.0/containers/dotnetcore/.devcontainer/base.Dockerfile

# [Choice] .NET Core version: 5.0, 3.1, 2.1
ARG VARIANT="5.0"
FROM --platform=linux/amd64 mcr.microsoft.com/vscode/devcontainers/dotnetcore:0-${VARIANT}

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="none"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# [Option] Install Azure CLI
ARG INSTALL_AZURE_CLI="true"
COPY library-scripts/azcli-debian.sh /tmp/library-scripts/
RUN if [ "$INSTALL_AZURE_CLI" = "true" ]; then bash /tmp/library-scripts/azcli-debian.sh; fi

# Install SQL Tools: SQLPackage and sqlcmd
COPY mssql/installSQLtools.sh /tmp/library-scripts/installSQLtools.sh
RUN bash /tmp/library-scripts/installSQLtools.sh

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

RUN apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts
