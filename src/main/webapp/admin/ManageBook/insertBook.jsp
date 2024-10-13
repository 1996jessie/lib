<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 등록</title>
    <%@include file="../../top.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var use;
        var bookCheck = false;


        $('#bookDuplicate').click(function(){
            bookCheck = true;
            $.ajax({
                url : "insertBookCheck.jsp",
                data : { 
                    btitle : $('input[name = btitle]').val(),
                    bauthor : $('input[name = bauthor]').val()
                },
                success : function(data) {
                    alert("data : " + data);
                    if($('input[name = btitle]').val() == "") {
                        use = "no btitle";
                    } else if($('input[name = bauthor]').val() == "") {
                        use = "no bauthor";
                    } else if($.trim(data) == "exist") {
                        use = "cannot insert";
                    } else if($.trim(data) == "not exist") {
                        use = "can insert";
                    }
                    alert("use : " + use);
                }
            }); // ajax
        }); // bookDuplicate click

        $('input[name = btitle]').keydown(function(){
            bookCheck = false;
            use = "";            
        });//keydown

        $('input[name = bauthor]').keydown(function(){
            bookCheck = false;
            use = "";            
        });//keydown

        $('input[type = submit]').click(function(){
            if(use == "cannot insert"){
                alert("이미 있는 도서입니다.");
                return false;
            } else if(use == "no btitle"){
                alert("도서명을 입력하세요");
                return false;
            } else if(use == "no bauthor") {
                alert("저자를 입력하세요");
                return false;
            } else if(bookCheck == false){
                alert("중복 체크를 먼저 하세요");
                return false;
            } else if($('select[name = bcategory]').val() == -1) {
                alert("카테고리를 선택하세요");
                return false;
            } else if($('select[name = aaaa]').val() == 0) {
                alert("세부 카테고리를 선택하세요");
                return false;
            } else if($('input[name = bpublisher]').val() == "") {
                alert("출판사를 입력하세요");
                return false;
            } else if($('select[name = bpubyear]').val() == "") {
                alert("출간년도를 선택하세요");
                return false;
            } else if($('input[name = bbuydate]').val() == "") {
                alert("구입일을 입력하세요");
                return false;
            } else if($('input[name = bprice]').val() == "") {
                alert("도서 가격을 입력하세요");
                return false;
            }
        }); // submit click

        // 대분류 선택에 따라 소분류 동적으로 업데이트
        $('select[name="bcategory"]').change(function() {
        	//alert("5");
        	$('#scategory').val(0);
            var selectedCategory = $(this).val();
            var specificOptions = [
                [], // 0번 인덱스는 사용하지 않으므로 빈 배열
                ["---","도서학","문헌정보학","백과사전","강연집","일반연속간행물","일반 학회","신문","일반 전집","향토자료"], // 총류
                ["---","형이상학", "인식론", "철학의세계","경학","동양철학","서양철학","논리학","심리학","윤리학"], // 철학
                ["---","비교종교학", "불교", "기독교","도교","천도교","없음", "힌두교","이슬람교","기타 제종교"], // 종교
                ["---","통계학", "경제학", "사회학","정치학","행정학","법학","교육학","풍속","국방"], // 사회과학
                ["---","수학", "물리학", "화학","천문학","지학","광물학","생명과학","식물학","동물학"], // 자연과학
                ["---","의학", "농업", "공학","건축공학","기계공학","전기공학","화학공학","제조업","생활과학"], // 기술과학
                ["---","건축술", "조각및조형미술", "공예","서예","회화","사진예술","음악","공연예술","오락"], // 예술
                ["---","한국어", "중국어", "일본어","영어","독일어","프랑스어","스페인어","이탈리아어","기타제어"], // 언어
                ["---","한국문학","중국문학","일본문학","영미문학","독일문학","프랑스문학","스페인및포르투갈문학","이탈리아문학","기타제문학"], // 문학
                ["---","아시아", "유럽", "아프리카","북아메리카","남아메리카","오세아니아","양극지방","지리","전기"] // 역사
            ];
            var specificValue = [0,10,20,30,40,50,60,70,80,90];
            var $specificSelect = $('select[name="aaaa"]');
            $specificSelect.empty(); // 기존 옵션 제거

            if (selectedCategory != '---') {
                var specificOptionsArray = specificOptions[selectedCategory / 100 + 1];
                for (var i = 0; i < specificOptionsArray.length; i++) {
                    $specificSelect.append($('<option>', {
                        value: specificValue[i], // 값 설정
                        text: specificOptionsArray[i]
                    }));   
                }     
            }
        });
        $('select[name="aaaa"]').change(function() {
            var selectedscategory = $(this).val();
            $('#scategory').val(selectedscategory);
        });
        
    });
</script>
    <style>
        /* CSS 스타일 */
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 0 auto;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        input[type="text"], input[type="file"], input[type="date"], select {
            width: 70%; /* 전체 너비의 70%로 설정 */
            padding: 8px;
            box-sizing: border-box;
        }
        input[type="button"] {
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            margin-top: 8px; /* 도서 중복 버튼의 상단 여백 추가 */
        }
        input[type="button"]:hover {
            background-color: #45a049;
        }
        input[type="submit"], input[type="reset"], input[type="button"] {
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            margin-right: 10px;
        }
        input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <%-- Java 코드 --%>
    <% 
        int i;
        String[] bcategory = {"---","총류","철학","종교","사회과학","자연과학","기술과학","예술","언어","문학","역사"};
        int[] cnum = {-1, 0, 100, 200, 300, 400, 500, 600, 700, 800, 900};
    %>

    <%-- HTML 폼 --%>
    <form action="insertBookProc.jsp" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <th>도서명</th>
                <td><input type="text" name="btitle"></td>
            </tr>

            <tr>
                <th>저자</th>
                <td>
                    <input type="text" name="bauthor">
                    <input type="button" id="bookDuplicate" value="도서 중복">
                </td>
            </tr>   

            <tr>
                <th>대분류</th>
                <td>
                    <select name="bcategory">
                        <% for(i=0; i<bcategory.length; i++) { %>
                            <option value="<%= cnum[i] %>"><%= bcategory[i] %></option>
                        <% } %>
                    </select>
                </td>
            </tr>

			<tr>
			    <th>소분류</th>
			    <td>
			        <select name="aaaa" id="aaaa">
			            <option value="">---</option>
			        </select>
			        <input type="hidden" name="scategory" id="scategory">
			    </td>               
			</tr>

            <tr>
				<th>출판사</th>
				<td><input type="text" name="bpublisher"></td>
			</tr>	
				
			<tr>
				<th>도서 이미지</th>
				<td><input type="file" name="bimage"></td>
			</tr>	
				
			<tr>
				<th>출간년도</th>
				<td>
				    <select name="bpubyear">
				        <% for(i=2024;i>=1970;i--){ %>
				            <option value="<%= i %>"><%= i %></option>
				        <% } %>
				    </select> 년
				</td>
			</tr>	
				
			<tr>
				<th>구입일</th>
				<td><input type="date" name="bbuydate"></td>
			</tr>	
					
			<tr>
				<th>도서 가격</th>
				<td><input type="text" name="bprice"></td>
			</tr>
			
			<tr>
				<td colspan="2">
					<input type="submit" value="도서 등록">
					<input type="reset" value="취소">
					<input type="button" value="돌아가기">
				</td>
			</tr>
		</table>
    </form>
</body>
</html>
