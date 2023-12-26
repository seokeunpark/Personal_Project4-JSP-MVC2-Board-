package com.example.jspmvc2.controller;

import com.example.jspmvc2.dao.MVCBoardDAO;
import com.example.jspmvc2.dto.MVCBoardDTO;
import com.example.jspmvc2.paging.Criteria;
import com.example.jspmvc2.paging.PageMaker;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ListController", value = "/mvcboard/list.do")
public class ListController extends HttpServlet {

    //private MVCBoardDAO dao = new MVCBoardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MVCBoardDAO dao = new MVCBoardDAO();
        Map<String, Object> map = new HashMap<>();
        String searchField = request.getParameter("searchField");
        String searchWord = request.getParameter("searchWord");

        System.out.println("searchWord = " + searchWord);
        System.out.println("searchField = " + searchField);
        if (searchWord != null && !searchWord.trim().equals("")) {
            map.put("searchField", searchField);
            map.put("searchWord", searchWord);
        }
        int totalCount = dao.selectCount(map);

        // 페이징
        String pageNum = request.getParameter("pageNum");
        Criteria criteria = new Criteria();
        int pageNumInt = 1;
        if (pageNum != null && !pageNum.equals("")) {
            try {
                pageNumInt = Integer.parseInt(pageNum.trim());
            } catch (Exception e) {
                System.out.println("숫자로 변환할 수 없는 pageNum");
                // default로 1을 준다.
            }
        }
        criteria.setPageNum(pageNumInt);

        map.put("pageNum", (criteria.getPageNum() - 1) * 10);
        List<MVCBoardDTO> boardLists = dao.selectListPageWithPaging(map);

        System.out.println("boardLists is null? = " + boardLists);
        System.out.println("boardLists.size() = " + boardLists != null ? boardLists.size() : "null이기 때문에 size X");
        /*
        * boardLists is null? = []
        * size => 0
        * */

        PageMaker pageMaker = new PageMaker(criteria, totalCount);
        request.setAttribute("pageMaker", pageMaker);
        request.setAttribute("boardLists", boardLists);
        map.remove("pageNum");
        request.setAttribute("map", map);
        request.getRequestDispatcher("/14MVCBoard/List.jsp").forward(request, response);
    }
}
