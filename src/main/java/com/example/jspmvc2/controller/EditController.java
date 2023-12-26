package com.example.jspmvc2.controller;

import com.example.jspmvc2.dao.MVCBoardDAO;
import com.example.jspmvc2.dto.MVCBoardDTO;
import com.example.jspmvc2.util.FileUtil;
import com.example.jspmvc2.util.JSFunction;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(value = "/mvcboard/edit.do")
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 1,
        maxRequestSize = 1024 * 1024 * 20
)
public class EditController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idx = request.getParameter("idx");
        MVCBoardDAO dao = new MVCBoardDAO();
        MVCBoardDTO dto = dao.selectView(idx);
        request.setAttribute("dto", dto);
        request.getRequestDispatcher(request.getContextPath() + "/14MVCBoard/Edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String saveDirectory = request.getServletContext().getRealPath("/Uploads");

        String originalFileName = "";
        try {
            originalFileName = FileUtil.uploadFile(request, saveDirectory);
        } catch (Exception e) {
            System.out.println("update 중 파일 업로드 오류 발생");
            JSFunction.alertBack(response, "board 수정 중 파일 업로드 오류입니다.");
            return;
        }

        String idx = request.getParameter("idx");
        String prevOfile = request.getParameter("prevOfile");
        String prevSfile = request.getParameter("prevSfile");

        String name = request.getParameter("name");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        HttpSession session = request.getSession();
        String pass = (String) session.getAttribute("pass");

        MVCBoardDTO dto = new MVCBoardDTO();
        dto.setIdx(idx);
        dto.setName(name);
        dto.setTitle(title);
        dto.setContent(content);
        dto.setPass(pass);

        if (originalFileName != "" && !originalFileName.equals("") && !originalFileName.isEmpty()) {
            // isEmpty()만 하면 되긴 하는데...
            String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
            dto.setOfile(originalFileName);
            dto.setSfile(savedFileName);
            FileUtil.deleteFile(request, "/Uploads", prevSfile);
        } else {
            dto.setOfile(prevOfile);
            dto.setSfile(prevSfile);
        }

        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.updatePost(dto);

        if (result == 1) {
            session.removeAttribute("pass");
            response.sendRedirect(request.getContextPath() + "/mvcboard/view.do?idx=" + idx);
        } else {
            JSFunction.alertLocation(response, "비밀번호가 일치하지 않아서 업데이트할 수 없습니다.",
                    request.getContextPath() + "/mvcboard/view.do?idx=" + idx);
        }
    }
}
