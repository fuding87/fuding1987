
	var id_Check = false;
	var id_Check2 = false;
	var pass_Check = false;
	var nick_Check = false;
	
	//우편번호 api
	function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('address2').focus();
            }
        }).open();
    }
	
	function sendEmail() {
		// 이미 사용중인 메일은 메일 보내기 버튼 먹통으로
		$.ajax({
			type: "get",
			url: "../member/id_dup_check.jsp",
			data: ({id: $("#id").val()}),
			success: function(data) {
				if(jQuery.trim(data) == "false") {
					// 기존 코드를 안으로 넣음 오류 방지하기 위해서
					// 안에 안넣으니까나 return false 하고 나서 그대로 팝업창 띄우면서 실행되더라..
					var width = 430;
					var height = 200;
					var winL = (screen.width - width) / 2;
					var winT = (screen.height - height) / 2;
					var property = "width=" + width + "," + "height=" + height + "," 
									+ "left=" + winL + "," + "top=" + winT + " menubar=no";
					
					id_Check = false;
					window.open("../member/authMail.jsp?to=" + id.value, "인증 페이지", property);
					
				} else {
					return false;
				}
			}
		});
		
	}
	
	function checkPass() {
		if($("#pass").val() != "") {
			if($("#pass").val() != $("#pass2").val()) {
				$("#passCheck").css("color", "red");
				$("#passCheck").text("비밀번호가 다릅니다.");
				pass_Check = false;
			} else {
				$("#passCheck").css("color", "green");
				$("#passCheck").text("비밀번호가 동일합니다.");
				pass_Check = true;
			}
		} else {
			$("#passCheck").html("&nbsp;");
		}
	}
	
	function checkId() {
		if($("#id").val() == "") {
			$("#idCheck").css("color", "red");
			$("#idCheck").text("아이디를 입력하세요");
			id_Check2 = false;
			return;
		}
		
		$.ajax({
			type: "get",
			url: "../member/id_dup_check.jsp",
			data: ({id: $("#id").val()}),
			success: function(data) {
				alert(jQuery.trim(data));
				if(jQuery.trim(data) == "false") {
					$("#idCheck").css("color", "green");
					$("#idCheck").text("사용가능한 아이디입니다.");
					id_Check2 = true;
				} else {
					$("#idCheck").css("color", "red");
					$("#idCheck").text("이미 사용중인 아이디입니다.");
					$("#idCheck").readonly = "readonly";
					id_Check2 = false;
				}
			}
		});
	}
	
	function checkNick() {
		if($("#nick").val() == "") {
			$("#nickCheck").css("color", "red");
			$("#nickCheck").text("닉네임을 입력하세요");
			nick_Check = false;
			return;
		}
		$.ajax({
			type: "get",
			url: "../member/nick_dup_check.jsp",
			data: ({nick: $("#nick").val()}),
			success: function(data) {
				if(jQuery.trim(data) == "false") {
					$("#nickCheck").css("color", "green");
					$("#nickCheck").text("사용가능한 닉네임 입니다.");
					nick_Check = true;
				} else {
					$("#nickCheck").css("color", "red");
					$("#nickCheck").text("이미 사용중인 닉네임 입니다.");
					nick_Check = false;
				}
			}
		});
	}
	function checkForm() {
		if(!id_Check) {
			alert("이메일 인증이 완료되지 않았습니다. 이메일 인증후 다시 시도해주세요.");
			$("#id").focus();
			return false;
		}
		if(!id_Check2) {
			alert("아이디가 옳바르지 않거나 이미 사용중입니다.");
			$("#id").focus();
			return false;
		}
		
		if(!pass_Check) {
			alert("비밀번호가 동일하지 않습니다.");
			$("#pass").focus();
			return false;
		}
		
		if(!nick_Check) {
			alert("닉네임이 옳바르지 않거나 이미 사용중입니다.");
			$("#nick").focus();
			return false;
		}

		return true;
	}
