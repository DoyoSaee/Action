# Action: 영화관 통합 관리 시스템

영화 예매부터 매점 운영, 고객 서비스까지 영화관 운영에 필요한 모든 기능을 통합한 **종합 영화관 웹 애플리케이션**입니다.

## 🎯 주요 특징

* **통합된 영화관 운영 시스템**: 예매, 결제, 포인트 적립, 매점 관리 등 전 과정을 웹에서 처리
* **Spring 기반 웹 서비스**: 전통적인 MVC 기반의 안정적인 구조
* **영화진흥위원회 API 연동**: 실시간 박스오피스 순위 제공
* **고객 친화적 기능**: 마이페이지, 공지, 이벤트, 문의 시스템 내장
* **관리자 기능**: 영화 및 상영관 관리, 매출 리포트 등

## 🛠️ 기술 스택

* **Backend**: Java 1.8, Spring Framework 4.3, MyBatis, Maven
* **Frontend**: JSP, JavaScript, CSS3
* **DB 연동**: MyBatis, JDBC
* **외부 연동**: 영화진흥위원회 OpenAPI, 메일 발송 서비스

## 📂 프로젝트 구조

```
├── booking/        # 영화 예매 시스템
├── store/          # 매점 운영 및 상품 관리
├── member/         # 회원 가입, 로그인, 마이페이지
├── admin/          # 관리자 백오피스 (상영관, 영화, 통계 등)
├── notice/         # 공지사항
├── event/          # 이벤트
├── qna/            # 1:1 문의
├── resources/      # 설정 파일 및 SQL 매퍼
└── webapp/         # JSP 뷰와 정적 리소스
```

## 🚀 설치 및 실행 방법

1. Java 1.8 설치
2. Maven 설치
3. 아래 명령어 실행하여 프로젝트 빌드

```bash
mvn clean install
```

4. Tomcat 또는 Spring Servlet 컨테이너에 배포
5. 브라우저에서 [http://localhost:8080/action](http://localhost:8080/action) 접속

## 🔗 외부 API

* [영화진흥위원회 오픈 API](https://www.kobis.or.kr/kobisopenapi/homepg/main/main.do)

## 📄 라이선스

본 프로젝트는 내부 평가 및 교육용 목적의 데모 프로젝트입니다.

