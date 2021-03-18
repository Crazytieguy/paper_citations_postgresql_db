from django.db import models
from django.contrib.postgres.fields import ArrayField
from django.db.models import Index


class Paper(models.Model):
    str_id = models.TextField()
    cites = ArrayField(models.TextField())
    cited_by = ArrayField(models.TextField())
    info = models.JSONField()

    class Meta:
        indexes = [Index(fields=["str_id", "id"], name="str_id_to_id_index")]


class MinifiedPaper(models.Model):
    paper = models.OneToOneField(Paper, on_delete=models.CASCADE, primary_key=True)
    cites = ArrayField(models.IntegerField())
    cited_by = ArrayField(models.IntegerField())
