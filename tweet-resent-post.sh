RUBY=$( which ruby)

if [[ -n ${RUBY}]]
then
    $RUBY $(basename $0 .sh).rb
fi
