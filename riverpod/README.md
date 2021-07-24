# riverpod

 - 헷갈릴만한 용법 정리
  1. 메소드
    1) read
        - 가장 가까운 provider 의 value 값을 가져옴
        - value 값이 바뀌어도 rebuild 되지 않음
        - build 안에서 직접적으로 사용할 수 없음
        - build 될 때 처음에만 값에 접근하고, 후에 업데이트 되는 것에는 상관 하지 않을 때 유용함
    2) watch
        - value 값이 변할 때 rebuild 하기 위해 사용함
        - build 안에서 사용해야함 
    3) select
        - 오직 구독하는 값의 일부분만 listen 하게 함
        - 구독하는 값에 field가 여러 개 일 때, performance optimization을 위해 사용함
  2. 메소드 사용 위젯
    1) Consumer
        - provider 계급 트리 아래에서 구독 값 사용하고 싶을 때 사용
    2) Selector
        - provider 계급 트리 아래에서 구독하는 값의 일부만 사용하여 쓰고 싶을 때 사용
  3. 다양한 provider
    1) MultiProvider
        - multiple provider 을 nested 형태로 만들지 않기 위해서 사용
    2) StreamProvider
        - 비동기적 이벤트의 목록인 stream(특정 이벤트가 준비되었을 때 발동) 을 사용하기 위한 provider
        
    3) FutureProvider
        - 비동기적 이벤트인 future을 사용하기 위한 provider
    4) ProxyProvider
        - 다른 providers 들로부터 다양한 값을 받아서 새로운 객체로 변환함