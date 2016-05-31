---
layout: page
title: R 도커
subtitle: 도커허브에 푸쉬해서 밀어 넣고, 풀해서 가져오기
---

## 학습목표

- 이미지를 어느 장소에서 얻어오는지 이해한다.
- 도커허브에서 도커 이미지를 풀해서 가져온다.
- 도커허브로 도커 이미지를 푸쉬해서 밀어넣는다.


## 도커허브에서 이미지를 가져온다.

[도커허브(Docker Hub)](https://hub.docker.com/)는 공개된 도커 이미지가 저장된 장소다.
다음과 같이 명령어를 입력해서 첫 이미지를 실행하면,

```{}
docker run --rm -p 8787:8787 rocker/hadleyverse
```

도커 소프트웨어가 이미지가 해당 컴퓨터에서 이용가능한지 검사한다.
해당 컴퓨터에 없기 때문에, 도커허브에서 이미지를 다운로드해서 가져온다.
도커허브에서 이미지를 가져오는 것은 어떻게 보면 자동으로 동작한다.
이미지만 도커허브에서 가져오기만 하고 실행하지 않는 경우, 다음과 같은 명령어를 실행시킨다.

```{}
docker pull rocker/hadleyverse
```

## 도커허브에서 이미지를 받아오기

본인이 직접 도커 이미지를 생성했다고 가정하자. 
도커 이미지를 전세계 사람들과 공유하고자 한다고 가정하면, 
[https://hub.docker.com/](https://hub.docker.com/)에 계정을 만든 전세계 사람들과 공유하는 것도 이제는 가능하다.
전자우편으로 도커허브 사이트와 사용자간에 상호검증이 완료되면 이제 준비가 다 되었고, 도커 이미지를 도커허브에 올릴 준비는 끝났다.

1. 도커허브 https://hub.docker.com/ 사이트에 계정을 만들고 로그인한다.
2. *Create Repository*를 클릭한다.
3. 저장소 명칭(즉, hadleyverse_gapminder)과 저장소에 대한 간략한 설명을 적고, *Create*를 클릭한다.
4. 명령라인에서 도커허브로 로그인한다.

```{}
docker login --username=yourhubusername --email=youremail@company.com
```
계정에 사용한 사용자명과 전자우편이 필요하다. 비밀번호를 재촉하면 비밀번호를 적어넣는다.
모든 것이 정상 동작되면, 다음과 유사한 메시지가 출력된다.

```{}
WARNING: login credentials saved in /home/username/.docker/config.json
Login Succeeded
```
5. 다음 명령어를 사용해서 이미지 ID를 점검한다.
```{}
docker images
```
그리고 나면, 다음과 유사한 출력결과가 화면에 뿌려지게 된다.

```{}
REPOSITORY                         TAG                 IMAGE ID            CREATED             SIZE
hadleyverse_gapminder_addpackage   latest              95fc956d3a73        2 days ago          2.902 GB
hadleyverse_gapminder              latest              6a131c8f7c2b        2 days ago          2.87 GB
rocker/hadleyverse                 latest              2a039f703dad        3 days ago          2.869 GB
```

이미지에 태그를 붙인다.

```{}
docker tag 6a131c8f7c2b yourhubusername/hadleyverse_gapminder:firsttry
```

태그 다음에 숫자는 이미지 ID(Image ID)와 매칭되어야 하고 `:firsttry`가 이에 상응되는 태그다.

<!--- TODO: Any suggestions on which tag to use? Are there good practices here? -->

6. 이미지를 방금전 생성한 저장소에 푸쉬해서 밀어넣는다.
```{}
docker push yourhubusername/hadleyverse_gapminder
```

이미지가 이제 누구나 사용할 수 있게 공개되었다.

다음 수업: [도커파일(Dockerfiles)](05-dockerfiles.html)으로 진행하거나 
[학습목차](index.html)로 되돌아 간다.

