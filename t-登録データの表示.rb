#coding:utf-8

require 'rubygems' #gemでインストールしたものを使うときに書く
require 'dbi' #dbiを使う

#dbh.do("この中にsqlite3でコマンドとして打つ内容を入れることによってそれが実行される。")

#データの読み込み

   # def 
        dbh = DBI.connect('DBI:SQLite3:box_pokemon.db') 

            sth = dbh.execute("select * from pokemon_s")

            sth.each do |row| #rowにデータが一件ずつ入る

                row.each_with_name do |val,name| #さらにその一件のデータの項目名をnameにデータの内容をvalに代入している。
                    puts "#{name}:#{val.to_s}"
                end

                puts "------------------------------------------------------"
            end

            sth.finish #executeメソッドによって返されたsthの中身を初期化？解放している

            sth = dbh.execute("select * from item")

            sth.each do |row| #rowにデータが一件ずつ入る

                row.each_with_name do |val,name| #さらにその一件のデータの項目名をnameにデータの内容をvalに代入している。
                    puts "#{name}:#{val.to_s}"
                end

                puts "------------------------------------------------------"
            end

            sth.finish #executeメソッドによって返されたsthの中身を初期化？解放している

            sth = dbh.execute("select * from waza")

            sth.each do |row| #rowにデータが一件ずつ入る

                row.each_with_name do |val,name| #さらにその一件のデータの項目名をnameにデータの内容をvalに代入している。
                    puts "#{name}:#{val.to_s}"
                end

                puts "------------------------------------------------------"
            end

            sth.finish #executeメソッドによって返されたsthの中身を初期化？解放している

            sth = dbh.execute("select * from pokemon")

            sth.each do |row| #rowにデータが一件ずつ入る

                row.each_with_name do |val,name| #さらにその一件のデータの項目名をnameにデータの内容をvalに代入している。
                    puts "#{name}:#{val.to_s}"
                end

                puts "------------------------------------------------------"
            end

            sth.finish #executeメソッドによって返されたsthの中身を初期化？解放している

            sth = dbh.execute("select * from seikaku")

            sth.each do |row| #rowにデータが一件ずつ入る

                row.each_with_name do |val,name| #さらにその一件のデータの項目名をnameにデータの内容をvalに代入している。
                    puts "#{name}:#{val.to_s}"
                end

                puts "------------------------------------------------------"
            end

            sth.finish #executeメソッドによって返されたsthの中身を初期化？解放している

            sth = dbh.execute("select * from type")

            sth.each do |row| #rowにデータが一件ずつ入る

                row.each_with_name do |val,name| #さらにその一件のデータの項目名をnameにデータの内容をvalに代入している。
                    puts "#{name}:#{val.to_s}"
                end

                puts "------------------------------------------------------"
            end

            sth.finish #executeメソッドによって返されたsthの中身を初期化？解放している

        dbh.disconnect
    #end