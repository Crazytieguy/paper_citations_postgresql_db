BEGIN;
--
-- Create model Paper
--
CREATE TABLE "connected_papers_db_paper" (
    "id" serial NOT NULL PRIMARY KEY,
    "str_id" text NOT NULL,
    "cites" text [] NOT NULL,
    "cited_by" text [] NOT NULL,
    "info" jsonb NOT NULL
);
--
-- Create model MinifiedPaper
--
CREATE TABLE "connected_papers_db_minifiedpaper" (
    "paper_id" integer NOT NULL PRIMARY KEY,
    "cites" integer [] NOT NULL,
    "cited_by" integer [] NOT NULL
);
--
-- Create index str_id_to_id_index on field(s) str_id, id of model paper
--
CREATE INDEX "str_id_to_id_index" ON "connected_papers_db_paper" ("str_id", "id");
ALTER TABLE "connected_papers_db_minifiedpaper"
ADD CONSTRAINT "connected_papers_db__paper_id_bed81dd5_fk_connected" FOREIGN KEY ("paper_id") REFERENCES "connected_papers_db_paper" ("id") DEFERRABLE INITIALLY DEFERRED;
COMMIT;