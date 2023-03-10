package com.mycom.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class FileDownloadController {
   
   //파일저장경로
     //private static final String REPO_PATH = "C:\\spring\\article_repo";
     private static final String REPO_PATH = "C:\\spring\\event_image_repo";
   
   
   //result.jsp문서에서
   //<img src="${cPath}/download?fileName=${fileName}&articleNo=글번호"/>
     //@RequestParam("fileName") String fileName : 다운로드할 파일명을 전달받기
     // @RequestParam("articleNo") String articleNo : 글번호
   @RequestMapping("/download")
   public void download(@RequestParam("fileName") String fileName,
                   @RequestParam("event_id") String event_id,
            HttpServletResponse response) throws Exception {

         System.out.println("1번째 download");
         
         OutputStream out = response.getOutputStream();
         //이미지저장위치에 글번호별로 폴더생성하여 다운로드할 파일을 저장
         String downFile = REPO_PATH + "\\" + event_id + "\\" + fileName;
         File file = new File(downFile);//다운로드할 파일객체생성
         
         //response.setHeader()  응답헤더정보 설정
         //Cache-Control   HTTP 1.1 버전에서 지원하는 헤더로서, 이 헤더의 값을 "no-cache"로 지정하면 웹 브라우저는 응답 결과를 캐시하지 않는다.
         /*캐시란?-브라우저(클라이언트)가 저장해 놓은 데이터
         -웹 브라우저가 WAS에 같은 jsp파일을 2번 이상 요청할 때 불필요한 응답 요청을 방지하기 위해 사용한다.
         -웹 브라우저의 응답속도 향상되는 효과가 있다.*/
         response.setHeader("Cache-Control", "no-cache");
         response.addHeader("Content-disposition", "attachment; fileName=" + fileName);//Content-Disposition을 통해 파일명을 설정
         
         //버퍼를 이용하여   파일정보를     한 번에 8byte씩  읽어들이고 
         FileInputStream in = new FileInputStream(file);
         byte[] buffer = new byte[1024 * 8];
         while (true) {
         int count = in.read(buffer); 
         if (count == -1) //더 이상 읽어들일 것이 없다면
         break; //읽어들이는 것을 멈추어라
         out.write(buffer, 0, count); //읽은 내용 브라우저에 전송하기(-> 웹브라우저에 출력됨. 여기에서는 result.jsp문서에 출력됨)
         }
         
         in.close();//입력스트림닫기
         out.close();//출력스트림닫기
         }
   /*여기에서는 main.jsp에서
   <img width="121" height="154" 
				src="${conPath}/thumbnails?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">*/
   
   //썸네일이미지로 생성 및 출력 => 다수이미지를 사용한 웹페이제에서 아용하면 이미지가 신속하게 표시될 수 있다
   @RequestMapping("/download2")
   public void download2(@RequestParam("imageFileName") String imageFileName,
            HttpServletResponse response) throws Exception {

         System.out.println("2번째 download");
         
         OutputStream out = response.getOutputStream();
         String filePath = REPO_PATH + "\\" + imageFileName;
         
         File image = new File(filePath);//다운로드할 파일객체생성
         
         //thumbnail용 이미지 생성
         // 예시 /app/download2?imageFileName=1.png
         // C:\spring\repo\thumbnail
         int lastIndex = imageFileName.lastIndexOf("."); //.의 인덱스번호
          String fileName = imageFileName.substring(0, lastIndex); //substringsubstring(추출시작인덱스번호,추출인덱스번호-1);
         File thumbnail = new File(REPO_PATH+"\\thumbnail\\"+fileName+".png");
         if(image.exists()) {
            thumbnail.getParentFile().mkdirs();
            //가로세로size를 50px인 png썸네일이미지를 생성
            Thumbnails.of(image).size(50,50).outputFormat("png").toFile(thumbnail);
         }
         
         
         //response.setHeader()  응답헤더정보 설정
         //Cache-Control   HTTP 1.1 버전에서 지원하는 헤더로서, 이 헤더의 값을 "no-cache"로 지정하면 웹 브라우저는 응답 결과를 캐시하지 않는다.
         /*캐시란?-브라우저(클라이언트)가 저장해 놓은 데이터
         -웹 브라우저가 WAS에 같은 jsp파일을 2번 이상 요청할 때 불필요한 응답 요청을 방지하기 위해 사용한다.
         -웹 브라우저의 응답속도 향상되는 효과가 있다.*/
         response.setHeader("Cache-Control", "no-cache");
         response.addHeader("Content-disposition", "attachment; fileName=" + imageFileName);//Content-Disposition을 통해 파일명을 설정
         
         
         //버퍼를 이용하여   파일정보를     한 번에 8byte씩  읽어들이고 
         FileInputStream in = new FileInputStream(thumbnail);
         byte[] buffer = new byte[1024 * 8];
         while (true) {
         int count = in.read(buffer); 
         if (count == -1) //더 이상 읽어들일 것이 없다면
         break; //읽어들이는 것을 멈추어라
         out.write(buffer, 0, count); //읽은 내용 브라우저에 전송하기(-> 웹브라우저에 출력됨. 여기에서는 result.jsp문서에 출력됨)
         }
         
         in.close();//입력스트림닫기
         out.close();//출력스트림닫기
         }

   
   //썸네일이미지로 생성 및 출력 => 다수이미지를 사용한 웹페이제에서 아용하면 이미지가 신속하게 표시될 수 있다
   @RequestMapping("/thumbnails")
   public void thumbnails(@RequestParam("fileName") String imageFileName,
                    //@RequestParam("articleNo") String articleNo,
		   			@RequestParam("event_id") String event_id,
               HttpServletResponse response) throws Exception {

            System.out.println("3번째 download");
            
            OutputStream out = response.getOutputStream();
            //이미지저장위치에 상품id(글번호)별로 폴더생성하여 다운로드할 파일을 저장
            //String filePath = REPO_PATH + "\\" + articleNo + "\\" + imageFileName;
            String filePath = REPO_PATH + "\\" + event_id + "\\" + imageFileName;
         
         File image = new File(filePath);//다운로드할 파일객체생성
         
         //thumbnail용 이미지 출력
         if(image.exists()) {
            //가로세로size를 지정하여 png썸네일이미지를 생성
            Thumbnails.of(image).size(121,154).outputFormat("png").toOutputStream(out);
         }else {
            return;
         }
         
         
         //response.setHeader()  응답헤더정보 설정
         //Cache-Control   HTTP 1.1 버전에서 지원하는 헤더로서, 이 헤더의 값을 "no-cache"로 지정하면 웹 브라우저는 응답 결과를 캐시하지 않는다.
         /*캐시란?-브라우저(클라이언트)가 저장해 놓은 데이터
         -웹 브라우저가 WAS에 같은 jsp파일을 2번 이상 요청할 때 불필요한 응답 요청을 방지하기 위해 사용한다.
         -웹 브라우저의 응답속도 향상되는 효과가 있다.*/
         response.setHeader("Cache-Control", "no-cache");
         response.addHeader("Content-disposition", "attachment; fileName=" + imageFileName);//Content-Disposition을 통해 파일명을 설정
         
         
         
         byte[] buffer = new byte[1024 * 8];
         out.write(buffer); //읽은 내용 브라우저에 전송하기(-> 웹브라우저에 출력됨. 여기에서는 result.jsp문서에 출력됨)
         out.close();//출력스트림닫기
         }

}