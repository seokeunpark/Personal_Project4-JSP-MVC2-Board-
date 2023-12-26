package com.example.jspmvc2.controller;

import com.example.jspmvc2.dao.MVCBoardDAO;
import com.example.jspmvc2.dto.MVCBoardDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "ViewController", value = "/mvcboard/view.do")
public class ViewController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MVCBoardDAO dao = new MVCBoardDAO();
        String idx = req.getParameter("idx");
        dao.updateVisitCount(idx);
        MVCBoardDTO dto = dao.selectView(idx); // idx에 해당되는 게 없다면 null 반환, 에러는 없음

        dto.setContent(dto.getContent().replaceAll("\r\n", "<br />"));

        String ext = null;
        String fileName = dto.getSfile();

        if (fileName != null) {
            ext = fileName.substring(fileName.lastIndexOf(".") + 1);
        }
        String[] mimeStr = {"png", "jpg", "gif", "jpeg"};
        List<String> mimeList = Arrays.asList(mimeStr);
        boolean isImage = false;
        if (mimeList.contains((ext))) {
            isImage = true;
        }

        req.setAttribute("dto", dto);
        req.setAttribute("isImage", isImage);
        req.getRequestDispatcher("/14MVCBoard/View.jsp").forward(req, resp);
    }
}
