package com.kh.semi.attachment.model.service;

import com.kh.semi.attachment.model.dao.AttachmentDao;
import com.kh.semi.attachment.model.vo.Attachment;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AttachmentServiceImpl implements AttachmentService{
    @Autowired
    private AttachmentDao atDao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int insertAttachment(List<Attachment> attachments) {
        int result = 0;
        for (Attachment att : attachments) {
            result += atDao.insertAttachment(sqlSession, att);
        }
        return result;
    }

    @Override
    public int insertAttachment(Attachment att) {
        return atDao.insertAttachment(sqlSession, att);
    }

    @Override
    public List<Attachment> selectAttachments(int refNo, int attCategory) {
        Map<String, Object> param = new HashMap<>();
        param.put("refNo", refNo);
        param.put("attCategory", attCategory);
        return atDao.selectAttachments(sqlSession, param);
    }

    @Override
    public int deleteAttachments(int refNo, int category) {
        return atDao.deleteAttachments(sqlSession, refNo, category);
    }

    @Override
    public int deleteAttachmentByNo(int attNo) {
        return atDao.deleteAttachmentByNo(sqlSession, attNo);
    }

    @Override
    public Attachment selectAttachmentByNo(int attNo) {
        return atDao.selectAttachmentByNo(sqlSession, attNo);
    }


}