FROM ruby:3.3-alpine AS builder

RUN apk add --no-cache \
    build-base \
    git \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    npm \
    imagemagick \
    imagemagick-dev

WORKDIR /site

COPY Portfolio/Gemfile Portfolio/Gemfile.lock ./

RUN bundle install --jobs 4 --retry 3

COPY Portfolio/ .

RUN bundle exec jekyll build --destination ./_site


FROM nginx:1.27-alpine AS serve

COPY --from=builder /site/_site /usr/share/nginx/html

# Optional: custom Nginx config
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]