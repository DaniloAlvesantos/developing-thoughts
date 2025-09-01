DROP TABLE IF EXISTS tb_article_views;
DROP TABLE IF EXISTS tb_article_tag;
DROP TABLE IF EXISTS tb_article;
DROP TABLE IF EXISTS tb_category;
DROP TABLE IF EXISTS tb_tag;

-- ===========================
-- CATEGORY
-- ===========================
CREATE TABLE tb_category (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    slug TEXT NOT NULL UNIQUE
);

-- ===========================
-- TAG
-- ===========================
CREATE TABLE tb_tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    slug TEXT NOT NULL UNIQUE
);

-- ===========================
-- ARTICLE
-- ===========================
CREATE TABLE tb_article (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    excerpt TEXT NOT NULL,
    content TEXT NOT NULL,
    cover_image TEXT NOT NULL,
    keywords TEXT NOT NULL,
    id_category INTEGER,
    isFeatured INTEGER DEFAULT 0,         -- 0 = False, 1 = True
    is_ai_generated INTEGER DEFAULT 0,    -- same
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_category)
        REFERENCES tb_category(id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- ===========================
-- ARTICLE <-> TAGS (Many-to-Many)
-- ===========================
CREATE TABLE tb_article_tag (
    id_article INTEGER NOT NULL,
    id_tag INTEGER NOT NULL,
    PRIMARY KEY (id_article, id_tag),
    FOREIGN KEY (id_article) REFERENCES tb_article(id) ON DELETE CASCADE,
    FOREIGN KEY (id_tag) REFERENCES tb_tag(id) ON DELETE CASCADE
);

-- ===========================
-- ARTICLE VIEWS
-- ===========================
CREATE TABLE tb_article_views (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_article INTEGER NOT NULL,
    path TEXT NOT NULL,
    ip_address TEXT NOT NULL, -- supports IPv6
    user_agent TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_article)
        REFERENCES tb_article(id) ON DELETE CASCADE
);

-- ===========================
-- INDEXES
-- ===========================
CREATE INDEX idx_article_text ON tb_article (title, slug);
-- No FULLTEXT in SQLite, use FTS5 if needed
CREATE INDEX idx_category_slug ON tb_category (slug);
CREATE INDEX idx_tag_slug ON tb_tag (slug);
CREATE INDEX idx_article_views ON tb_article_views (id_article, ip_address, created_at);
