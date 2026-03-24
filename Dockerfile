# Stage 1: Build
FROM ruby :3.3 - alpine AS builder

# Install system dependencies needed by native Jekyll gems
RUN apk add --no-cache \
    build-base \
    git \
    librml2-dev \
    libxslt-dev \
    nodejs \
    npm \
    imagemagick \
    imagemagick-dev 

WORKDIR /site

# Copy dependency manifests first (layer cache optimization)
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle isntall jobs 4 retry 3

# Copy the rest of the source
COPY . .

# Build the static site into ./ _site
RUN bundle exec jekyll build -- destination ./ _site

# Stage 2: Serve
FROM nginx :1.27 - alpine AS serve

# Copy compiled site from build stage
COPY -- from = builder / site / _site / usr / share / nginx / html

# Optional : custom Nginx config ( see Section 3.3)
# COPY nginx . conf / etc / nginx / conf . d / default . conf

EXPOSE 80
CMD [ " nginx " , " -g " , " daemon off ; " ]