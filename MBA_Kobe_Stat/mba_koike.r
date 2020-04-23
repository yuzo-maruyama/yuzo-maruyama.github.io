# #より右はコメントであり，実行されない
# カーソルのある位置でctrl+enterでその行が実行される
# または範囲指定してctrl+enterで複数行の実行
# 右上の「Run」をクリックでも「実行」

## 第 1 章 R の基本的な操作
## 1.1. 基本的な使い方

## 1.1.1. 式の入力
## ほぼ直感に沿った文法で計算を実行可能
(1 + 3) * (2 + 4) / 6 # 四則演算
1.8 + 5 - 0.04 + 8.2 / 3 # 計算順に注意
pi # 例えばπは定義済み
print(pi,digits=22) # 桁数を変更して表示
sqrt(2) # 平方根
8^(1/3) # 羃乗
exp(10) # 指数関数
exp(1) # 自然対数の底
log(10) # 対数関数 (log, log10, log2)
sin(pi/2) # 三角関数 (sin, cos, tan)

## 1.1.2. 変数への代入
## 文字列を変数名として数値を保持
x <- sin(pi/3) # x に代入
print(x) # x の値を確認
y <- cos(pi/3) # y に代入
y # print(y) と同じ, yの値を確認
z <- x - y # 計算結果を代入
(z) # print(z) と同じ, zの値を確認 カッコ()をつけるのがポイント
(w <- x * y) # print(w <- x * y) と同じ 代入結果を表示
w # 代入結果を確認 ( 上と同じ値が表示される )
## 変数名は自由に決めて用いることができる (例 :x, y, abc など)
## sin , log , piなど R で使用済みの名前の使用は非推奨
## オブジェクト：変数や関数および関数の実行結果等の総称

## 1.2. データ構造
## Rのデータ構造(代表的なもの)
## ベクトル (vector)
## 行列 (matrix)
## リスト (list)
## データフレーム (data frame)

## 1.2.1. ベクトル
## ベクトルはスカラー値の集合 (1次元配列)
## スカラー値として扱われるもの
## 実数，複素数，文字列，論理値など

## 実数
(x <- 4) # 変数 x に実数 4 を代入
x^10
x^100
x^1000 # 実数として保持できる最大値を越える

## 文字列
(y <- "foo") # 文字列は ' または " で括る
(z <- "bar") # "foo" や "bar" は意味のない文字列として良く用いられる
paste(y, z) # 文字列の足し算 省略時は区切り文字 (separator) は " "( 空白 )
paste(y, z, sep="") # 区切り文字 (separator) を ""( 無 ) に指定
y+z # 足し算はエラー

## 論理値
TRUE # 論理値 ( 真 )
T # 論理値 ( 真 ) の省略形
FALSE # 論理値 ( 偽 )
F # 論理値 ( 偽 ) の省略形
as.numeric(TRUE) # as.numeric は数値に変換する関数
as.numeric(F)

## 一般にベクトルは関数 c( ) を用いて生成
## ベクトルの要素を取り出すには [ ] を付けて要素の番号を指定
## 規則的な系列を生成するための関数はしばしば有用
## seq( ) 等間隔の系列を作る
## rep( ) 繰り返しの系列を作る
## length( ) ベクトルの長さを求める

## 関数 c の使い方
(x <- c(0, 1, 2, 3, 4)) # 数値を並べてベクトルを作成
(y <- c("foo", "bar")) # 文字列のベクトル
x[2] # ベクトルの 2 番目の要素
y[2]
x[c(1, 3, 5)] # 複数の要素は要素番号のベクトルで指定

## 関数 seq の使い方
(x <- seq(0, 3, by=0.5)) # 0 から 3 まで 0.5 刻みの系列
(y <- seq(0, 3, length=5)) # 0 から 3 まで長さ 5 の系列
(z <- 1:10) # seq(1,10,by=1) と同様
(z <- 10:1) # 10 から 1 まで 1 刻みの逆順
z[3:8] # z の 3 番目から 8 番目の要素

## 関数 rep の使い方
(x <- rep(1, 7)) # 1 を 7 回繰り返す
(y <- rep(c(1, 2, 3), times=3)) # (1,2,3) を 3 回繰り返す
(z <- rep(c(1, 2, 3), each=3)) # (1,2,3) をそれぞれ 3 回繰り返す

## その他の操作
(x <- seq(0, 2, by=0.3))
length(x) # ベクトルの長さ
y <- 2:5
(z <- c(x, y)) # ベクトルの連結
rev(z) # rev はベクトルを反転する関数
LETTERS # アルファベット 1 文字を要素とするベクトルは定義されている
letters[1:10] # 小文字の場合

## 1.2.2. 行列
## matrix( )による行列の生成
## 行列の(i,j)成分の取り出し -> [i,j]をつける

## 関数 matrix の使い方
x <- c(2, 3, 5, 7, 11, 13)
matrix(x, 2, 3) # (2,3) 行列
(X <- matrix(x, ncol = 3)) # 列数指定 ( 行数はそれに合わせて決まる )
(Y <- matrix(x, ncol = 3, byrow = TRUE)) # 横に並べる

## その他の操作
nrow(X) # 行数
ncol(X) # 列数
X[1, 2] # (1,2) 成分
X[2, ] # 2 行目
X[, 3] # 3 列目
as.vector(X) # ベクトル x に戻る
dim(x) <- c(2, 3) # ベクトルに次元属性を与えて行列化
x # 行列 X になる

## 1.2.3. リスト
## リスト：異なる構造のデータをまとめて 1 つのオブジェクトとして扱える
## リストの各要素は種類がバラバラであってもよい (例えばベクトルと行列が混在).
## 一般に関数 list( ) を用いてリストを作
## 要素を取り出すには [[ ]] をつけて要素の番号を指定
## もしくは各成分に名前をつけ，それを用いて各成分を参照

## 関数 list の使い方
# 各成分のデータ型はバラバラでよい
(L1 <- list(c(1, 2, 5, 4), matrix(1:4, 2), c("Hello", "World")))
L1[[1]] # L1 の第 1 成分の取り出し
L1[[2]][2, 1] # 2 番目の要素の (2,1) 成分
L1[[c(3, 2)]] # 3 番目の要素の 2 番目
L1[[3]][[2]] # 上と同じ
L1[c(1, 3)] # 複数成分を同時に抽出
L1[1] # 第 1 成分をリストとして取り出す
(L2 <- list(Info = " 統計データ解析 ", List1 = L1)) # 名前付きリスト生成
L2[["Info"]] # 要素名で取り出し
L2$Info # 別記法
names(L1) <- c("vector", "matrix", "character") # L1 の要素に名前をつける

## 1.2.4. データフレーム
## データフレームは同じ長さのベクトルを束ねたもの
## 解析するデータを纏めた表
## 一般に関数 data.frame( )を用いてデータフレームを作成
## 要素を取り出すには [ , ] を付けて要素の行番号・列番号を指定
## 各行・各列には名前を付けることが可能
## それを用いてデータを参照可

### 関数 data.frame の使い方
(x <- data.frame( # 各項目が同じ長さのベクトルを並べる
     month=c(4, 5, 6, 7),　# 月
     price=c(900, 1000, 1200, 1100), # 価格
     deal=c(100, 80, 50, 75)) # 取引量
)
x[2,3] # 2 行 3 列を取り出す
x[3,] # 3 行目を取り出す
x[,2] # 2 列目を取り出す
x$price # price の列を取り出す
x[2] # 2 列目だけからなるデータフレームを取り出す
## 行・列の名前の操作
rownames(x) # 行の名前の表示
rownames(x) <- c("Apr", "May", "Jun", "Jul") # 行の名前の変更
colnames(x) # 列の名前の表示
colnames(x) <- c("tsuki", "kakaku", "torihiki") # 列の名前の変更
x # 変更されたデータフレームの表示
x["May", "kakaku"] # 特定の要素を名前で参照


## 第 2 章 ベクトルと行列の演算，関数
## 2.1 ベクトルの計算
a <- 1:3
b <- 4:6
a + b 
a + 1:6 # 長さが異なる場合は足りない方を周期的に拡張
## ベクトルの加減・スカラー倍
a + 1:5 # 一方の長さがもう一方の長さの整数倍でない場合は警告
a - b # 引き算も可
2 * a # スカラー倍
## ベクトルの積
a %*% b # 内積 ( 計算結果は 1x1 行列 )
a * b # 要素毎の積 ( 計算結果はベクトル )
a * 1:6 # 長さが異なる場合は足りない方が周期的に拡張
a / b # 除算も成分ごと
## 初等関数の適用 成分ごとの計算
a <- (1:6) * pi/2
sin(a) # 数値誤差のため正確に 0 とならない成分あり
exp(a)
log(a)

## 2.2. 行列とその演算
(A <- matrix(1:6, nrow=2, ncol=3)) # ベクトルの行列化
(B <- rbind(c(2, 3, 5), c(7, 11, 13))) # 行ベクトルの連結
(C <- cbind(c(0, 0), c(0, 1), c(1, 0))) # 列ベクトルの連結
A + B - C
A / B # 除算も成分ごと
A %*% C # 行列の積 (結果は2x2行列)
C %*% B # 行列の積 (結果は3x3行列)
A %*% t(A) # 行列 A とその転置行列の積 (結果は2x2行列)
## 初等関数の適用 成分ごとの計算
a <- (1:6) * pi/2
A <- matrix(a, 2, 3)
sin(A)
exp(A)
log(A)
## 行列式とトレース
(A <- matrix(1:9, nrow=3, ncol=3))
det(A) # 行列式 (determinant)
sum(diag(A)) # トレース (trace)
## 逆行列
(A <- matrix(c(2, 3, 5, 7, 11, 13, 17, 19, 23), nrow=3, ncol=3))
(B <- solve(A)) # 逆行列の計算
A %*% B
B %*% A

## 2.3. ベクトルと行列の計算

## 2.3.1. 行列とベクトルの積
## 列ベクトル・行ベクトルという区別なし
## 単一のベクトルという概念
## 行列とベクトルの積においては行列のどちらからベクトルを掛けるかによって
## 自動的に列ベクトルか行ベクトルか適切な方で扱われる
## ベクトルも行列の一種
## 計算結果は行列として表現
(A <- matrix(1:16, nrow=4, ncol=4))
(b <- c(2, 3, 5, 7))
A %*% b # 列ベクトルとして計算
b %*% A # 行ベクトルとして計算

## 2.4. 関数
## 2.4.1. 制御文
## 一般に最適化や数値計算などを行うためには
## 条件分岐や繰り返しを行うための仕組みが必要
## 制御文if( 条件分岐 ), for, while( 繰り返し ) を用いた構文
### 条件分岐 (if)
x <- 5
if(x > 0) { # 正か否か判定
    ## 条件が真の場合に実行
    print("positive")
} else {
    ## 条件が偽の場合に実行
    print("negative")
}
## else 以下はなくても動く
if(x > 0) {
    print("positive")
}
ifelse(x < 0, "true", "not true") # 評価が簡便な場合

### 繰り返し for
y <- 0
for(i in 1:10) { # 1-10 の合計を計算
    y <- y + i
}
print(y)

## 繰り返し while
z <- 1
n <- 0
while(z < 100) {# 100 以上になるまで 2 倍し続ける
    z <- 2 * z
    n <- n + 1
}
print(z) # 100 を超えた際の z の値 128
print(n) # 条件を満たすまでの回数 7

## 2.4.2. 関数の定義
## 関数とは入力を規則に従って変換し出力する仕組み
## 入力を引数 (argument) 出力を返値 (value) と呼ぶ
## 関数 function()を用いて自由に関数を定義可能
### 階乗を計算する関数
fact <- function(n){ # 素直に計算
    ifelse(n>0,prod(1:n),1)
}

fact2 <- function(n){ # 再帰的に定義
    if(n>0) {
        return(n*fact2(n-1))
    } else {
        return(1)
    }
}
fact(10)
fact2(10)


## 第 3 章 データの加工・整理と入出力
## 3.1. データの抽出
## データからの必要な部分集合の抽出
## 添え字指定が最も基本的
## 添え字の指定の仕方
## 番号の指定 論理値での指定
## ベクトルの例
x <- c(4, 1, 2, 9, 8, 3, 6)
x[c(5, 2)] # 5 番目と 2 番目の要素をこの順で抽出
x[-c(2, 3, 7)] # 2,3,7 番目以外の要素を表示
(idx <- x > 3) # 3 より大きい要素は TRUE, 3 以下の要素は FALSE
x[idx] # 3 より大きい要素をすべて表示
x[x > 3] # 上と同じ
x[-c(2, 3, 7)] # 2,3,7 番目以外の要素
x[c(2, 5)] <- c(0, 1) # 2 番目と 5 番目の要素を文字 0 と 1 に置換
x
(names(x) <- letters[1:length(x)]) # x の要素にアルファベットを順に名前をつける
x[c("b", "e")] # 2 番目と 5 番目の要素

## データフレームの例
## R の組込みデータセット airquality を利用
## 詳細は help(airquality) 参照
dim(airquality) # 大きさを確認
names(airquality) # 列名を表示
head(airquality) # 最初の 6 行を表示
str(airquality) # オブジェクトの構造を表示
airquality[which(airquality$Ozone>100), ] # Ozone が 100 を超える行の抽出
airquality[which(airquality$Ozone>100), c("Month", "Day")]
## Ozone が 100 を超える行の Month と Day を表示
subset(airquality, Ozone>100) # Ozone が 100 を超える行の抽出

subset(airquality, Ozone>100, select=Wind:Day)
## Ozone が 100 を超える行で列名が Wind -- Day のデータを抽出

subset(airquality, !is.na(Ozone) & Day %in% c(1, 2))
## Ozone に欠測 (NA) がなく , Day が 1 か 2 のデータを抽出

subset(airquality, Ozone>=120 | Temp >= 95)
## Ozone が 120 以上か Temp が 95 以上のデータ

subset(airquality, Day == 1, select = -Temp)
## Day が 1 の行について Temp 以外の列を抽出

## 3.2. ファイルを用いたデータの読み書き
## 実際の解析の過程
## 収集されたデータの読み込み
## 整理したデータの保存
## Rのサポート 
## CSV 形式 (comma separated values) のテキストファイル
## R の内部表現を用いたバイナリーファイル (RData 形式)
## データフレームを対象としてそれぞれの形式でファイルの読み書きを行うための関数

## 3.2.1. 作業ディレクトリの確認と変更
## R の実行は特定のフォルダ ( ディレクトリ ) 上で行われる
## そのフォルダを作業ディレクトリ
## R のコード内でファイル名を指定した場合
## 特に指定しない限り作業ディレクトリに存在を想定
## 現在の作業ディレクトリの確認 関数 getwd( )
## 作業ディレクトリの変更には関数 setwd( )
getwd() # 作業ディレクトリの確認 ( 環境によって実行結果が異なるため , 実行結果は省略 )
setwd("~/Documents") ## 例

## 3.2.2. CSV 形式の操作
## 関数 write.csv( ) 1つのデータフレームを CSV 形式のファイルへの書き出し
## 書き出し後のファイルは特に指定しない限り作業ディレクトリ下に保存
(mydata <- subset(airquality, Ozone > 90, select=-Temp)) # データフレームの作成
dim(mydata) # 大きさを確認
write.csv(mydata, file="mydata.csv") # csv ファイルとして書き出し
## 関数 read.csv( )：CSV形式のファイルからの読み込み
## 読み込むファイルはディレクトリを明示的に指定しない限り作業ディレクトリに存在を想定
(newdata <- read.csv(file="mydata.csv", row.names=1)) # csv ファイルの読み込み
## row.names=1 第 1 列を読み込んだデータフレームの各行の名前に割り当てること
dim(newdata) # 大きさを確認

## 外部 CSV データの読み込み
## 東京都の 2016 年の気候データによる例
## 気象庁のホームページより取得
## http://www.data.jma.go.jp/gmd/risk/obsdl/index.php
## 東京都の 2016 年の各日の
## 平均気温 (°C )，降水量 (mm)，全天日射量 (MJ/u) 平均風速 (m/s)
## を記録したデータセット kikou2016.csv
kikou <- read.csv("kikou2016.csv", fileEncoding = "sjis") # ファイルの文字コードが Shift-JIS のため
head(kikou) # データの最初の 6 行を表示
dim(kikou) # 大きさを確認
colnames(kikou) # 列名を確認

## 3.3. データの整理
## 与えられたデータの総和や平均 , 最大値・最小値を求めたい状況は頻繁にある
## これらの操作を簡便に実行するための関数
## sum( ), mean( ), max( ), min( )
sum(1:100) # 1 から 100 までの整数の総和
## 気候データによる例
kion <- kikou$気温 # 気温を取り出す
mean(kion) # 平均
max(kion) # 最大値
min(kion) # 最小値

## 行列やデータフレームの列(あるいは行)ごとに平均などの統計量
## 関数apply( ) そのような計算に便利な関数
## apply(X, MARGIN, FUN)
## 引数 X にデータフレーム
## MARGIN には行ごとの計算には1，列ごとの計算には2
## 引数 FUN には求めたい統計量を計算するための関数を指定
## ただし総和や平均：列や行ごとに計算するための専用の関数あり
x <- matrix(1:100, 4, 25)
sum(x) # x の成分全ての和を計算する (mean 等も同様 )
rowSums(x) # 行ごとの総和
apply(x, 1, "sum") # 上と同じ
## 気候データによる例
kikou <- read.csv("kikou2016.csv", fileEncoding = "sjis")
x <- subset(kikou, select = -c(月, 日)) # 月日は除いておく
colMeans(x) # 列ごとの平均
apply(x, 2, "max") # 列ごとの最大値
sapply(x, "max") # 上と同じ
apply(x, 2, "min") # 列ごとの最小値
## 自作関数の適用
apply(x, 2, function(x) sum(x > mean(x))) # 列ごとに平均より大きいデータの数を計算

## データフレームの各行をいくつかのグループにまとめて
## グループごとの統計量を計算したい状況
## 関数 aggregate(x, by, FUN)
## x データフレーム
## by 各行が属するグループを指定するベクトルをリストで与える( 複数可 )
## FUN 求めたい統計量を計算するための関数
## x がベクトルの場合には関数 tapply( ) も利用可能

## 気候データによる例
kikou <- read.csv("kikou2016.csv", fileEncoding = "sjis")
## 月ごとの各変数の平均値
aggregate(kikou[ ,-(1:2)], by = list( 月 = kikou$ 月 ), FUN = "mean")
## 以下のコードも同じ結果を返す
aggregate( . ~ 月 , data = subset(kikou, select = - 日 ), FUN = "mean")
## 月および降水の有無でグループ分け
aggregate(kikou[ ,-(1:2)], FUN = "mean",
          by = list( 月 = kikou$月 , 降水の有無 = (kikou$降水量 > 0)))


## 第 4 章 データのプロット
## 記述統計量と並んでデータ全体の特徴や傾向を把握するために効果的な方法
## データの可視化
## Rの基本パッケージ graphics に用意されている作図機能はきわめて多彩
## これらを適切に組み合わせることによって様々な種類のグラフ描画が可能
## いくつかの代表的な描画関数を紹介
## 描画関連の関数
## 色，線種や線の太さ，あるいは図中の文字の大きさなどを指定するための多彩なオプション

## 4.1. 基本的な描画
## 描画において基本となるのは関数 plot( )

## 関数 sin( ) のような 1変数の関数として定義されているもの
## 定義域を指定してやればそのまま表示

## 関数を追加するにはオプション add とともに関数 curve( ) を用いる

## 関数 plot( ) に同じ長さの二つのベクトルを与えると
## 同じ番号の要素からなる点の組 (x, y) をプロットして,その散布図を描く

## type プロットの種類 ( 点や線 ) の指定
## pで点(point) , lで点列を順に結んだ線 (line) 
## オプションに与える文字列はシングルクォートダブルクォートで囲む
## オプション col で色 詳細略

## 関数 plot( ) で描いた図中
## 線を追加するには関数 lines( )
## 点を追加するには関数 points( )

## ベクトルのプロット
plot(1:10)

## 擬似データの作成
x <- seq(0, 4*pi, by=0.1)
y <- sin(x) + rep_len(c(-0.2, 0.1), length(x))
## 関数の描画
plot(sin, 0, 4*pi,
     col="blue", # グラフの線の色
     lwd=2, # グラフの線の太さ
     ylab="sin/cos" # y 軸のラベル
     )
curve(cos,
      add=TRUE, # グラフを上書き
      col="red", lwd=2
      )
points(x, y, col="green", pch="*") # 点を追加. pch は点の形を指定

## (x,y) データの描画
plot(x, y, type="p", pch="x", ylim=c(-2,2)) # ylim で値域を指定
curve(sin, add=TRUE, col="orange", lwd=2)
lines(x, y, col="blue") # 折れ線を追加

## データフレームを用いた散布図 (airquality を利用 )
plot(Ozone ~ Wind, data=airquality, pch="*", col="red", cex=2) # cex は点の大きさの倍率を指定

## 関数 legend( ) によるグラフへの凡例の追加
f <- function(x) exp(-x) * cos(x)
plot(f, 0, 2 * pi, col = "red", lwd = 2, ylab = "")
g <- function(x) exp(-x) * sin(x)
curve(g, lty = 2, # グラフの線の形式 . 2 はダッシュ線に対応
      add = TRUE, col = "blue", lwd = 2)
legend(4, # 凡例の左上の x 座標
       1, # 凡例の左上の y 座標
       legend = c(expression(e^{-x}*cos(x)), expression(e^{-x}*sin(x))), # 凡例
       lty = c(1, 2), lwd = 2, col = c("red", "blue"), # ここのパラメーターは通常グラフと合わせる
       bty = "n", # 凡例の枠線の形式 ( オプション ). "n" は書かない
       y.intersp = 2 # 行間の指定 ( オプション )
       )

## OS によっては日本語を含む図を描画すると文字化けする場合あり
## 関数 par( ) のオプション family に適当なフォントファミリーを指定することで
## 文字化けを回避できる場合がある
## 例：Mac OS のデフォルトの設定では日本語を含む図は文字化けする
## 以下のコマンドをコンソール上で実行することで文字化けを回避
## par(family = "HiraginoSans-W4")

## 東京都の 2016 年の気候データによる例
kikou <- read.csv("kikou2016.csv", fileEncoding = "sjis")
## 月ごとの平均をプロット
(x <- aggregate(kikou[ ,-c(1,2)], by = list( 月 = kikou$ 月 ),
                FUN = "mean")) # 月ごとの平均を計算
plot(x$ 気温 , type = "b", lwd = 3, col = "green", ylim = c(0, max(x$ 気温 )),
     xlab = " 月 ", ylab = "", main = "2016 年気候データ ", # グラフタイトル
     axes = FALSE) # 軸を書かない
axis(1, 1:12, 1:12) # x 軸の作成
axis(2) # y 軸の作成
lines(x$ 降水量 , type = "h", lwd = 3, col = "blue")
lines(x$ 日射量 , lwd = 3, lty = 2, col = "red")
abline(0, 0, lwd = 2, lty = "dotted") # y=0 の線を引く
legend(1, 25, legend = c(" 気温 "," 降水量 "," 日射量 "),
       col = c("green", "blue", "red"), lwd = 3,
       lty = c(1, 1, 2))

## 4.2. ヒストグラム
## hist( ) データの頻度分布を表すヒストグラムを描画

## 気候データによる例
## 基本的なヒストグラムの描画
kikou <- read.csv("kikou2016.csv", fileEncoding = "sjis")
hist(kikou$気温 )

hist(kikou$気温, 
     xlab = "", ylab = "頻度",
     breaks=25, # ビンの数を約 25 に設定
     labels = TRUE, # 各ビンの度数を表示
     col = "green", main="2016 年気温ヒストグラム "
     )

hist(kikou$ 風速 , freq = FALSE, # 全体に対する割合で表示
     xlab = "", ylab = " 密度 ", breaks=25, col = "lightblue",
     border = "lightblue", # 長方形の境界の色
     main="2016 年風速ヒストグラム "
     )

## 4.3. 箱ひげ図
## 複数のデータの分布の比較
## 観測数が大きく異なるなどヒストグラムでの比較が難しい場合
## 複数のデータの分布の違いを簡便に見るには箱ひげ図 (boxplot)
## データフレームを用いた表示例 ( 気候データを利用 )
kikou <- read.csv("kikou2016.csv", fileEncoding = "sjis")
boxplot(kikou[ ,-c(1,2)]) # 月日は除く
## 月ごとに気温を分類した場合
boxplot(気温 ~ 月, data=kikou, col="orange", main = "月ごとの気温")
boxplot(気温 ~ 月, data=kikou, col="purple", main = "月ごとの気温 ", horizontal=TRUE)

## 4.4. 棒グラフ
## 関数 barplot( ) による棒グラフの作成
## barplot( ) の第 1 引数はベクトルまたは行列
### 気候データによる例
kikou <- read.csv("kikou2016.csv", fileEncoding = "sjis")
## 月ごとに各変数の平均を計算
x <- aggregate(kikou[ ,-c(1,2)], by = list( 月 = kikou$ 月 ), FUN = "mean")
# 棒グラフの作成
barplot(as.matrix(x[ ,-1]), # 第 1 引数はベクトル or 行列でなければならない
        col = rainbow(12)[c(8:1,12:9)], # 12 色に色分け
        beside = TRUE, # 棒グラフを横に並べる
        space = c(1.5, 3), # 棒グラフ間・変数間のスペースを指定
        legend.text = paste0(x[ ,1], " 月 "), # 凡例の指定
        args.legend = list(ncol = 2) # 凡例を 2 列にして表示
        )

## 4.5. 円グラフ
## 円グラフは関数 pie( ) で描くことができる.
## 関数 pie による円グラフの作図
kikou <- read.csv("kikou2016.csv", fileEncoding = "sjis")
z <- hist(kikou$ 日射量 , breaks=5, plot=FALSE) # 5 つ程度に分類
x <- z$count
y <- z$breaks
names(x) <- paste(y[-length(y)], y[-1], sep="-")
pie(x, col=gray(seq(0,1,length=length(x))))
pie(x, clockwise=TRUE, col=heat.colors(length(x)), main = "2016年日射量")

## 4.6. 散布図行列
## 関数 pairs による散布図の作図
kikou <- read.csv("kikou2016.csv", fileEncoding = "sjis")
pairs(kikou[,-c(1,2)], col="blue")
## plot(kikou[,-c(1,2)], col="blue") でも同じ図が描ける
pairs(~ 気温 + 日射量 + 風速 , data = kikou, # 表示する項目を指定
      col=topo.colors(12)[kikou$ 月 ]) # 月毎に異なる色で表示

## 4.7. 3 次元のグラフ
## 関数 persp( ) 3 次元のグラフを 2 次元に射影した俯瞰図
## 視線の方向はオプション theta と phi で極座標を指定することによって制御
## パッケージscatterplot3dの3次元の散布図を書くための関数 scatterplot3d( )
## 関数 persp による 2 変数関数の俯瞰図
f <- function(x,y) x^2 - y^2
x <- seq(-3, 3, length=51) # x 座標の定義域の分割
y <- seq(-3, 3, length=51) # y 座標の定義域の分割
z <- outer(x, y, f) # z 座標の計算
persp(x, y, z, col="lightblue")
persp(x, y, z, theta=30, phi=30, expand=0.5, col="royalblue",
      main = expression(z==x^2-y^2))

## 3 次元散布図 ( パッケージ scatterplot3d を利用 )
install.packages("scatterplot3d") # パッケージのインストール
library(scatterplot3d) # パッケージのロード
kikou <- read.csv("kikou2016.csv", fileEncoding = "sjis")
dat <- subset(kikou, select = c(" 風速 ", " 日射量 ", " 気温 "))
scatterplot3d(dat, pch = 4, color = "orchid", cex.symbols = 1.5)

