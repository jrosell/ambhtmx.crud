ARG GITHUB_PAT
FROM rocker/r2u:22.04

WORKDIR /workspace

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
                git \
                sudo \
                ca-certificates \
                gcc \
                libc6-dev \
                wget \
                && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers \
                && sed -i -e '/^suppressMessages(bspm::enable())$/i options(bspm.sudo=TRUE)' /etc/R/Rprofile.site \
                ; \
        \
        url="https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init"; \
        wget "$url"; \
        chmod +x rustup-init; \
        ./rustup-init -y --no-modify-path --default-toolchain beta --default-host x86_64-unknown-linux-gnu; \
        rm rustup-init; \
        chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
        rustup --version; \
        cargo --version; \
        rustc --version; \
        \
        apt-get remove -y --auto-remove \
            wget \
            ; \
        rm -rf /var/lib/apt/lists/*;

RUN install2.r --error -s --deps TRUE \
        htmltools tidyverse zeallot rlang glue this.path DBI pool RSQLite remotes promises assertthat log
RUN Rscript -e "install.packages('b64', repos = c('https://extendr.r-universe.dev', getOption('repos')))" 
RUN Rscript -e "install.packages('uwu', repos = c('https://josiahparry.r-universe.dev', getOption('repos')))" 
RUN installGithub.r \
        devOpifex/ambiorix devOpifex/scilis devOpifex/signaculum jrosell/ambhtmx

# RUN adduser newuser
# COPY --chown=newuser . .

COPY . .
RUN chmod -R 755 /workspace

EXPOSE 7860
CMD R -e "print(nchar(Sys.getenv('GITHUB_PAT'))); source('app.R'); "