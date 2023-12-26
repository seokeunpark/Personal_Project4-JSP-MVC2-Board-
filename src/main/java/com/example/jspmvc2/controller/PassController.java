package com.example.jspmvc2.controller;

import com.example.jspmvc2.dao.MVCBoardDAO;
import com.example.jspmvc2.dto.MVCBoardDTO;
import com.example.jspmvc2.mybatis.mapper.MVCBoardMapper;
import com.example.jspmvc2.util.Encrypt;
import com.example.jspmvc2.util.FileUtil;
import com.example.jspmvc2.util.JSFunction;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "PassController", value = "/mvcboard/pass.do")
public class PassController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("mode", request.getParameter("mode"));
        request.getRequestDispatcher(request.getContextPath() + "/14MVCBoard/Pass.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Encrypt encrypt = new Encrypt();
        String idx = req.getParameter("idx");
        String mode = req.getParameter("mode");
        String pass = encrypt.getEncrypt(req.getParameter("pass"));

        MVCBoardDAO dao = new MVCBoardDAO();
        boolean confirmed = dao.confirmPassword(pass, idx);

        if (confirmed) {
            if (mode.equals("edit")) {
                HttpSession session = req.getSession();
                session.setAttribute("pass", pass);
                resp.sendRedirect(req.getContextPath() + "/mvcboard/edit.do?idx=" + idx);
            } else if (mode.equals("delete")) {
                MVCBoardDTO dto = dao.selectView(idx);
                int result = dao.deletePost(idx);
                if (result == 1) {
                    String saveFileName = dto.getSfile();
                    FileUtil.deleteFile(req, "/Uploads", saveFileName);
                }
                JSFunction.alertLocation(resp, "삭제되었습니다.", req.getContextPath() + "/mvcboard/list.do");
            }
        } else {
            JSFunction.alertBack(resp, "비밀번호가 일치하지 않습니다.");
        }
    }
}
