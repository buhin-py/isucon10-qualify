DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL
);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL
);

CREATE INDEX idx_price_id ON isuumo.chair(price,id)
;

CREATE INDEX idx_rent ON isuumo.estate(rent)
;
CREATE INDEX idx_popularity
ON isuumo.estate(popularity DESC, id)
;

--ALTER TABLE isuumo.estate ADD point POINT AS (POINT(latitude, longitude))
--STORED NOT NULL
--;
--ALTER TABLE isuumo.estate ADD SPATIAL INDEX estate_point_idx(point)
--;
ALTER TABLE isuumo.estate ADD COLUMN point POINT;
-- データ登録
UPDATE isuumo.estate SET point=POINT(latitude, longitude);
ALTER TABLE issumo.estate MODIFY COLUMN point POINT SRID 2 NOT NULL;
ALTER TABLE issumo.estate ADD SPATIAL INDEX estate_point_idx(point);

