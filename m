Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03185343BF7
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 09:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCVIlu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 04:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhCVIlo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 04:41:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6927C061756
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 01:41:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w18so18297574edc.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=del3Cil/BVXixQldsxjVF/c61sD3Z5HRB8VzAyqfUhA=;
        b=E+GgNAJRJ3nnvLVfV74QjgoXDvh4rGRHt5+NmDE1BetyeuWdjtJNDSs6xpHqmNC4Ra
         2eaq/UsPWGCJ86ojDp7S/RShq5zyt8Hg9TrdQaHns6WHnnFn7Auh3mcJeTb7S6RuoxS4
         4BJv1JWKE24smz8Nn5UskVFktF1NqBtAseySHbgjp7VT37ZtTOWnrLDFBvL8YW84zuBB
         jVgwM2jqWfKfjr1YB6GNLBX6exziRM0X0ydTy1I+FD/HKvt0d2yyFjNhTFNZetgrXQcd
         M3BFIH0fptYLS4zq9MVdsuRcsqBymy3HEUpiFvVRiHSIFRm2Zsi7apqcm1vqk0jPB00m
         RTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=del3Cil/BVXixQldsxjVF/c61sD3Z5HRB8VzAyqfUhA=;
        b=pLyuiJwIEX+g3WcZ7u26RhubhaQVUk52lBE5QaZU9Dc0YRUsRs3AXyBgNXwFZO28n5
         /5nWycOy+b5rZd1bRTwtl/WXScNr5Dz1WPw/MHNCULKgNBWRkt4f4sJedTd5OEzcjPK3
         ng7G1WmHq82zF4b49+6/cAjTZRAzVi2ByhhYqOIL2IfTpbqAxei/seBr0jXpuzuiHRMM
         4Foepk+0WrtvIb4OHbDAezvzdKvOxBVoQIqfRgH3ViYXKMdS33LrZ987QDLL//itsmI6
         i9bmR+0CiSYM6RRfykRFflWxfW4p85+pzXe8vTsrl9F4txfk3gG/KvnysGusopXmVeSA
         SHXQ==
X-Gm-Message-State: AOAM532DBz2ldOT2L6gjsLPE3VQl6GJn4qYCnQiSVYN3KA3n2GLZhV8x
        xC/0M5etk61SNHkSTot40R1swYjB/rTjrM/7
X-Google-Smtp-Source: ABdhPJxYpHESoVUdHSbDd4QqcXykHItoGACdNL3FpYSXmgEZrjP6EhlWSunoHRmEI9O7X5j2AtNnOQ==
X-Received: by 2002:a05:6402:8d7:: with SMTP id d23mr24810161edz.256.1616402501240;
        Mon, 22 Mar 2021 01:41:41 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id mc2sm9240019ejb.115.2021.03.22.01.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 01:41:40 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: buffer: return 0 for buffer getfd ioctl handler
Date:   Mon, 22 Mar 2021 10:41:35 +0200
Message-Id: <20210322084135.17536-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As Lars pointed out, we could either return the FD vs memcpy-ing it to the
userspace data object.

However, this comment exposed a bug. We should return 0 or negative from
these ioctl() handlers. Because an ioctl() handler can also return
IIO_IOCTL_UNHANDLED (which is positive 1), which means that the ioctl()
handler doesn't support this ioctl number. Positive 1 could also be a valid
FD number in some corner cases.

The reason we did this is to be able to differentiate between an error
code and an unsupported ioctl number; for unsupported ioctl numbers, the
main loop should keep going.

Maybe we should change this to a higher negative number, to avoid such
cases when/if we add more ioctl() handlers.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Fixes: f73f7f4da5818 ("iio: buffer: add ioctl() to support opening extra buffers for IIO device")
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index ee5aab9d4a23..d7a15c9bb0cd 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1442,7 +1442,7 @@ static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg
 		goto error_free_ib;
 	}
 
-	return fd;
+	return 0;
 
 error_free_ib:
 	kfree(ib);
-- 
2.30.2

