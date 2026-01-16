[go page](https://lietzsche.github.io/memo/)

## My Memo

Hugo Book 테마 기반의 메모/문서 사이트입니다.

## 로컬 실행

```bash
hugo server -D
```

## Hugo 설치

### Windows (PowerShell)

```powershell
.\setup-hugo.ps1
```

### Ubuntu/WSL

```bash
./setup-hugo.sh
```

## 전체 가이드

이 섹션은 현재 프로젝트 사용법을 한 곳에 모아둔 가이드입니다.

### 시작하기

#### 프로젝트 구조

- `content/docs` 아래의 문서가 자동 메뉴로 표시됩니다.
- 하위 섹션은 폴더 + `_index.md`로 구성합니다.

#### 로컬 실행

```bash
hugo server -D
```

### 사용법

이 섹션은 실제 사용 시 자주 쓰는 기능을 메뉴별로 정리합니다.

#### 메모 작성

```bash
hugo new docs/usage/new-note.md
```

기본 포맷:

```toml
+++
title = "새 메모"
weight = 10
+++

내용을 여기부터 작성합니다.
```

#### 태그 관리

```toml
+++
title = "태그 예시"
tags = ["work", "idea"]
+++
```

태그별 목록은 `tags` 섹션이 있을 때 자동 생성됩니다.

#### 검색

검색은 기본으로 활성화되어 있습니다. 비활성화하려면 `hugo.toml`에서 `BookSearch = false`로 설정하세요.

### 고급 설정

테마 옵션과 레이아웃 커스터마이징을 모아둡니다.

#### 커스터마이징

로고와 파비콘:

```toml
[params]
  BookLogo = 'logo.png'
  BookFavicon = 'favicon.png'
```

메뉴 숨김:

```toml
+++
bookHidden = true
+++
```
