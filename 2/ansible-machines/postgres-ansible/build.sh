#!/bin/bash
# rm -f keys.tar
# cd keys
# tar -cvf ../keys.tar *
# cd ..
EXISTS="$(docker images|grep 'buildit/postgres-ansible')"
if ! [[ -z "$EXISTS" ]]; then
  docker rmi -f builditftorelli/postgresql-ansible:9.6.2
  docker rmi -f buildit/postgresql-ansible:9.6.2
fi
if ! [[ -z "$(docker images|grep -v 'IMAGE'|grep -i '<none>')" ]]; then
  docker images|grep -v 'IMAGE'|grep -i '<none>'|awk 'BEGIN {FS=OFS=" "}{print $3}'|xargs docker rmi -f
fi
#rm -f playbook.tgz
#tar -cvzf playbook.tgz playbook
docker build --compress --no-cache --rm --force-rm --tag buildit/postgresql-ansible:9.6.2 ./
# Usage:	docker load [OPTIONS]
# Load an image from a tar archive or STDIN
# Options:
#       --help           Print usage
#   -i, --input string   Read from tar archive file, instead of STDIN
#   -q, --quiet          Suppress the load output
#
# Usage:	docker save [OPTIONS] IMAGE [IMAGE...]
# Save one or more images to a tar archive (streamed to STDOUT by default)
# Options:
#       --help            Print usage
#   -o, --output string   Write to a file, instead of STDOUT
docker tag buildit/postgresql-ansible:9.6.2 builditftorelli/postgresql-ansible:9.6.2
