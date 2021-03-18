SELECT "paper_citations_db_minifiedpaper"."paper_id",
    "paper_citations_db_minifiedpaper"."cites",
    "paper_citations_db_minifiedpaper"."cited_by"
FROM "paper_citations_db_minifiedpaper"
WHERE "paper_citations_db_minifiedpaper"."paper_id" IN (
        SELECT DISTINCT unnest(
                array_cat(second_hop."cites", second_hop."cited_by")
            ) AS "references"
        FROM "paper_citations_db_minifiedpaper" second_hop
        WHERE second_hop."paper_id" IN (
                SELECT DISTINCT unnest(
                        array_cat(first_hop."cites", first_hop."cited_by")
                    ) AS "references"
                FROM "paper_citations_db_minifiedpaper" first_hop
                    INNER JOIN "paper_citations_db_paper" ON (
                        first_hop."paper_id" = "paper_citations_db_paper"."id"
                    )
                WHERE "paper_citations_db_paper"."str_id" = 'some-string-paper-id'
            )
    )