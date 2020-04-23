# #より右はコメントであり，実行されない
# カーソルのある位置でctrl+enterでその行が実行される
# または範囲指定してctrl+enterで複数行の実行
# 右上の「Run」をクリックでも「実行」

student <- read.csv("student.csv", header = T)
student$shinchou[1:10] 
danshi.shinchou <- student[student$seibetsu == 1, 1] #男子学生の身長ベクトル
## 関数subsetを使った男子学生の抽出方法は分かりますか？
h <- hist(danshi.shinchou, right=FALSE)       # ヒストグラム．histの区切りはbreaksで指定する
h$counts  # 度数のカウント（histで作られたオブジェクトは）各ビンの度数の情報を保持
h$counts/length(danshi.shinchou)             # 相対度数


plot(ecdf(danshi.shinchou),do.points=T, verticals=F)  # 描画
plot(ecdf(danshi.shinchou), do.points=FALSE, verticals=TRUE)  # 描画

mean(danshi.shinchou) # 平均
var(danshi.shinchou) # 分散
sd(danshi.shinchou) # 標準偏差
summary(danshi.shinchou) # 要約統計量
boxplot(danshi.shinchou) # 箱ひげ図
quantile(danshi.shinchou, probs = seq(from = 0, to = 1, by = 0.1)) # 分位点

danshi.4 <- student[student$seibetsu == 1, 1:4] #男子学生の身長，体重，父身長，母身長
danshi.4
summary(danshi.4) # 要約統計量
var(danshi.4) # 分散共分散行列
cor(danshi.4) # 相関係数行列
plot(danshi.4$shinchou, danshi.4$father) # 散布図 息子 vs 父
plot(danshi.4$father, danshi.4$mother) # 散布図 息子 vs 母
cor(danshi.4$father, danshi.4$mother) # 散布図 父 vs 母

pairs(danshi.4) # 原始的な散布図行列
## library(psych)
install.packages("psych") # psychというパッケージにより格好良い散布図行列の関数あり
library(psych) # psychの読み込み
## pairs.panels(z)
pairs.panels(danshi.4, hist.col="white", rug=F, ellipses=F, lm=F, density=F)

## 自作の関数
## 平均 +- 標準偏差 の間に入る観測値の相対頻度を数える
inrange <- function(x){                         # 関数定義
  m <- mean(x);   n <- length(x);   s <- sd(x)*sqrt((n-1)/n)
  return((x > m-s) & (x < m+s)) # xと同じ長さの論理値ベクトル
}
sum(inrange(danshi.shinchou))/length(danshi.shinchou)     # 割合

## チェビシェフの不等式
Chebychev <- NULL # 空き箱
for(k in 2:4){
  out <- 1-inrange(danshi.shinchou)
  Chebychev<- c(Chebychev, 1/k^2-sum(out)/length(danshi.shinchou))
}
Chebychev # チェビシェフの不等式は，1/k^2<sum(out)/length(danshi.shinchou)を主張

## Rで分割表を作る．
## 男子学生の「自宅or下宿」「恋人ありorなし」に関するダミー変数（0 or 1）
danshi.2 <- student[student$seibetsu == 1, c("jitaku", "koibito")]
danshi.2.0 <- subset(student, select = c("jitaku", "koibito"), subset = (seibetsu == 1))
danshi.2
danshi.2.0

jitaku.koibito.tab <- table(jitaku = danshi.2$jitaku, koibito = danshi.2$koibito) 
jitaku.koibito.tab
addmargins(jitaku.koibito.tab)
jitaku.koibito.tab[, 2]
sum(jitaku.koibito.tab[, 2]) / nrow(danshi.2)

jitaku.koibito.tab[1,2]/sum(jitaku.koibito.tab[1,])
jitaku.koibito.tab[2,2]/sum(jitaku.koibito.tab[2,])

## 2x2分割表の相関係数
cor(danshi.2)
bunshi <- jitaku.koibito.tab[1,1]*jitaku.koibito.tab[2,2]-jitaku.koibito.tab[1,2]*jitaku.koibito.tab[2,1]
bunbo <- sqrt(sum(jitaku.koibito.tab[,1])*sum(jitaku.koibito.tab[,2])*sum(jitaku.koibito.tab[1,])*sum(jitaku.koibito.tab[2,]))
bunshi/bunbo
## 女子学生でやってみよう


## 単回帰分析
kaiki.1 <- lm(shinchou ~ father, data=danshi.4) #回帰分析を行うための関数lm，息子の身長は父の身長でどの程度説明可能か？ 
summary(kaiki.1)
kaiki.1$residuals #残差ベクトルの表示
rss.kaiki.1 <- sum(kaiki.1$residuals^2) #残差平方和
plot(danshi.4$father, danshi.4$shinchou) #散布図
abline(kaiki.1) #回帰直線を上書き

danshi.4$father.meter <- danshi.4$father/100 #身長の単位をcm --> m
danshi.4$shinchou.meter <- danshi.4$shinchou/100 #身長の単位をcm --> m
head(danshi.4) #先頭のいくつかの成分を表示

## 単位を変えた回帰分析 
kaiki.2 <- lm(shinchou.meter ~ father.meter, data=danshi.4) #回帰分析を行うための関数lm 
summary(kaiki.2) #回帰分析の結果
kaiki.2$residuals #残差ベクトルの表示
rss.kaiki.2 <- sum(kaiki.2$residuals^2) #残差平方和
plot(danshi.4$father.meter, danshi.4$shinchou.meter) #散布図
abline(kaiki.2) #回帰直線を上書き

rss.kaiki.1; rss.kaiki.2 # 目的変数の単位を変えたときの残差平方和の比較

## 身長のデータで重回帰分析 父，母の身長 ==> 息子の身長
library(scatterplot3d)
# 3D scatter plot
s3d <- scatterplot3d(danshi.4[,c(3,4,1)], type = "h", color = "blue", angle=70, pch = 16)
# Add regression plane
kaiki.3 <- lm(shinchou ~ father + mother, data=danshi.4) #回帰分析を行うための関数lm 
s3d$plane3d(kaiki.3)
summary(kaiki.3)

## カテゴリー変数（factor）を含む重回帰分析

danshi.5 <- student[student$seibetsu == 1, c(1:4,9)] #男子学生の身長，体重，父身長，母身長
## 9番目の変数は血液型
## 
class(danshi.5$ketsueki)
## カテゴリー変数
levels(danshi.5$ketsueki)
## "a"  "ab" "b"  "o" 
kaiki.5 <- lm(shinchou ~ father + mother + ketsueki, data=danshi.5)
summary(kaiki.5)
## ketsuekiab  -1.33198    1.13485  -1.174    0.241    
## ketsuekib   -0.53277    0.85146  -0.626    0.532    
## ketsuekio   -0.03331    0.74391  -0.045    0.964    
## 血液型の型を表現するダミー変数ketsuekiab，ketsuekib，ketsuekioが自動的に作られたことも分かる．
## これらはダミー変数で
## 血液型がabならば1 そうでないならば0
## 血液型がbならば1 そうでないならば0
## 血液型がoならば1 そうでないならば0
## またa型のダミー変数を作る必要はない．a型の人は上記の３変数ともゼロを取るからである．
## 重回帰分析でカテゴリー変数によるダミー変数を含める場合には，
## (カテゴリーの数-1)のダミー変数を作れば良いことを理解して下さい．

## そのようなダミー変数を実際に作って結果が一致するかどうかチェック
danshi.5$ketsu.ab <- 0
danshi.5$ketsu.b <- 0
danshi.5$ketsu.o <- 0

danshi.5$ketsu.ab[danshi.5$ketsueki == "ab"] <- 1
danshi.5$ketsu.b[danshi.5$ketsueki == "b"] <- 1
danshi.5$ketsu.o[danshi.5$ketsueki == "o"] <- 1

kaiki.6 <- lm(shinchou ~ father + mother + ketsu.ab + ketsu.b + ketsu.o, data=danshi.5)
summary(kaiki.6)
## t valueや"Pr(>|t|)"（P値）は説明変数の目的変数を説明する上での重要性に関わる
## 指標である．t valueは大きいほど重要性が高く，"Pr(>|t|)"（P値）は小さいほど重要性が高い
## 身長を説明する上で血液型は明らかに重要でないはずであるが，解析結果もそうなっている．

hist(danshi.5$shinchou, right=FALSE, freq=FALSE, main="身長と正規分布")
mu <- mean(danshi.5$shinchou); s <- sd(danshi.5$shinchou)
curve(dnorm(x, mean=mu, sd=s), mu-3*s, mu+3*s, ylab="", add=TRUE)

