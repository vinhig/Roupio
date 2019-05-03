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
    primary key (hash),
    foreign key (author) references users(pseudo)
);