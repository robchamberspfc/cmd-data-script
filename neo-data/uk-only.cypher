//This is required at the start of all geographic list imports to ensure uniqueness
CREATE CONSTRAINT ON (n:`_code_geography`) ASSERT n.value IS UNIQUE;

CREATE (node:`_code_list`:`_code_list_uk-only` { label:'geography', edition:'one-off' });
CREATE CONSTRAINT ON (n:`_code_list_uk-only`) ASSERT n.value IS UNIQUE;

MERGE (node:`_code`:`_code_geography` { value:'K02000001' });
MATCH (parent:`_code_list`:`_code_list_uk-only`),(node:`_code`:`_code_geography` { value:'K02000001' }) MERGE (node)-[:usedBy { label:"United Kingdom"}]->(parent);
