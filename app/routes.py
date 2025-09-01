from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)

from .db import get_db

main = Blueprint("main", __name__, url_prefix="/")

@main.route("/", methods=["GET"])
def index():
    db = get_db()
    # articles = db.execute(
    #     "SELECT a.id, a.title, a.excerpt, a.created_at, a.slug, a.cover_image, a.isFeatured, c.name"
    #     " FROM tb_article a JOIN tb_category c ON a.id_category = c.id"
    # ).fetchall()

    # featured_articles = db.execute(
    #     "SELECT a.id, a.title, a.excerpt, a.created_at, a.slug, a.cover_image, a.isFeatured, c.name"
    #     " FROM tb_article a JOIN tb_category c ON a.id_category = c.id"
    #     " WHERE a.isFeatured = 1"
    # ).fetchall()

    return render_template("index.html")