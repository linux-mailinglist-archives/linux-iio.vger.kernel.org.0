Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A4D1E57C9
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 08:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgE1Gle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 02:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgE1Gld (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 02:41:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED2C05BD1E;
        Wed, 27 May 2020 23:41:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m1so6705486pgk.1;
        Wed, 27 May 2020 23:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xzfk0QTgi6/ZS6UjMAM/WRlUJL7YMEP0oPEiXnwDjbc=;
        b=Sn8azLpFXaF2AP6cYyf0p77HYmglOgaM/ECgzm941DaMtj0xhXjau5A8SMRfZ2ings
         LKVnU0mEd0YtrhIoDaKJleOvGwAbcK4+fkGO+GiL4MKcB0s2Z4bj0cUmLNh0m8wbDY7U
         AuvFah1r8oOmsXqhA35H6w7w2d3pOf2SqetY81xLuHF0/BdiYOuwTIs3vvaFpWW/Vffu
         i0wio7A8hbSDpK0HIKiChfjiVZsY0QDO27CdVc6q1XZLiXq4OGnKTrZLNNwiIF9dR6+N
         QbQn84hiH5WychLloUx/sCfSJcS+cRbJ8Vvs6vKegQV7TkkgMU4UvmD8sdRa5ug7JtEM
         KixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xzfk0QTgi6/ZS6UjMAM/WRlUJL7YMEP0oPEiXnwDjbc=;
        b=c4pOp6xBfebzL+NDiUOuypn6oM1iBsl6TnmPKIKqvmwkXQFuNxEPiS8NIIU0r0gcoi
         jeyk0h2ue5svfy/y1y8LoWhF0mKsrBARoX98gUK4tfpx6tMF6pYa2BkYzOaPy3VVerBC
         ZMx9E6qBkXmvaXfJTf9w843PDWw43WRn11CUUEdMvRgTIBXUF7TycCX0iagUF30b7Vhb
         pKL9CYTGW8WuJZppYVai2PUyYXa5GqsthcVihnPNMdh6+RCzHcDLJGO9ZpuEKdvdrGZH
         quNm4lkwleg3zKIAQgDlnKcPnBvMJqq13NHEWIMjKxZo8gLIe5lrYqSF26Ky0ffV9WbF
         FtDg==
X-Gm-Message-State: AOAM5311ROEShqzd6WF3Qf8VjO/X4qM+UU5oiv74lzRHFvXoeSKsSmt9
        nCsm9i8ut2zmqokta7OG+W0=
X-Google-Smtp-Source: ABdhPJxkztDjS5/d3ynI5G5Qo4GmpJyAMlYAMeM3x//ALkvsFBDmNmB8aEiaOaRVHe3etmhKWs7BDw==
X-Received: by 2002:a63:7d1d:: with SMTP id y29mr1488884pgc.189.1590648092571;
        Wed, 27 May 2020 23:41:32 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id o11sm3736277pfd.195.2020.05.27.23.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:32 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Bijosh Thykkoottathil <bijosh.t@hotmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] iio: mma8452: Add missed iio_device_unregister() call in mma8452_probe()
Date:   Thu, 28 May 2020 14:41:21 +0800
Message-Id: <20200528064121.547001-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The function iio_device_register() was called in mma8452_probe().
But the function iio_device_unregister() was not called after
a call of the function mma8452_set_freefall_mode() failed.
Thus add the missed function call for one error case.

Fixes: 1a965d405fc6 ("drivers:iio:accel:mma8452: added cleanup provision in case of failure.")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Add fixes tag.
  - Modify description.

 drivers/iio/accel/mma8452.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 00e100fc845a..813bca7cfc3e 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1685,10 +1685,13 @@ static int mma8452_probe(struct i2c_client *client,
 
 	ret = mma8452_set_freefall_mode(data, false);
 	if (ret < 0)
-		goto buffer_cleanup;
+		goto unregister_device;
 
 	return 0;
 
+unregister_device:
+	iio_device_unregister(indio_dev);
+
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 
-- 
2.26.2

