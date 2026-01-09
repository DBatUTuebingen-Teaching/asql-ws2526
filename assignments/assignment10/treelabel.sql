DROP TABLE IF EXISTS trees;

CREATE TABLE trees (
  tree    int    PRIMARY KEY,
  parents int[]  NOT NULL,
  labels  text[] NOT NULL
);

INSERT INTO trees VALUES
  (1, [NULL, 1, 2, 2, 1, 5],
      ['a', 'b', 'd', 'e', 'c', 'f']),
  (2, [4, 1, 1, 6, 5, NULL, 6],
      ['d', 'f', 'a', 'b', 'e', 'g', 'c']),
  (3, [NULL, 1, NULL, 1, 3],
      ['a', 'b', 'd', 'c', 'e']),
  (4, [NULL, 1, 2, 2, 1, 5],
      ['a', 'f', 'd', 'e', 'c', 'f']);

-- The given recursive CTE assumes unique labels for the tree.
-- It does not produce correct results for non-unique labels.
WITH RECURSIVE paths(tree, pos, node) AS (
  SELECT t.tree,
         0 AS pos,
         list_position(t.labels, 'f') AS node
  FROM   trees AS t
  WHERE  'f' = ANY(t.labels)
    UNION
  SELECT t.tree,
         p.pos + 1 AS pos,
         t.parents[p.node] AS node
  FROM   paths AS p, trees AS t
  WHERE  p.tree = t.tree
  AND    p.node IS NOT NULL
)
SELECT p.tree,
       p.pos,
       p.node
FROM   paths AS p
WHERE  p.node IS NOT NULL
ORDER  BY p.tree, p.pos;
