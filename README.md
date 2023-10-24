# 🍱 Foodtruck 🚚

Are you in San Francisco? Are you hungry? Do you love food from trucks? If you answer "yes", Foodtruck is for you.

The San Franciso government posts [this handy set of foodtruck data](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data). Unfortunatley it's a
static list of foodtrucks. It would be nice to do something with this data. Maybe you would like to filter this list down. How about finding the truck that's closest to you? Foodtruck
does exactly that.

Foodtruck is a simple API powered by Phoenix and PostgreSQL. It's a base application designed to be easy to spin up, work on, and expand upon.

## Installation

Running Foodtruck requires 'docker', 'docker-compose', and 'git' running on your local computer along with a Mac OS or Linux operating system. You can find installation instructions for them here:

 - https://docs.docker.com/engine/install/
 - https://docs.docker.com/compose/install/
 - https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

Note: This has only been tested on docker running on an M2 Mac OS. It will most likely work on Linux and most likely not work on Windows.

Once you install the above applications download the repo into your home directory and `cd` into it.

```
cd ~
git clone git@github.com:hyphenPaul/foodtruck.git
cd foodtruck
```

Now pull the appropriate images and run the containers using `docker-compose`. This will start Postgres and the Pheonix API.
```
docker-compose pull
docker-compose up
```

Now seed the database in another bash session.
```
source ~/foodtruck/foodtruck_helpers.sh
foodtruck-exec 'mix seed.db'
```

That's it. You should be up and running! Hit `ctrl+d` to stop the containers. See the uninstall section below to uninstall.

## Uninstall

To uninstall Foodtruck, `cd` to the foodtruck location, spin down the containers and remove the cloned git repository.

```
cd ~/foodtruck
docker-compose down --volumes
cd ~ && rm -rf foodtruck
```

## Usage

There are 3 main features to Foodtruck: A basic feed of foodtruck data, a filtered feed of data, and sorted results based on the user's IP and location.

The easiest way to test this application is to download the [Postman collection here](https://github.com/hyphenPaul/foodtruck/blob/main/Foodtruck.postman_collection.json).

This application runs on http://localhost:4000.

### Full List

To see a full list of foodtruck locations navigate to http://localhost:4000/api/locations.

### Filtered List

To filter locations add any location key and value as a query param. You can find a specific applicant here: http://localhost:4000/api/locations?applicant=Halal Cart, LLC, or how about
all of the suspended results here: http://localhost:4000/api/locations?status=SUSPEND.

### Sort By Location

To find the results closest to you, add `calcuserloc=true` to the request like this: http://localhost:4000/api/locations?calcuserloc=true. The application will utilize the https://api.ipify.org
and http://ip-api.com APIs to determine the user location. If a request is made from a computer running a VPN, the location will most likely be wrong. 

### Development tools

If you would like to test the application you'll find a couple handy shell function here: https://github.com/hyphenPaul/foodtruck/blob/main/foodtruck_helpers.sh. You can test the app, run
credo, or run dialyzer.

To run all of three do the following.
```
source ~/foodtruck/foodtruck_helpers.sh
foodtruck-run-all
```

If you want to repopulate the database from sf.gov you can run `mix` calls from outside the container using `foodtruck-exec`.
```
source ~/foodtruck/foodtruck_helpers.sh
foodtruck-exec 'mix seed.db'
```

## Improvements

This API, like all APIs, is a building block. Its a tool to integrate with. From here you can create a nice web interface, a mobile app, or a command line tool. Go wild!

There are some potential technical improvements:
- Timeouts and error handling on failed location calls
- Field filtering on request
- Scheduled data refresh
