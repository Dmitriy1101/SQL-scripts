-- жанр
CREATE TABLE IF NOT EXISTS genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL
);

-- исполнитель
CREATE TABLE IF NOT EXISTS singer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL
);

-- альбом
CREATE TABLE IF NOT EXISTS album (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    year_of_issue date NOT NULL
);

-- трек
CREATE TABLE IF NOT EXISTS track (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    duration TIME,
    id_album INTEGER NOT NULL REFERENCES album(id)
);

-- сборник
CREATE TABLE IF NOT EXISTS collection (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    year_of_issue date
);

-- жанр_исполнитель
CREATE TABLE IF NOT EXISTS genre_singer (
    genre_id INTEGER REFERENCES genre(id),
    singer_id INTEGER REFERENCES singer(id),
    CONSTRAINT g_s PRIMARY KEY(genre_id, singer_id)
);

-- исполнитель_альбом
CREATE TABLE IF NOT EXISTS singer_album (
    id_singer INTEGER REFERENCES singer(id),
    id_album INTEGER REFERENCES album(id),
    CONSTRAINT s_a PRIMARY KEY(id_singer, id_album)
);

-- сборник_трек
CREATE TABLE IF NOT EXISTS collection_track (
    id_collection INTEGER REFERENCES collection(id),
    id_track INTEGER REFERENCES track(id),
    CONSTRAINT c_p PRIMARY KEY(id_collection, id_track)
);


