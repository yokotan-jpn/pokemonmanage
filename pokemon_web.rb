#coding:utf-8

#使うために書く必要のあるもの
require 'webrick'
require 'rubygems' 
require 'dbi' 
require 'erb'

#バージョンの違いで発生するエラーを回避するもので今理解しなくていい
class String
    alias_method(:orig_concat, :concat)
    def concat(value)
        if RUBY_VERSION > "1.9"
            orig_concat value.force_encoding('UTF-8')
        else
            orig_concat value 
        end
    end
end

#configというhashを作りkeyとデータを入れている
#Portは使ってなさそうなPort番号
#DocumentRootはHTMLの場所を探す用
config = {
    :Port => 8099,
    :DocumentRoot =>'.',
}
#erbファイルだった場合にERBHandlerを使うようにadd_handlerメソッドで追加している
WEBrick::HTTPServlet::FileHandler.add_handler("erb",WEBrick::HTTPServlet::ERBHandler)

#serverという変数にWEBrick::HTTPServerというメソッドのconfigの中身を代入したものを代入している。
server = WEBrick::HTTPServer.new(config)

#ERBで処理したものをHTML形式で受け取ることを書いている。
server.config[:MimeTypes]["erb"] = "text/html"

#listという行動を行ったときに発動させる効果 ok 
server.mount_proc("/list"){|req,res|
    #デバック用にリクエストを表示
    p req.query
    puts "listに来たよ"
    #operetionの値の終わり方が.edit か.deleteが入力されているかで分岐
    if req.query['operation'].end_with?(".edit")

        #文字列から.editを消してIDのみにする
        target_id = req.query['operation'].delete(".edit")
        p target_id

        #ERBhandlerを経由せず直接ERBを呼び出しているのでlistのページにこいつらが表示される
        template = ERB.new(File.read('edit.erb'))
        res.body<<template.result(binding)

    elsif req.query['operation'].end_with?(".delete")

        #文字列から.deleteを消してIDのみにする
        target_id = req.query['operation'].delete(".delete")
        p target_id

        template = ERB.new(File.read('delete.erb'))
        res.body<<template.result(binding)

    else #未選択の場合

        template = ERB.new(File.read('noselect.erb'))
        res.body<<template.result(binding)

    end
}

#entryというアクションが起きたときにこいつが起動する
server.mount_proc("/entry"){|req,res|

#今後ここに危険なデータ化の確認などのセキュリティの部分を入れる

p req.query

dbh = DBI.connect('DBI:SQLite3:box_pokemon.db') 


        dbh.do("update pokemon set
            k_hp = '#{req.query['k_hp']}',
            k_atk = '#{req.query['k_atk']}',
            k_def = '#{req.query['k_def']}',
            k_catk = '#{req.query['k_catk']}',
            k_cdef = '#{req.query['k_cdef']}',
            k_sp = '#{req.query['k_sp']}',
            d_hp = '#{req.query['d_hp']}',
            d_atk = '#{req.query['d_atk']}',
            d_def = '#{req.query['d_def']}',
            d_catk = '#{req.query['d_catk']}',
            d_cdef = '#{req.query['d_cdef']}',
            d_sp = '#{req.query['d_sp']}',
            pokemon_id = '#{req.query['pokemon_id']}',
            waza_id_1 = '#{req.query['waza_id_1']}',
            waza_id_2 = '#{req.query['waza_id_2']}',
            waza_id_3 = '#{req.query['waza_id_3']}',
            waza_id_4 = '#{req.query['waza_id_4']}',
            item_id = '#{req.query['item_id']}',
            seikaku_id = '#{req.query['seikaku_id']}',
            tokusei = '#{req.query['tokusei']}'
            where id='#{req.query['id']}'
        ;")        

        dbh.disconnect

        id_aft = req.query['id']

        #templateにERBクラスのentried.erbのデータを代入
        template =ERB.new(File.read('entried.erb'))

        #resultメソッドで実行してる
        res.body << template.result(binding)
    
}

server.mount_proc("/serch"){|req,res|

    p req.query #ok

    #何も入力されていない部分を消す
    a=['id','name','k_hp','k_atk','k_def','k_catk','k_cdef','k_sp','d_hp','d_atk','d_def','d_catk','d_cdef','d_sp','pokemon_id','waza_id_1','waza_id_2','waza_id_3','waza_id_4','item_id','seikaku_id']
    
    a.delete_if {|name| req.query[name] == ""}

    p a #ok

    #中身がない部分以外にwhere句をつけて検索条件に追加している
    #空文字列か調べる　.empty?
    if a.empty?
        

        where_data = ""

    else

        a.map! {|name| "#{name}='#{req.query[name]}'"}

        #where id=入力されたものor k_sp=入力されたものという文字列を作っている

        where_data = "where " + a.join('or')

        p where_data #ok
    end

    template=ERB.new(File.read('serched.erb'))
    res.body<<template.result(binding)

}

server.mount_proc("/edit"){|req,res|
    p req.query

    dbh = DBI.connect('DBI:SQLite3:box_pokemon.db') 
    
    
    if req.query['id']==req.query['id_b'] #IDを変更していないなら

            dbh.do("update pokemon set
                    id = '#{req.query['id']}',
                    name = '#{req.query['name']}',
                    k_hp = '#{req.query['k_hp']}',
                    k_atk = '#{req.query['k_atk']}',
                    k_def = '#{req.query['k_def']}',
                    k_catk = '#{req.query['k_catk']}',
                    k_cdef = '#{req.query['k_cdef']}',
                    k_sp = '#{req.query['k_sp']}',
                    d_hp = '#{req.query['d_hp']}',
                    d_atk = '#{req.query['d_atk']}',
                    d_def = '#{req.query['d_def']}',
                    d_catk = '#{req.query['d_catk']}',
                    d_cdef = '#{req.query['d_cdef']}',
                    d_sp = '#{req.query['d_sp']}',
                    pokemon_id = '#{req.query['pokemon_id']}',
                    waza_id_1 = '#{req.query['waza_id_1']}',
                    waza_id_2 = '#{req.query['waza_id_2']}',
                    waza_id_3 = '#{req.query['waza_id_3']}',
                    waza_id_4 = '#{req.query['waza_id_4']}',
                    item_id = '#{req.query['item_id']}',
                    seikaku_id = '#{req.query['seikaku_id']}',
                    tokusei = '#{req.query['tokusei']}'
                    where id='#{req.query['id_b']}'
                ;")    
            
            

            dbh.disconnect
            #templateにERBクラスのentried.erbのデータを代入
            id_aft = req.query['id']
            template =ERB.new(File.read('edited.erb'))
            #resultメソッドで実行してる
            res.body << template.result(binding)

        

    else #idを変更しているなら

    #IDがかぶっていたら登録できないように分岐する

    #rowsに入力されたIDと同じIDのデータを持ってくる
    rows =dbh.select_one("select * from pokemon where id='#{req.query["id"]}';")

        if rows then

            dbh.disconnect

            #templateにERBクラスのnoentry.erbのデータを代入
            template =ERB.new(File.read('noentry.erb'))

            #resultメソッドで実行してる
            res.body << template.result(binding)

        else #かぶってない場合

            if req.query['pic'] == "" 

                dbh.do("update pokemon set
                        id = '#{req.query['id']}',
                        name = '#{req.query['name']}',
                        k_hp = '#{req.query['k_hp']}',
                        k_atk = '#{req.query['k_atk']}',
                        k_def = '#{req.query['k_def']}',
                        k_catk = '#{req.query['k_catk']}',
                        k_cdef = '#{req.query['k_cdef']}',
                        k_sp = '#{req.query['k_sp']}',
                        d_hp = '#{req.query['d_hp']}',
                        d_atk = '#{req.query['d_atk']}',
                        d_def = '#{req.query['d_def']}',
                        d_catk = '#{req.query['d_catk']}',
                        d_cdef = '#{req.query['d_cdef']}',
                        d_sp = '#{req.query['d_sp']}'
                        where id='#{req.query['id_b']}'
                    ;")    
                
                

                dbh.disconnect
                #templateにERBクラスのentried.erbのデータを代入
                id_aft = req.query['id']
                template =ERB.new(File.read('edited.erb'))
                #resultメソッドで実行してる
                res.body << template.result(binding)

            #画像変更する場合
            else
                dbh.do("update pokemon set
                    id = '#{req.query['id']}',
                    name = '#{req.query['name']}',
                    k_hp = '#{req.query['k_hp']}',
                    k_atk = '#{req.query['k_atk']}',
                    k_def = '#{req.query['k_def']}',
                    k_catk = '#{req.query['k_catk']}',
                    k_cdef = '#{req.query['k_cdef']}',
                    k_sp = '#{req.query['k_sp']}',
                    d_hp = '#{req.query['d_hp']}',
                    d_atk = '#{req.query['d_atk']}',
                    d_def = '#{req.query['d_def']}',
                    d_catk = '#{req.query['d_catk']}',
                    d_cdef = '#{req.query['d_cdef']}',
                    d_sp = '#{req.query['d_sp']}',
                    image_url = '#{req.query['pic']}'
                    where id='#{req.query['id']}'
                ;")    
                dbh.disconnect
                
                #templateにERBクラスのentried.erbのデータを代入
                id_aft = req.query['id']
                template =ERB.new(File.read('edited.erb'))
                #resultメソッドで実行してる
                res.body << template.result(binding)
            end
        end
    end
}

server.mount_proc("/delete"){|req,res|

    dbh = DBI.connect('DBI:SQLite3:box_pokemon.db')
    dbh.do("delete from pokemon where id='#{req.query['id']}'")
    dbh.disconnect

    template =ERB.new(File.read('deleted.erb'))
                #resultメソッドで実行してる
    res.body << template.result(binding)
}

server.mount_proc("/next"){|req,res|

    p req.query

    dbh = DBI.connect('DBI:SQLite3:box_pokemon.db') 

    #IDがかぶっていたら登録できないように分岐する

    #rowsに入力されたIDと同じIDのデータを持ってくる
    rows =dbh.select_one("select * from pokemon where id='#{req.query["id"]}';")

    #データがあるならかぶっているので切断しエラーページへ誘導
    if rows then

        dbh.disconnect

        #templateにERBクラスのnoentry.erbのデータを代入
        template =ERB.new(File.read('noentry.erb'))

        #resultメソッドで実行してる
        res.body << template.result(binding)

    else

        dbh.do("insert into pokemon values(
                '#{req.query['id']}',
                '#{req.query['name']}',
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                ''
                );")     

        dbh.disconnect

        #名前は文字化けするのでこの段階で入れほかは仮のものをいれておき後で修正する
        p_id = req.query['pokemon_id']
        b_id = req.query['id']
        template =ERB.new(File.read('entry_2.erb'))
        res.body << template.result(binding)
    end
    
}
#Ctrl-Cの入力があった場合にserverを止めるような処理の登録
trap(:INT) do
    server.shutdown
end

#serverクラスの変数の起動のコマンド

server.start
