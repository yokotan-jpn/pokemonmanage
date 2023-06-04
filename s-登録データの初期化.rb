#coding:utf-8

require 'rubygems' #gemでインストールしたものを使うときに書く
require 'dbi' #dbiを使う

dbh = DBI.connect('DBI:SQLite3:box_pokemon.db') 
#(データソース種別：ドライバ種別：データベースファイル名）
#もともとstudentがある場合にはデータベースファイルを開くこととなる

   dbh.do("drop table if exists waza")
    #すでにデータベースファイルの中にpokemonテーブルがあれば削除
   puts "table 'waza' has deleted"

   dbh.do("create table waza(
    id               int          not null,
    type_id          int          not null,
    name             varchar(100) not null,            
    primary        key(id));")

    puts "table 'waza' has created"

    dbh.do("drop table if exists pokemon_s")
    #すでにデータベースファイルの中にpokemonテーブルがあれば削除
   puts "table 'pokemon_s' has deleted"

   dbh.do("create table pokemon_s(
    id               int          not null,
    type_id_1        int          not null,
    type_id_2        int          not null,
    name             varchar(100) not null,
    tokusei_1        varchar(100) not null,
    tokusei_2        varchar(100) not null,
    tokusei_3        varchar(100) not null,
    s_hp             int          not null,
    s_atk            int          not null,
    s_def            int          not null,
    s_catk           int          not null,
    s_cdef           int          not null,
    s_sp             int          not null,
    image_url        varchar(200) not null,
    primary          key(id));")

    puts "table 'pokemon_s' has created"

    dbh.do("drop table if exists item")
    #すでにデータベースファイルの中にpokemonテーブルがあれば削除
   puts "table 'item' has deleted"

   dbh.do("create table item(
    id               int          not null,
    name             varchar(100) not null,
    image_url        varchar(200) not null,
    primary        key(id));")

    puts "table 'item' has created"

    dbh.do("drop table if exists pokemon")
    #すでにデータベースファイルの中にpokemonテーブルがあれば削除
   puts "table 'pokemon' has deleted"

   dbh.do("create table pokemon(
    id               int          not null,
    name             varchar(100) not null,
    k_hp             int          not null,
    k_atk            int          not null,
    k_def            int          not null,
    k_catk           int          not null,
    k_cdef           int          not null,
    k_sp             int          not null,
    d_hp             int          not null,
    d_atk            int          not null,
    d_def            int          not null,
    d_catk           int          not null,
    d_cdef           int          not null,
    d_sp             int          not null,
    pokemon_id       int          not null,
    waza_id_1        int          not null,
    waza_id_2        int          not null,
    waza_id_3        int          not null,
    waza_id_4        int          not null,
    item_id          int          not null,
    seikaku_id       int          not null, 
    tokusei          varchar(100) not null,
    primary        key(id));")

    puts "table 'pokemon' has created"

    dbh.do("drop table if exists seikaku")
    #すでにデータベースファイルの中にpokemonテーブルがあれば削除
   puts "table 'seikaku' has deleted"

   dbh.do("create table seikaku(
    id               int          not null,
    name             varchar(100) not null,
    atk              int          not null,
    def              int          not null,
    catk             int          not null,  
    cdef             int          not null,
    sp               int          not null,            
    primary        key(id));")

    puts "table 'seikaku' has created"

    dbh.do("drop table if exists type")
    #すでにデータベースファイルの中にpokemonテーブルがあれば削除
   puts "table 'type' has deleted"

   dbh.do("create table type(
    id               int          not null,
    image_url        varchar(200) not null,
    primary        key(id));")

    puts "table 'type' has created"

dbh.disconnect

#性格
#0さみしがり	○	×	 	 	 
#1いじっぱり	○	 	×	 	 
#2やんちゃ	○	 	 	×	 
#3ゆうかん	○	 	 	 	×
#4ずぶとい	×	○	 	 	 
#5わんぱく	 	○	×	 	 
#6のうてんき	 	○	 	×	 
#7のんき	 	○	 	 	×
#8ひかえめ	×	 	○	 	 
#9おっとり	 	×	○	 	 
#10うっかりや	 	 	○	×	 
#11れいせい	 	 	○	 	×
#12おだやか	×	 	 	○	 
#13おとなしい	 	×	 	○	 
#14しんちょう	 	 	×	○	 
#15なまいき	 	 	 	○	×
#16おくびょう	×	 	 	 	○
#17せっかち	 	×	 	 	○
#18ようき	 	 	×	 	○
#19むじゃき	 	 	 	×	○	 	 	 	 	 
#20まじめ	