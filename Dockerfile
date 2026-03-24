# Stage 1: Build
FROM ruby:3.3-alpine AS builder

# Install system dependencies needed by native Jekyll gems (nokogiri, etc.)
RUN apk add --no-cache \
    build-base \
    git \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    npm \
    imagemagick \
    imagemagick-dev \
    python3 \
    py3-pip

RUN pip3 install --break-system-packages nbconvert

WORKDIR /site

# Copy dependency manifest first (layer cache optimization)
COPY Portfolio/Gemfile ./

RUN bundle install --jobs 4 --retry 3

# Copy the rest of the Jekyll site
COPY Portfolio/ .

# Build the static site into ./_site
RUN bundle exec jekyll build --destination ./_site

# Stage 2: Serve
FROM nginx:1.27-alpine AS serve

COPY --from=builder /site/_site /usr/share/nginx/html

# Optional: custom Nginx config (see Section 3.3)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
