## 人口10,000人の国の首相の支持率
N <- 10000 
M <- 6000 # 真の支持者数
n <- 100 # 全員に調べるのは大変なので，n人に尋ねる
boshudan <- c(rep(1,M), rep(0,N-M)) # 母集団
sample(boshudan, n) # N人の母集団から非復元抽出
sum(sample(boshudan, n))
sum(sample(boshudan, n))
mean(sample(boshudan, n))
mean(sample(boshudan, n))
x <- replicate(100000, mean(sample(boshudan, n)))
hist(x, breaks=seq(min(x)-0.01, max(x)+0.01, length=15))
## n <- 500 とすると
n <- 500
x <- replicate(100000, mean(sample(boshudan, n)))
hist(x, breaks=seq(min(x)-0.01, max(x)+0.01, length=15))
