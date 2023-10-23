function foodtruck-bash() {
  docker exec -ti foodtruck bash
}

function foodtruck-exec() {
  docker exec -ti foodtruck bash -lc $1
}

function foodtruck-iex() {
  foodtruck-exec 'iex -S mix'
}

function foodtruck-credo() {
  foodtruck-exec 'mix credo'
}

function foodtruck-dialyzer() {
  foodtruck-exec 'mix dialyzer'
}

function foodtruck-test() {
  foodtruck-exec 'mix test'
}

function foodtruck-run-all() {
  foodtruck-test
  foodtruck-credo
  foodtruck-dialyzer
}

function foodtruck-log() {
  docker logs -f foodtruck
}
