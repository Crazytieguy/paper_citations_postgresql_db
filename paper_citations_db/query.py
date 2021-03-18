from .models import MinifiedPaper
from django.db.models import Subquery, Func


def query(paper_str_id):
    return MinifiedPaper.objects.filter(
        pk__in=get_subquery(pk__in=get_subquery(paper__str_id=paper_str_id))
    )


def get_subquery(**filter_kwargs):
    return Subquery(
        MinifiedPaper.objects.filter(**filter_kwargs)
        .annotate(
            references=Func(
                Func("cites", "cited_by", function="array_cat"), function="unnest"
            )
        )
        .values_list("references", flat=True)
        .distinct()
    )
