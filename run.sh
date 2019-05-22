#!/bin/bash

##clean out existing Mongo content
 mongo mongodb://localhost:27017 <<EOF
 use datasets
 db.dropDatabase();
 use imports
 db.dropDatabase();
 use filters
 db.dropDatabase();
 use test
 db.dropDatabase();
EOF

##import dataset
mongoimport --db datasets --collection datasets \
       --drop --file mongo-data/dataset.json

##clear Neo
brew services stop neo4j
rm -rf /usr/local/Cellar/neo4j/3.3.0/libexec/data
brew services start neo4j

##wait for Neo to start
sleep 20s

##load data
cypher-shell < neo-data/cpih1dim1aggid.cypher
cypher-shell < neo-data/uk-only.cypher
cypher-shell < neo-data/mmm-yy.cypher
cypher-shell < neo-data/cpih1dim1aggid-heirarchy.cypher