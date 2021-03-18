BEGIN;
--
-- Create model Paper
--
CREATE TABLE "paper_citations_db_paper" (
    "id" serial NOT NULL PRIMARY KEY,
    "str_id" text NOT NULL,
    "cites" text [] NOT NULL,
    "cited_by" text [] NOT NULL,
    "info" jsonb NOT NULL
);
--
-- Create model MinifiedPaper
--
CREATE TABLE "paper_citations_db_minifiedpaper" (
    "paper_id" integer NOT NULL PRIMARY KEY,
    "cites" integer [] NOT NULL,
    "cited_by" integer [] NOT NULL
);
--
-- Create index str_id_to_id_index on field(s) str_id, id of model paper
--
CREATE INDEX "str_id_to_id_index" ON "paper_citations_db_paper" ("str_id", "id");
ALTER TABLE "paper_citations_db_minifiedpaper"
ADD CONSTRAINT "paper_citations_db_m_paper_id_4e7727e6_fk_paper_cit" FOREIGN KEY ("paper_id") REFERENCES "paper_citations_db_paper" ("id") DEFERRABLE INITIALLY DEFERRED;
COMMIT;