# Hackathon: Simple Hackathon Organization

### Log in through your organization's Slack
        Enable the slack login via omniauth by entering the following eviroment variables: 
        * API_KEY
        * API_SECRET
        * TEAM_ID
### Assign "Participant" badge in your Discourse community to Hackathon participants
         Set your following discourse's API (should be a general/master API Token):
        * DISCOURSE_API_KEY
        * DISCOURSE_API_USERNAME
        * DISCOURSE_URL
### Assign Admin users
        Set the following enviromental value:
        * ADMIN_EMAILS
        (format: 'admin1@example.com,admin2@example.com')


#### How to Start the app
        Run:
        bundle exec sidekiq
        bundle exec rails server