# Mattermost Hackable bots

## Enabling communication from Mattermost

-> Integrations -> Outgoing Webhook

## Running through Docker

Do the build first with all the tools and libraries available:

    $ docker build -t mattermost-bot .

Then run it: (Note: This will expose bot communication on port 4444)

    $ docker run -it -p 4444:4444 -v `pwd`:/bot mattermost-bot perl6 examples/echo-bot.p6 --token=xxx --port=4444
