web: bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
sync: bin/rails sync:current_ranks
release: bin/rails db:migrate
