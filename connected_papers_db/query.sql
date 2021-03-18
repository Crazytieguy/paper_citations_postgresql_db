SELECT "connected_papers_db_minifiedpaper"."paper_id",
    "connected_papers_db_minifiedpaper"."cites",
    "connected_papers_db_minifiedpaper"."cited_by"
FROM "connected_papers_db_minifiedpaper"
WHERE "connected_papers_db_minifiedpaper"."paper_id" IN (
        SELECT DISTINCT unnest(
                array_cat(second_hop."cites", second_hop."cited_by")
            ) AS "references"
        FROM "connected_papers_db_minifiedpaper" second_hop
        WHERE second_hop."paper_id" IN (
                SELECT DISTINCT unnest(
                        array_cat(first_hop."cites", first_hop."cited_by")
                    ) AS "references"
                FROM "connected_papers_db_minifiedpaper" first_hop
                    INNER JOIN "connected_papers_db_paper" ON (
                        first_hop."paper_id" = "connected_papers_db_paper"."id"
                    )
                WHERE "connected_papers_db_paper"."str_id" = 'some-string-paper-id'
            )
    )