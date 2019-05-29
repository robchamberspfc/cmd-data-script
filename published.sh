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
       --drop --file mongo-data/dataset.json

mongoimport --db datasets --collection editions \
       --drop --file mongo-data/edition.json

mongoimport --db datasets --collection dimension.options \
       --drop --file mongo-data/dimension.json

mongoimport --db datasets --collection instances \
       --drop --file mongo-data/instance.json

##clear Neo
cypher-shell < neo-data/clear-neo.cypher

##load data
cypher-shell < neo-data/rob.cypher