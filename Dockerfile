FROM rocker/r2u:22.04

WORKDIR /workspace

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        gcc \
        libc6-dev \
        wget \
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
    
RUN R -e "install.packages(c('htmltools', 'tidyverse', 'zeallot', 'rlang', 'glue', 'this.path', 'DBI', 'pool', 'RSQLite', 'remotes'))"

RUN R -e "install.packages('b64', repos = c('https://extendr.r-universe.dev', 'https://cloud.r-project.org')); install.packages('uwu', repos = c('https://josiahparry.r-universe.dev', 'https://cloud.r-project.org'))"

COPY . .

EXPOSE 7860
CMD R -e "print(Sys.getenv('GITHUB_PAT')); remotes::install_github(c('devOpifex/ambiorix', 'jrosell/ambhtmx',  'devOpifex/scilis', 'devOpifex/signaculum')); options(ambiorix.host='0.0.0.0', 'ambiorix.port'=7860);source('app.R')"