---
layout: page
title: R 도커
subtitle: 도커파일(Dockerfiles)
---

앞서, 도커허브에서 RStudio를 포함하고 있는 기본 이미지로 학습을 시작했다.
다음으로 컨테이너에 더 많은 것을 추가해서 넣고자 한다.
예를 들어, R 팩키지와 미리 심어진 데이터셋처럼 부팅하자마자 바로 사용할 준비가 되면 참 좋을 듯 하다.
이런 목적 때문에, `도커파일(Dockerfile)`을 학습한다.

도커파일은 기본이미지에 추가로 팩키지나 데이터를 추가하는 방법을 담고 있는 명령어 집합이다.
도커파일은 일련의 *계층(Layer)*으로 맞춤형 이미지를 생성시킨다.
`Dockerfile`이라고 불리는 파일에 다음을 첫머리에 추가한다:

```
FROM rocker/hadleyverse:latest
```

상기 명령어가 도커에게 지시하는 것은 `rocker/hadleyverse` 기본이미지에서 시작하라는 것이다 -- 사실 지금까지 사용한 기본 이미지이기도 하다. `FROM` 명령어는 도커파일(Dockerfile)에서 항상 첫머리에 나와야 한다; 
파이를 오븐에 요리할 때 파이 가장 밑바닥에 깔리는 딱딱한 껍질에 해당된다.

다음으로, `rocker/hadleyverse` 기본 이미지에 또다른 계층을 추가한다. 예를 들어,
`gapminder` 팩키지를 미리 설치해서 바로 부팅하자마자 사용하고자 한다:

```
RUN wget https://cran.r-project.org/src/contrib/gapminder_0.2.0.tar.gz
RUN R CMD INSTALL gapminder_0.2.0.tar.gz
```

도커파일에 `RUN` 명령어는 쉘명령어를 실행시킨다.
위 명령어를 살펴보면 첫번째 행은 CRAN에서 `gapminder` 소스를 다운로드 받는다.
두번째 행은 `gapminder` 팩키지를 설치한다 (R을 실행시킨 후에 `install.packages()` 명령어를 실행하는 것과 거의 동일하지만, 가장 최근버전이 아니고 지정된 버젼, 이번 경우에는 0.2.0 버젼을 설치)
도커파일 편집내용을 저장하고 도커 터미널로 돌아간다; 다음 명령어를 사용해서 도커이미지를 생성시킨다:

```
docker build -t my-r-image .
```

`-t my-r-image` 명령어를 수행하면 해당 명칭(이미지 명칭은 항상 모두 소문자임에 주목한다)을 갖는 이미지가 생성된다.
`.`은 이미지를 생성하는데 필요한 모든 자원이 현재 디렉토리에 위치함을 지정한다.
다음 명령어를 통해 이미지가 제대로 생성되었는지 확인한다:

```
docker images
```

목록에 `my-r-image`가 나타나야 된다. `rocker/hadleyverse` 기본 이미지를 실행한 것과 유사한 방식으로 새로 생성한 이미지를 실행시킨다:

```
docker run -dp 8787:8787 my-r-image
```

그리고 나서, RStudio 터미널에서 `gapminder`를 다시 실행시킨다:

```
library('gapminder')
gapminder
```

그리고 나면 `gapminder`가 이미 설치되어 있어 신규 도커 이미지로 바로 사용할 준비가 마친것을 확인할 수 있다.
다음 명령어 하나로 실행되고 있는 모든 컨테이너를 멈추고 제거한다:

<!--- (TODO: Have we really talked about this before? Do we just want to use Ctlr+c) -->

```
docker rm -f $(docker ps -a -q)
```

`gapminder` 같은 R 팩키지 뿐만 아니라, 도커이미지 내부에 데이터 같은 정적 파일도 필요하다.
도커파일(Dockerfile) 내부에 `ADD` 명령어를 사용해서 데이터도 넣어 바로 사용할 수 있다.


`data.dat` 라는 파일을 새로운 파일을 생성한다. 원하는 디렉토리에 저장한 파일을 위치시킨다;
그리고 나서 다음 행을 도커파일(Dockerfile) 맨아래 추가시킨다:

```
ADD data.dat /home/rstudio/
```

도커 이미지를 다시 빌드해서 생성시킨다:

```
docker build -t my-r-image .
```

그리고 나서 다시 재실행한다:

```
docker run -dp 8787:8787 my-r-image
```

브라우저에서 RStudio를 실행시켜 다시 되돌아가면 `data.dat` 파일이 생성되어 있는 것을 확인할 수 있고,
RStudio에서 파일이 보이게 된다. 이런 방식으로 파일을 도커 이미지의 일부로 잡아 넣을 수 있다.
따라서, 파일이 항상 정확하게 동일한 상태로 이미지의 일부로 언제나 이용가능하게 된다.

#### 캐쉬 계층(Cached Layers)

이번 학습에서 도커 이미지를 생성하고 재생성할 때, 다음과 같은 행이 출력되는 것을 목도했을 것이다:

```
Step 2 : RUN wget https://cran.r-project.org/src/contrib/gapminder_0.2.0.tar.gz
 ---> Using cache
 ---> fa9be67b52d1
Step 3 : RUN R CMD INSTALL gapminder_0.2.0.tar.gz
 ---> Using cache
 ---> eeb8ef4dc0a8
```

캐쉬된 명령어가 사용되는 것에 주목한다.
이미지를 빌드해서 생성할 때, 동일한 명령어가 이전에 실행되었는지 확인하려고 도커가 이전 이미지를 검사한다;
명령어 각 단계는 별도 계층으로 보관되고, 도커는 이전과 *동일한 순서*이고 변경되지 않았다면 해당 계층을 
재사용할하는 똑똑한 기능을 갖추고 있다. 따라서, 설정단계 일부를 해결하자마자(특히, 속도가 나지 않는 부분이면)
도커파일 상단에 위치시키고 해당 줄 사이 혹은 상단에 어떤것도 놓지 말라. 특히 자주 변경되는 것을 위치시키지 않는 것이 좋다; 이런 방식으로 빌드 생성과정에 상당한 속도향상을 기대할 수 있다.

다음 수업: [수업 06 분석결과 공유](06-Sharing-all-your-analysis.html)으로 진행하거나 
[학습목차](index.html)로 되돌아 간다.

