---
layout: page
title: R 도커
subtitle: 분석결과 공유
---

이제 도커파일(dockerfile)을 갖고 작업하는 방식을 학습했기 때문에, 
분석에 대한 모든 것을 동료에게 전송할 수 있게 되었다.
분석을 실행하는데 필요한 데이터, 팩키지 의존성, 분석결과를 모두 담은 이미지를 공유한다.

도커파일(dockerfile)로 이미지를 빌드해서 생성한다. 기본 `rocker` 이미지부터 차근차근 시작해 나간다.

```
FROM rocker/hadleyverse:latest
```

데이터분석의 일부로 `gapminder` 데이터를 사용했다.
`gapminder` 팩키지를 도커 이미지에 설치할 필요가 있어서, `gapminder` 팩키지를 설치하는 도커파일(dockerfile)을 추가해서 변경하고 저장한다.

```
RUN R -e "install.packages('gapminder', repos = 'http://cran.us.r-project.org')"
```

이제 팩키지가 설치되었으니, 분석결과를 스크립트로 작성하고 나서, 도커파일에 추가한다.

분석으로 간단히 1인당 GDP와 기대수명을 도식화하는 산점도를 생성한다.

R스크립트에 다음 분석결과를 다음과 같이 작성한다.

```{r}
library(ggplot2)
library(gapminder)

life_expentancy_plot <- ggplot(data = gapminder) + 
    geom_point(aes(x = lifeExp, y = gdpPercap, colour = continent)) 
```

`analysis.R` 파일명으로 R스크립트를 저장하고 나서 도커파일에 추가한다.

```
ADD analysis.R /home/rstudio/
```

이제 이미지를 빌드해서 생성시키고 나서 동료와 공유할 모든것이 갖추어졌는지 점검한다.

```
docker build -t my-analysis .
```

`docker iamges` 명령어로 생성시킨 이미지 목록이 나타나는지 확인한다.

```
docker images
```

생성시킨 이미지를 실행시키고, 동료와 공유할 모든 것이 갖춰졌는지 점검한다:

```
docker run -dp 8787:8787 my-analysis
```

아주 좋아요! 분석 스크립트가 컨테이너에 담겨져 있고, `gapminder` 팩키지도 설치가 되어있다.

이제 공유할 준비가 된 분석 도커이미지를 도커허브에 푸쉬해서 올린다.

도커허브에서 *Create Repository*를 클릭한다.
저장소 명칭(즉, gapminder_my_analysis)과 저장소에 대한 간략한 설명을 적고, *Create*를 클릭한다.
명령라인에서 도커허브로 로그인한다.

```{}
docker login --username=yourhubusername --email=youremail@company.com
```

계정에 사용한 사용자명과 전자우편이 필요하다. 비밀번호를 재촉하면 비밀번호를 적어넣는다.
다음 명령어를 사용해서 이미지ID(Image ID)를 확인한다.

```{}
docker images
```

그리고 나면, 다음과 유사한 출력결과가 화면에 뿌려지게 된다.

```{}
REPOSITORY                         TAG                 IMAGE ID            CREATED             SIZE
my-analysis                      latest              dc63d4790eaa        2 minutes ago       3.164 GB
```

그리고 이미지에 태그를 단다.

```{}
docker tag dc63d4790eaa yourhubusername/gapminder_my_analysis:firsttry
```

이미지를 생성한 저장소에 푸쉬해서 밀어넣는다.

```{}
docker push yourhubusername/gapminder_my_analysis
```

이미지가 이제 누구나 사용할 수 있게 공개되었다.

이제 동료가 여러분이 방금 생성한 이미지를 다운로드할 수 있게 되었다.

여러분 동료는 명령라인에 다음과 같이 작성하면 이미지를 바로 이용할 수 있다:

```
docker pull yourhubusername/gapminder_my_analysis
```

이제 동료도 여러분과 동일한 분석환경을 갖게 된 것이다.

[학습목차](index.html)로 되돌아 간다.
