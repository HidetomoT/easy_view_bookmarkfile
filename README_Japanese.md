README_JAPANESE
---------------

#### 名前
    easy_view_bookmarkfile.scm

#### 書式
    easy_view_bookmarkfile.scm  input-bookmark-html-file

#### 説明（１）
    いくつかのウェブブラウザは ブックマークのHTML形式のファイルを
    エクスポートできます。
    そのファイルは ウェブブラウザで表示させることができます。
    このプログラムは そのブックマークのファイルを見やすい表示に
    なるように変換します。
    このプログラムは Linuxのシェルスクリプトや Windowsのバッチファイルの
    ようなスクリプトの形式のプログラムです。
    実行するためには、Gaucheというソフトをインストールする必要があります。
    もし ＯＳがWindowsなら、別途 MinGWというソフトもインストールする必要が
    あります。
    もし ＯＳがLinux、UNIXなら、easy_view_bookmarkfile.scmのファイルに
    実行権限の許可（パーミッション）を付加する必要があります。（chmod等の
    コマンドを使います。）
    このeasy_view_bookmarkfile.scmのコマンドとしての引き数は１個で、
    元のブックマークのHTMLファイルを指定します。
    変換後のブックマークのHTMLファイルの名前は 自動的に作成されます。
    もし ＯＳがWindowsなら、コマンドプロンプト（DOS窓）のソフトを起動して、
    次のように コマンド入力してください。
            gosh  easy_view_bookmarkfile.scm  元のブックマークHTMLファイル
    もし ＯＳがWindows10なら、コマンドプロンプトの起動の方法を
    インターネット検索で調べてみてください。

#### バージョン
    0.9.2

#### 必要な物
    Gauche (プログラミング言語 Scheme処理系の１つ)
        http://practical-scheme.net/gauche/index-j.html

      Gaucheは MinGWというソフトと併用すると、Windowsでも動作します。
          http://www.mingw.org/

#### ライセンス 
    Copyright (c) 2018 Hidetomo Tanaka
    Released under the MIT license
    http://opensource.org/licenses/mit-license.php


#### プログラムの簡単なダウンロードの方法
    次のリンクを右クリックして、「名前を付けてリンク先を保存」を選択します。
                                                          （Firefoxでの例）

&nbsp;&nbsp;&nbsp;&nbsp;[easy_view_bookmarkfile.scm](https://raw.githubusercontent.com/HidetomoT/easy_view_bookmarkfile/master/easy_view_bookmarkfile.scm "easy_view_bookmarkfile.scm")<br>
&nbsp;&nbsp;&nbsp;&nbsp;[README_Japanese.md](https://raw.githubusercontent.com/HidetomoT/easy_view_bookmarkfile/master/README_Japanese.md "README_Japanese.md")<br>
&nbsp;&nbsp;&nbsp;&nbsp;[README.md](https://raw.githubusercontent.com/HidetomoT/easy_view_bookmarkfile/master/README.md "README.md")<br>
&nbsp;&nbsp;&nbsp;&nbsp;[bookmarks_example_before__html.md](https://raw.githubusercontent.com/HidetomoT/easy_view_bookmarkfile/master/Example_before_after/bookmarks_example_before__html.md "bookmarks_example_before__html.md")<br>
&nbsp;&nbsp;&nbsp;&nbsp;[bookmarks_example_after__html.md](https://raw.githubusercontent.com/HidetomoT/easy_view_bookmarkfile/master/Example_before_after/bookmarks_example_after__html.md "bookmarks_example_after__html.md")<br>
<br><br><br>


------------------------------------------------------------------

## 説明（２）
    下記のリンクに もう少し詳しい解説を載せています。

#### easy_view_bookmarkfile.scmの もう少し詳しいインストールの解説
<pre>
  「 [vine-users:082939] ブックマークのHTMLファイルを見やすくするソフト 
                                     ／ プログラミング言語 Gauche、Schemeの話」
</pre>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[http://ml.vinelinux.org/vine-users/msg32864.html](http://ml.vinelinux.org/vine-users/msg32864.html "インストールの解説")<br>
<br><br>


#### プログラミング言語 Gauche、Schemeの解説の話
<pre>
  「 [vine-users:082940] Re: ブックマークのHTMLファイルを見やすくするソフト 
                                       ／ プログラミング言語 Gauche、Schemeの話」
</pre>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[http://ml.vinelinux.org/vine-users/msg32865.html](http://ml.vinelinux.org/vine-users/msg32865.html "Gauche、Schemeの解説")<br>
<br><br><br><br>



------------------------------------------------------------------

## 修正履歴

* 2018/01/20  バージョン 0.9.0

* 2018/02/05  バージョン 0.9.1

* 2018/02/08  バージョン 0.9.2
<pre>
    次のようなエラーが出るバグを発見した。ソースの修正を行なった。
    [foo@xxxx]$ easy_view_bookmarkfile.scm bookmarks.html
    Output file name:  bookmarks_esvwbk.html
    *** ERROR: stack overrun during matching regexp #/(?i: +icon_uri *= *".*")/
    Stack Trace:
    _______________________________________
      0  (regexp-replace #/(?i: +icon_uri *= *".*")/ line_str "")
            at "/home/foo/easy_view_bookmarkfile.scm":182
      1  (modify_DT_A_HREF_str line_str)
            at "/home/foo/easy_view_bookmarkfile.scm":346
      2  (procedure_one_line line_str)
            at "/home/foo/easy_view_bookmarkfile.scm":367
      3  (read_bookmark_file)
            at "/home/foo/easy_view_bookmarkfile.scm":404
</pre>



