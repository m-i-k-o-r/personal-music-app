create table users
(
    id            uuid primary key      default gen_random_uuid(),
    username      varchar(50)  not null unique,
    email         varchar(255) not null unique,
    password_hash varchar(255) not null,
    created_at    timestamp    not null default now()
);

create table artists
(
    id               uuid primary key default gen_random_uuid(),
    name             varchar(50) not null unique,
    artist_image_key varchar(255)
);

create table tracks
(
    id              uuid primary key default gen_random_uuid(),
    title           varchar(255) not null,
    duration        smallint     not null check ( duration > 0 ),
    audio_key       varchar(255) not null unique,
    track_image_key varchar(255)
);

create table track_artists
(
    primary key (track_id, artist_id),

    track_id  uuid not null,
    artist_id uuid not null,

    foreign key (track_id) references tracks (id) on delete cascade,
    foreign key (artist_id) references artists (id) on delete cascade
);

create table playlists
(
    id                 uuid primary key default gen_random_uuid(),
    title              varchar(100) not null,
    owner_id           uuid         not null,
    playlist_image_key varchar(255),
    foreign key (owner_id) references users (id) on delete cascade
);

create table playlist_tracks
(
    primary key (playlist_id, track_id),

    playlist_id uuid  not null,
    track_id    uuid  not null,

    foreign key (playlist_id) references playlists (id) on delete cascade,
    foreign key (track_id) references tracks (id) on delete cascade,

    position    float not null
);
