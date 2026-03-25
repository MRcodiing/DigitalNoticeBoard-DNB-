package file;


import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

public class DownlodeFile extends HttpServlet{

    public  final int BUFFER_SIZE=1024*1000;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fileName=req.getParameter("fn");
        String path= getServletContext().getRealPath("")+ "uploads" +File.separator+fileName;

        System.out.println(path);

        File file=new File(path);
        OutputStream os=null;
        FileInputStream fis=null;

        resp.setHeader("Content-Disposition",String.format("attachment;filename=\"%s\"", file.getName()));
        resp.setContentType("application/octet-stream");

        if(file.exists()){
            os=resp.getOutputStream();
            fis=new FileInputStream(file);


            byte[]  bf= new byte[BUFFER_SIZE];

            int byteRead=-1;

            while((byteRead=fis.read(bf))!=-1){
                os.write(bf,0,byteRead);

            }

        }else{
            System.out.print("file not downlode");
        }

    }
}
