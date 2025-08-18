# syntax=docker/dockerfile:1

############################
# Ruby Layer via RVM
############################
FROM layer-base AS layer-ruby

ARG RUBY_VERSION=3.2.0

# Install RVM and Ruby
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    source ~/.rvm/scripts/rvm && \
    rvm autolibs disable && \
    rvm install ${RUBY_VERSION} --disable-binary && \
    rvm use ${RUBY_VERSION} --default && \
    gem install bundler && \
    echo 'source ~/.rvm/scripts/rvm' >> ~/.bashrc && \
    echo "rvm use ${RUBY_VERSION} --default" >> ~/.bashrc && \
    echo 'export PATH=$HOME/.rvm/bin:$PATH' >> ~/.bashrc

# Verify installation
RUN bash -lc "ruby --version && gem --version && bundler --version"
