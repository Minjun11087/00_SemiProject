package com.kh.semi.attachment.model.dao;

import com.kh.semi.attachment.model.vo.Attachment;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class AttachmentDao {
    public int insertAttachment(SqlSessionTemplate sqlSession, Attachment att) {
        return sqlSession.insert("attachmentMapper.insertAttachment", att);
    }

    public List<Attachment> selectAttachments(SqlSessionTemplate sqlSession, Map<String, Object> param) {
        return sqlSession.selectList("attachmentMapper.selectAttachments", param);
    }
    public int deleteAttachments(SqlSessionTemplate sqlSession, int refNo, int category) {
        Map<String, Object> param = new HashMap<>();
        param.put("refNo", refNo);
        param.put("category", category);
        return sqlSession.delete("attachmentMapper.deleteAttachments", param);
    }
    public int deleteAttachmentByNo(SqlSessionTemplate sqlSession, int attNo) {
        return sqlSession.delete("attachmentMapper.deleteAttachmentByNo", attNo);
    }
    public Attachment selectAttachmentByNo(SqlSessionTemplate sqlSession, int attNo) {
        return sqlSession.selectOne("attachmentMapper.selectAttachmentByNo", attNo);
    }

}