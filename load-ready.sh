#!/bin/bash

##clean out existing Mongo content
 mongo mongodb://localhost:27017 <<EOF
 use datasets
 db.dropDatabase();
 use imports
 db.dropDatabase();
 use filters
 db.dropDatabase();
EOF

##import dataset
mongoimport --db datasets --collection datasets \
       --drop --file mongo-data/dataset-pre-publish.json

##clear Neo
cypher-shell < neo-data/clear-neo.cypher

##load data
cypher-shell < neo-data/cpih1dim1aggid.cypher
cypher-shell < neo-data/uk-only.cypher
cypher-shell < neo-data/mmm-yy.cypher
cypher-shell < neo-data/cpih1dim1aggid-heirarchy.cypher