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
    0.9.0

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

