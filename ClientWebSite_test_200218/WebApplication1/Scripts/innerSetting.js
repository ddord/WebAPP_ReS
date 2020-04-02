

function editorSetting(elemID) {
    $("#" + elemID).kendoEditor({
        tools: [
            {
                name: "bold",
                tooltip: "굵게"
            }, {
                name: "italic",
                tooltip: "기울임꼴"
            }, {
                name: "underline",
                tooltip: "밑줄"
            }, {
                name: "fontName",
                items: [{
                    text: "기본",
                    value: "NotoSans-Regular",
                }, {
                    text: "맑은 고딕",
                    value: "Malgun Gothic",
                }, {
                    text: "궁서",
                    value: "Gungsuh",
                }, {
                    text: "궁서체",
                    value: "GungsuhChe",
                }, {
                    text: "굴림",
                    value: "Gulim",
                }, {
                    text: "굴림체",
                    value: "GulimChe",
                }, {
                    text: "바탕",
                    value: "Batang",
                }, {
                    text: "바탕체",
                    value: "BatangChe",
                }, {
                    text: "돋움",
                    value: "Dotum",
                }, {
                    text: "돋움체",
                    value: "DotumChe",
                }, {
                    text: "Arial",
                    value: "Arial,Helvetica,sans-serif"
                }, {
                    text: "Courier New",
                    value: "'Courier New',Courier,monospace"
                }, {
                    text: "Georgia",
                    value: "Georgia,serif"
                }, {
                    text: "Impact",
                    value: "Impact,Charcoal,sans-serif"
                }, {
                    text: "Lucida Console",
                    value: "'Lucida Console',Monaco,monospace"
                }, {
                    text: "Tahoma",
                    value: "Tahoma,Geneva,sans-serif"
                }, {
                    text: "Times New Roman",
                    value: "'Times New Roman',Times,serif"
                }, {
                    text: "Trebuchet MS",
                    value: "'Trebuchet MS',Helvetica,sans-serif"
                }, {
                    text: "Verdana",
                    value: "Verdana,Geneva,sans-serif"
                }],
                tooltip: "글꼴"
            }, {
                name: "fontSize",
                tooltip: "글꼴 크기"
            }, {
                name: "formatting",
                tooltip: "글꼴 형식"
            }, {
                name: "foreColor",
                tooltip: "글꼴 색"
            }, {
                name: "backColor",
                tooltip: "음영"
            }, {
                name: "justifyLeft",
                tooltip: "왼쪽 맞춤"
            }, {
                name: "justifyCenter",
                tooltip: "가운데 맞춤"
            }, {
                name: "justifyRight",
                tooltip: "오른쪽 맞춤"
            }, {
                name: "justifyFull",
                tooltip: "균등 분할"
            }, {
                name: "viewHtml",
                tooltip: "HTML 수정"
            }, {
                name: "createTable",
                tooltip: "표 삽입"
            }, {
                name: "addColumnLeft",
                tooltip: "왼쪽에 열 추가"
            }, {
                name: "addColumnRight",
                tooltip: "오른쪽에 열 추가"
            }, {
                name: "addRowAbove",
                tooltip: "위에 행 추가"
            }, {
                name: "addRowBelow",
                tooltip: "아래에 행 추가"
            }, {
                name: "deleteRow",
                tooltip: "행 삭제"
            }, {
                name: "deleteColumn",
                tooltip: "열 삭제"
            }, {
                name: "image-export",
                tooltip: "이미지 삽입",
                exec: function (e) {
                    if (isEng != "T") {
                        $('#txtTempFile').trigger('click');
                    } else {
                        $('#txtTempFile_Eng').trigger('click');
                    }
                }
            }
        ],
        stylesheets: [
            "/Content/bootstrap.css",
            "/Content/Detail-site.css"
        ]
    });
}