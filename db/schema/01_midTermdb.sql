DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS collections CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS posts CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS likes CASCADE;
DROP TABLE IF EXISTS ratings CASCADE;
DROP TABLE IF EXISTS followed_collections CASCADE;


CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  biography TEXT,
  icon VARCHAR(255)
);

CREATE TABLE collections (
  id SERIAL PRIMARY KEY NOT NULL,
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT Now()
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  collection_id INTEGER REFERENCES collections(id),
  category_id INTEGER REFERENCES categories(id),
  posted_at TIMESTAMP DEFAULT Now(),
  title VARCHAR(255) NOT NULL,
  url VARCHAR(255),
  description TEXT
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  posted_at TIMESTAMP DEFAULT Now()
);

CREATE TABLE likes (
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  post_id iNTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE
);

CREATE TABLE ratings (
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  value SMALLINT NOT NULL
);

CREATE TABLE followed_collections (
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  collection_id INTEGER NOT NULL REFERENCES collections(id) ON DELETE CASCADE
);

GRANT ALL PRIVILEGES ON TABLE users TO labber;
GRANT ALL PRIVILEGES ON TABLE posts TO labber;
GRANT ALL PRIVILEGES ON TABLE comments TO labber;
GRANT ALL PRIVILEGES ON TABLE collections TO labber;
GRANT ALL PRIVILEGES ON TABLE likes TO labber;
GRANT ALL PRIVILEGES ON TABLE ratings TO labber;

GRANT USAGE, SELECT ON SEQUENCE posts_id_seq TO labber;
