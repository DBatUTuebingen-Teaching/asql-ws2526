INSTALL json;
LOAD json;

DROP TABLE IF EXISTS cards;

CREATE TABLE cards (
  "name"    text PRIMARY KEY,
  mana_cost text,
  cmc       numeric,
  "type"    text,
  "text"    text,
  power     text,
  toughness text
);

-- extract relevant json data to populate the cards table
INSERT INTO cards
  SELECT j."name", j.manaCost, j.cmc, j."type", j."text", j.power, j.toughness
  FROM read_json("magic-cards.json") AS j;
