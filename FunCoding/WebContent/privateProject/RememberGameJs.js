// 게임 round
var round;
// col,row limit
var limit; 
// 실제 색칠할 limit
var countLimit;
// 문제 칸수
var maxCount;

var setIntervalVar;

//start 계속누르면 감점 시스템 도입, 어려운판 넘기면 고득점
var scoreVal = 0;
var interval = 0;
var maxScore = 0;

// score 감소 막기 위함, 자동으로 재시작은 score 감소 없다. 일부러 재시작하는것만 score 감소 있게, 몰라서 보는 거니깐
var passScoreRelease = false;

// 중복선택, marking방지를 위해 array에 담긴것 위주로 판단할것
var numArray = new Array();

var selectArray = new Array();

function initialFormSetting(r, l, c, m){
	
	round 		= r;
	limit 		= l;
	countLimit 	= c;
	maxCount 	= m;
	
	string = 	"";
	string += 	"<form>";
	string += 	"<table border='1' align='center'>" +
				"<tr><td>" +
				"<input type='text' id='title' value='Remember-Game Round " + round + "'+ readonly='readonly'  style='width:180px;' /></td>" +
				"<td><input type='button' id='start' value='Start' onclick='startGame(" + maxCount + ");' /></td></tr></table><br/>" +
				"<table border='1' align='center'>" +
				"<tr><td><input type='text' id='Score' value='Score' readonly='readonly' style='width:40px;' /></td>" +
				"<td><input type='text' id='ScoreValue' value='" + scoreVal + "' readonly='readonly' style='width:80px;' />" +
				"<td><input type='text' id='MaxScore' value='MaxScore' readonly='readonly' style='width:70px;' /></td>" +
				"<td><input type='text' id='MaxScoreValue' value='" + maxScore + "' readonly='readonly' style='width:80px;' />" +
				"</td></tr>" +
				"</table><br/>";
	
	string += 	"<table border='1' align='center'> ";

	var count = 1; 
	for (var i=1; i<=limit; i++){
		var k=1;
		string += "<tr>";
		for(var k=1; k<=limit; k++){
				string += "<td>";
				string += "<input type='button' style='background-color: yellow; width:75px; height:75px;' id='btn" + count + "' onclick='markingColorDir(" + count + ");'/>"
				count++;
				string += "</td>";
		}
		string += "</tr>";
		
	}
	
	string += "</table>";
	string += "</form>";
	
	document.write(string);
	
}

// initialFormSetting 함수 정의 밑에서 실행
initialFormSetting(1,4,16, 4);

function unmarkingColor(){
	for(var i=1; i<=(countLimit); i++){
		var id = "btn" + i;
		document.getElementById(id).style.backgroundColor="yellow";
	}
	
	clearInterval(setIntervalVar);

	// 색 안없어지기전에 눌러서 꼼수 부릴수가 있다. 
	selectArray = new Array();
	
}

function markingColorDir(selNum){

	if (numArray.length==0){
		alert("Start 버튼을 누르세요")
		return;
	} else {
		markingColor(selNum);
	}
	
	var clickCheck = false;
	// numArray 에 있는지 체크 없으면 GAME END 표기 띄워주고 
	for (var i=0; i<numArray.length; i++){
		if (selNum == numArray[i]) {
			// 선택한게 array 에 있으면 true
			clickCheck = true;
			break;
		}
	}
	if (!clickCheck){
		alert("잘못선택했습니다. \nGAME END" + "\n틀려서 " + interval/2 + "점 감점" + "\n연결시 " + interval/2 + "점 감점");
		// 틀렸으니 감점
		downScore();
		stopGame();
		if (!confirm("연결하시겠습니까? \n취소하면 1Round 부터")) {
			// 취소함
			location.reload();
		}
		return;
	}

	
	// array 에 selNum 추가
	// 이미 추가된거면 return
	var checkAdd = true;
	for (var w=0; w<selectArray.length; w++){
		if (selNum == selectArray[w]){
			// 하나라도 있으면 false
			checkAdd = false;
			break;
		}
	}
	if (checkAdd){
		selectArray[selectArray.length] = selNum;	
	} else {
		return 
	}
	
	// return false 되지 않고 numArray.length 와 같이 동일해진다면
	if (selectArray.length==numArray.length){
		if (confirm("똑똑하군요 Clear 했습니다. \n다음판으로 가실까요?")==true){
			// reGame
			
			if (round<5){
				limit = 4;
				interval = 100;
			} else if(round<10) {
				limit = 5;
				interval = 200;
			} else if(round<15) {
				limit = 6;
				interval = 300;
			} else if(round<20) {
				limit = 7;
				interval = 400;
			} else if(round<25) {
				limit = 8;
				interval = 500;
			} else {
				alert("모든 Stage를 Clear 하셨습니다.");
			} 
			countLimit = limit*limit;

			tmpScore = document.getElementById("ScoreValue").value;
			scoreVal = parseInt(tmpScore) + interval;
			if (maxScore < scoreVal){
				maxScore = scoreVal;
			}
			// body 값 초기화, 변수값들은 round/maxScore/interval 변수등은 살려야 해서 
			// body 값 초기화로 진행
			document.body.innerHTML="";
			
			// 난이도 업그레이드 시켜서 body tag 다시 작성
			initialFormSetting(++round,limit,countLimit,++maxCount);

			passScoreRelease = true;
			startGame(maxCount);
			passScoreRelease = false;
		}
	}
	
}

function markingColor(selNum){
	var id = "btn" + selNum;
	document.getElementById(id).style.backgroundColor="red";
}

function startGame(maxCount){
	
	// 초기화
	stopGame();
	// 연결하면 감점
	downScore();
	
	// 랜덤 중복 체크
	for (var k=0; k<maxCount; k++){
		var Rnum = Math.floor(Math.random()*(countLimit)) + 1;
		numArray[k] = Rnum;
		for (var i=0; i<k; i++){
			if (numArray[k]==numArray[i]){
				k--;
				break;
			}				
		}
	}
	
	// array 에 마킹해줄것
	for (var t=0; t<numArray.length; t++){
		markingColor(numArray[t]);
	}
	
	// n초후에 전부 unmarking 해줄것 // 이미 아래까지 메소드를 한번 쫙읽는듯 
/*	// 색 안없어지기전에 눌러서 꼼수 부릴수가 있다. 
	selectArray = new Array();*/ //->이부분 인식을 못하네
	setIntervalVar = setInterval("unmarkingColor();",2000)
	
}

function stopGame(){
	unmarkingColor();
	numArray 	= new Array();
	selectArray = new Array();
}

function downScore(){
	// 0점 이상일때만 획득점수의 50% 감점 (실패해서 다시읽는 거니깐)
	if (document.getElementById("ScoreValue").value > 0 && !passScoreRelease){
		document.getElementById("ScoreValue").value -= (interval / 2);
	}
}

