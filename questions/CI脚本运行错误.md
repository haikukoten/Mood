# CI 脚本运行错误

## 报错信息

```shell
$ openssl aes-256-cbc -K $encrypted_d2e7c15ed967_key -iv $encrypted_d2e7c15ed967_iv -in mood.jks.enc -out mood.jks -d
bad decrypt
140442486961824:error:0606506D:digital envelope routines:EVP_DecryptFinal_ex:wrong final block length:evp_enc.c:532:
The command "openssl aes-256-cbc -K $encrypted_d2e7c15ed967_key -iv $encrypted_d2e7c15ed967_iv -in mood.jks.enc -out mood.jks -d" failed and exited with 1 during.
Your build has been stopped.
```

## 错误原因

>Caveat
>
> There is a report of this function not working on a local Windows machine. Please use a Linux or OS X machine.

## 解决办法

在linux或mac os下运行`travis encrypt-file mood.jks --add`命令。
