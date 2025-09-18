package com.kh.semi.attachment.model.service;

import com.kh.semi.attachment.model.vo.Attachment;

import java.util.List;

public interface AttachmentService {
    int insertAttachment(List<Attachment> attachments);

    int insertAttachment(Attachment att);

    List<Attachment> selectAttachments(int refNo, int attCategory);

    int deleteAttachments(int refNo, int category);

    int deleteAttachmentByNo(int attNo);
    Attachment selectAttachmentByNo(int attNo);
}