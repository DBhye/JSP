<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6453e79666e37b86e04aa132347f6cb1"></script>
    <div id="map" style="height:89vh;"></div>
    <script>
   const container = document.getElementById('map');
	const options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표
		level: 3
	};

	const map = new kakao.maps.Map(container, options);
    </script>
