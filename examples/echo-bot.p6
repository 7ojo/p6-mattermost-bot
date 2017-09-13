#!/usr/bin/env perl6

use Cro::HTTP::Router;
use Cro::HTTP::Server;
use Data::Dump;
my $application = route {
    get -> 'icon', *@path {
        static 'assets/icon', @path;
    }
    post -> 'echo' {
        content 'text/plain', "here in echo service";
    }
    post -> 'data' {
        request-body -> %json-object {
            say Dump(%json-object);
            #say %json-object{'image_id'};
            #say %json-object{'hwp_id'};
            #say %json-object{'keyname'};
            for %json-object.pairs -> (:$key, :$value) {
                say "key: $key value: $value";
            }
            #content 'application/json', %json-object;
            my %return-data =
                icon_url => 'http://localhost:64321/icon/android.png',
                username => 'echo-bot',
                text => %json-object{'text'}.subst(/ .*? ':' \s* /, '')
                ;
            say %return-data;
            content 'application/json', %return-data;
        }
    }
}
my Cro::Service $echo = Cro::HTTP::Server.new: :host<127.0.0.1>, :port<4444>, :$application;
$echo.start;
react whenever signal(SIGINT) { $echo.stop; exit; }
