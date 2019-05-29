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

##reindex search for this dimension (future-thing)
##curl -X PUT localhost:23100/search/instances/d0345008-23b0-4355-b1ee-1ca5b52d2207/dimensions/aggregate -H 59c8d5a95ea86dba744f1f81310243231f9e263a9ef4f67c5164d353482a2c2a 