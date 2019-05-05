-- script to structure a basique db
-- assume that the db is already connected

create table users (
    pseudo text not null unique,
    mdp text not null,
    poste text not null,
    primary key (pseudo)
);

insert into users (pseudo, mdp, poste) values ('root', '42', 'admin');

insert into users (pseudo, mdp, poste) values ('bjr', 'bjr', 'adherant');

create table files (
    hash char(32) not null unique,
    author text not null,
    name text not null,
    category text not null,
    visibility text not null,
    primary key (hash),
    foreign key (author) references users(pseudo)
);

create table res (
    hash char(32) not null unique,
    provider text not null,
    caption text not null,
    content text not null,
    date timestamp default current_timestamp,
    primary key (hash),
    foreign key(provider) references users(pseudo)
);

insert into res (hash, provider, caption, content) values ('42', 'root', 'Check out the source code !', 'https://github.com/vinhig/Roupio');
insert into res (hash, provider, caption, content) values ('13', 'bjr', "Just a test, a test a bit longer than the previous. Never mind. I'm speaking to impress you.", 'https://github.com/vinhig/Roupio');