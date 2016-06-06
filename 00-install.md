---
layout: page
title: R 도커
subtitle: 도커 설치
---


> ## 학습목표 {.objectives}
>  
> * 도커를 설치한다.
> * 윈도우즈, 리눅스, 맥에 도커를 설치한다.

## 리눅스에서 도커 설치

리눅스에서 도커를 설치하는 과정은 터미널을 열고 다음 명령어를 쭉 실행시키면 간단히 설치된다.
`curl`이 설치되지 않은 경우 `curl`을 설치하고 도커를 설치하면 된다.

~~~ {.shell}
$ which curl
$ sudo apt-get update
$ sudo apt-get install -y curl
$ curl -fsSL https://get.docker.com/ | sh
$ curl -fsSL https://get.docker.com/gpg | sudo apt-key add -
$ docker run hello-world
~~~

## 맥에 도커 설치

1. 애플 메뉴 좌측 최상단 애플 로고를 클릭하여 `이 Mac에 관하여` 를 클릭하여 OS X 10.8 "마운틴 라이언" 버젼이상이 되는 것을 확인한다.
1. [Docker Toolbox](https://www.docker.com/products/docker-toolbox)로 가서 도커연장통(Docker Toolboxk)을 다운로드한다.
1. 다운로드한 팩키지를 두번 클릭하거나 우클릭하여 "Open from the pop-up menu"를 선택한다.
1. `install` 버튼을 클릭하여 설치를 진행한다.
1. 설치가 완료되면, `LaunchPad`에서 `Docker Quickstart Terminal` 아이콘을 확인하고 연다.

~~~ {.output}
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/


docker is configured to use the default machine with IP 192.178.99.100
For help getting started, check out the docs at https://docs.docker.com

$ docker run hello-world
~~~

상기와 같은 화면이 나오면 모든 설치가 완료된 것이다. 특히 `192.178.99.100` IP주소는 RStudio를 사용할 때 유용하게 활용되니 필히 기억해 둔다. 
`docker run hello-world` 명령어를 처음 실행하면 도커허브에서 `hello-world` 이미지를 받아온다. 이제 맥에서 도커를 사용할 준비가 모두 끝났다.


## 윈도우즈 도커 설치

윈도우에서 도커를 설치하는데 여러가지 조건이 사전에 만족되어야 한다.

1. 64비트 운영체제이며, 윈도우 7이상 이어야한다.
    * 제어판 &rarr; 시스템과 보안 &rarr; 시스템 으로 들어가서 윈도우 버젼을 확인한다.
1. 가상화가 지원되는지 확인한다.
    * 시작 &rarr; 작업관리자 &rarr; `성능` 탭으로 가서 **가상화** 가 활성화되었는지 확인한다.
1. [Docker Toolbox](https://www.docker.com/products/docker-toolbox)로 가서 도커연장통(Docker Toolboxk)을 다운로드한다.
1. 다운로드한 팩키지를 두번 클릭하거나 우클릭하여 "Open from the pop-up menu"를 선택한다.
1. `install` 버튼을 클릭하여 설치를 진행한다.

만약 가상상자(VirtualBox)가 미리 돌고 있는 경우 반드시 정지시키고 설치작업을 진행시킨다.

나머지 과정은 맥과 동일하다.



