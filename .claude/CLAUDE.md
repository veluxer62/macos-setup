# User-Level Claude Code Configuration

## Git 및 커밋 규칙
- **커밋 메시지 형식**:
  ```
  <type>: <subject>

  <body> (선택)
  ```
- **Type 종류**:
  - feat: 새로운 기능 추가
  - fix: 버그 수정
  - refactor: 코드 리팩토링
  - style: 코드 포맷팅, 세미콜론 누락 등
  - docs: 문서 수정
  - test: 테스트 코드 추가/수정
  - chore: 빌드 업무, 패키지 매니저 설정 등

## 문서화
- **README.md 범위 제한**: macOS 세팅 관련 내용만 작성
- **README.md 필수 항목**:
  - 문서 목적(새 macOS 환경 세팅 가이드)
  - 설치 항목 및 설치 명령어
  - macOS 도구별 설정 방법
  - 참고 링크(공식 문서/저장소)
- **README.md 제외 항목**:
  - 서비스 실행 방법(서버 실행, 배포 절차)
  - 애플리케이션 기능 소개
  - 일반적인 소프트웨어 프로젝트 기술 스택 설명
