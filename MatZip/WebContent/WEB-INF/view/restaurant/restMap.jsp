<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6453e79666e37b86e04aa132347f6cb1"></script>
    <div id="mapContainer" style="width:100%; height:100%;"></div>
    <script>
	const options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(35.8641294, 128.5942331), //지도의 중심좌표.
			level: 5 //지도의 레벨(확대, 축소 정도)
		};
	
		const map = new kakao.maps.Map(mapContainer, options);
		console.log(map.getCenter())
		
		function getRestaurantList() {
			
			axios.get('/restaurant/ajaxGetList').then.(function(res) {
				
			})
		}
	</script>
</div>
