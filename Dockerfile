FROM rakudo-star
RUN apt-get update
RUN apt-get -yy install build-essential libssl-dev
RUN zef install --/test cro
RUN zef install --/test Data::Dump
RUN mkdir /bot
WORKDIR /bot
