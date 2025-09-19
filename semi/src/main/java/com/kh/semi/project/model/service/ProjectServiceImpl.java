package com.kh.semi.project.model.service;


import com.kh.semi.attachment.model.service.AttachmentServiceImpl;
import com.kh.semi.attachment.model.vo.Attachment;
import com.kh.semi.common.template.FilePath;
import com.kh.semi.common.template.MyFileRenamePolicy;
import com.kh.semi.employee.model.vo.Employee;
import com.kh.semi.project.model.dao.ProjectDao;
import com.kh.semi.project.model.vo.Project;
import com.kh.semi.project.model.vo.ProjectMember;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProjectServiceImpl implements ProjectService{
    @Autowired
    private ProjectDao pDao;
    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private AttachmentServiceImpl attService;

    @Override
    public ArrayList<Project> selectProjectList() {
        return pDao.selectProjectList(sqlSession);
    }

    @Override
    public int insertProject(Project p) {
        return pDao.insertProject(p, sqlSession);
    }

    @Override
    public Project selectProject(int pno) {
        return pDao.selectProject(pno, sqlSession);
    }

    @Override
    public ArrayList<Employee> listProjectMember(String myId) {
        return pDao.listProjectMember(sqlSession, myId);
    }

    @Transactional
    @Override
    public int insertProjectMember(Project p,  List<Map<String, String>> memberList, List<MultipartFile> upfiles, int attCategory) {

        int result = pDao.insertProject(p, sqlSession);
        System.out.println(p);
        if (result == 0) {
            return -1;  // 프로젝트 삽입 실패
        }

        if (upfiles  != null && !upfiles.isEmpty()) {
            File folder = new File(FilePath.UPLOAD_PATH);
            if (!folder.exists()) folder.mkdirs();
            for (MultipartFile file : upfiles) {
                if (file.isEmpty()) continue;
                String originName = file.getOriginalFilename();
                String changeName = new MyFileRenamePolicy().rename(originName);
                File dest = new File(FilePath.UPLOAD_PATH + changeName);
                try {
                    file.transferTo(dest);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
                Attachment att = new Attachment();
                att.setAttOrigin(originName);
                att.setAttChangeName(changeName);
                att.setAttFilePath(FilePath.URL_PATH);
                att.setAttCategory(attCategory);
                att.setRefNo(p.getPjtNo());
                int insertAttResult = attService.insertAttachment(att);

            }
        }

        int mPjtNo = p.getPjtNo();

        int memberResult = 0;
        for (Map<String, String> m : memberList) {
            String empName = m.get("name");
            // 1. empNo 조회
            Integer empNo = pDao.selectEmpNoByName(sqlSession, empName);
            if (empNo != null) {
                // 2. INSERT 실행
                Map<String, Object> params = new HashMap<>();
                params.put("mPjtNo", mPjtNo);
                params.put("empNo", empNo);
                System.out.println("mPjtNo: " + mPjtNo + ", empNo: " + empNo);
                memberResult += pDao.insertProjectMember(sqlSession, params);
            } else {
                // 로그 또는 예외 처리
                System.err.println("Employee not found: " + empName);
            }
        }



        return memberResult;
    }

    @Override
    public ArrayList<ProjectMember> selectProjectMember(int pno) {
        return pDao.selectProjectMember(sqlSession, pno);
    }

    @Override
    public ArrayList<Project> myProjectList(int myEmpNo) {
        return pDao.myProjectList(sqlSession, myEmpNo);
    }


}
