Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46B737FE36
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 21:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhEMTh1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 15:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhEMThW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 15:37:22 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06859C061574
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 12:36:12 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id l19-20020a37f5130000b02902e3dc23dc92so20215995qkk.15
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2O58jXnETdEbs4jVdtA0T0Vt+DD9mkqY3jDs31OqI1U=;
        b=L5x5B79nG2yasENXeTN12F+UXiA4asq5ViYFWln7Wgad3Qkt8PMuW0BkX6fQT1iubG
         m9RbbydDyHxnzAJAJfxhxTv/Wv37BxU2F027eoJ/Otf2yzK1UlCglgzuHY/R/caTg7QO
         MkaiEaxFUk+D3r1/29ZVFB9ZL3LmyMHVew6pygLP8K/tlw4F7sWUWFAEaoE6c6GwgWj3
         ZAUVPawjvZsNk8frXZM0ti9Atnsvl1T1wcWQ1huhkVKmoXNCFnSZ8/rWjT1MNx0Y+EtH
         f1qN97pMU0vdzxIJ3eWXRTYCC+lodWI8DLV6bs5VWTHLxvGIyuM6jkuH7FFk/5DStlUT
         S7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2O58jXnETdEbs4jVdtA0T0Vt+DD9mkqY3jDs31OqI1U=;
        b=IYNJaBi2MGDZtryo7EZyJMd1SH+Yh38U7fMRsW4mcihQ8nNEzvOjo17kDIxV8otQVd
         SDTTbT7PITknisuB0Qt0xuUXaShgpannv04BNc56m0Ey+F8gwr74vPaii4fXaNULs05J
         gquCt1DEKYjyx6VcPRqF5elQZdlUocYYp5vEegO+7tp/+MuPCdi8U9C96Y4GNrD5MWJs
         ScyEXhpF0mr4Kdq2tXZpeDaT39pDbQFy4Wio+gRIHSxKN4t5mJ2CT+qUhirvIv4EOTBP
         VYEiJO/GmQJp1jKfixeVp+jPOnShehILnrZ/otEFgTo7SfsA3kAhyoeL+EhSMEvm5JhQ
         QcSw==
X-Gm-Message-State: AOAM532uyBQtzRL+6Wm+4HwTOQ6NyGmjuOWUD8MjaX4WZobT/chFz1GD
        iLueeqGI3P16c4zN8TW6EU6bxYdYKcPrlw==
X-Google-Smtp-Source: ABdhPJxNmOIByMOB6nwOsj8kvWrsLHtfRYpnAZL03VNkudsSypOoG1v/BHcAY8WJYP4Ng/S5PKoPTpK8/01asA==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a05:6214:951:: with SMTP id
 dn17mr42776333qvb.27.1620934571219; Thu, 13 May 2021 12:36:11 -0700 (PDT)
Date:   Thu, 13 May 2021 12:31:59 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-5-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 05/10] iio: Remove a cast in iio-test-format which is no
 longer required
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

KUnit's EXPECT macros no longer typecheck as stringently, so casting the
result of strcmp() is now unnecessary.

Signed-off-by: David Gow <davidgow@google.com>
---
This should be a no-op functionality wise, and while it depends on the
first couple of patches in this series, it's otherwise independent from
the others. I think this makes the test more readable, but if you
particularly dislike it, I'm happy to drop it.

 drivers/iio/test/iio-test-format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index 55a0cfe9181d..f1e951eddb43 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -8,7 +8,7 @@
 #include <linux/iio/iio.h>
 
 #define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val) do { \
-		KUNIT_EXPECT_EQ(_test, (int)strlen(_buf), _ret); \
+		KUNIT_EXPECT_EQ(_test, strlen(_buf), _ret); \
 		KUNIT_EXPECT_STREQ(_test, (_buf), (_val)); \
 	} while (0)
 
-- 
2.31.1.751.gd2f1c929bd-goog

