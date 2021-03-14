Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1233A73A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 18:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCNR5i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhCNR5i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Mar 2021 13:57:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5AC061574;
        Sun, 14 Mar 2021 10:57:37 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z5so14192829plg.3;
        Sun, 14 Mar 2021 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tRe63mOXEOy6zxRX1QNNRKDXtHVES7uBXxIwluuNQG8=;
        b=SS0baeye3CdXT4p0PYnRzOQAfhfM0O3kOh/QNfVnl/F0zHq/HEpVxK2Wk5erpMt7Cg
         WcjF67M4exWEDkPEFPhUthpF2ZBZdi4HU/GfrZ1BYKrm5lvcFDRwY8g5NqO5Xe0nFSCf
         1GTuG6w+dNbZNtgrRtLHFi1sJe7iFjKvGCIbR4V9N8/a+lfXNgMYIP/VlJZXlD4A3cGQ
         nv0I9/OtvIuYwXJb3RducmUmMQvAuFWc7oduearsCnWXUCsIWsaL1YkmqfzfInEhwEYm
         64UbYRBbDzLhn3JDcTFdCphbTw3Ne/CnMCEanO8CROJJJcjJVcBAkpOg+xzP0drPIrDV
         lGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tRe63mOXEOy6zxRX1QNNRKDXtHVES7uBXxIwluuNQG8=;
        b=aZLsrSd4V+g9B1HbTVWv9Im3azwe9eRG8M8o3m+3HOOiS7WZuSZwXXluHHqZPKqqeH
         8+Y5qgEWa1IvVyZQTlYF4RdRy1qozTnIHm166cHNq2Wt0/8V4BwMOMLrd5VTTis0QosW
         t/FUS16TrDlsPwIqAkbmganSbnv7ioUJbKR3HpS/+SnlBn7bHMiUzRwxUOfjf0aNwpwj
         7w37jW4GG+YNHSIoXCpMMVfy4N60Qq1jFiioIVfAaLMA9pEwU1a7boksfXfKvTllgWIj
         LtU3F60SkAITNJnxAEAdF5Rr1l6g63J4DrPxwJo59HD+ukT4SdwwKMKcAPpy1RdysE4X
         Ay4Q==
X-Gm-Message-State: AOAM530aUK/EDCzUEluIkJiDEGgkn9jHD0eH7GxFhNLK+4qCXFSgjKQd
        V1zXfdYs7uYihHUM5/TYqmU=
X-Google-Smtp-Source: ABdhPJwEAKsPBH7kn2azStwrrC4zVXziImkWLBmxhWQX1WGjnEH+r9FKIJnDuTflsqQPJwHRpFohBA==
X-Received: by 2002:a17:902:7b83:b029:e5:d4f4:fc4a with SMTP id w3-20020a1709027b83b02900e5d4f4fc4amr7810329pll.0.1615744656931;
        Sun, 14 Mar 2021 10:57:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:89b:3eb5:22db:84eb:67de:24b5])
        by smtp.googlemail.com with ESMTPSA id x7sm8177670pjr.7.2021.03.14.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 10:57:36 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     ardeleanalex@gmail.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio:dac:max517.c: Use devm_iio_device_register()
Date:   Sun, 14 Mar 2021 23:27:09 +0530
Message-Id: <20210314175709.34301-1-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210314093356.10609-1-dmugil2000@gmail.com>
References: <20210314093356.10609-1-dmugil2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_iio_device_register() to avoid remove function and
drop explicit call to iio_device_unregister().

Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>

changes v1->v2:
	-As sugested by Alexandru removed i2c_set_clientdata() because the stored
	 data will be never used.
---
 drivers/iio/dac/max517.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 7e01838ef4d0..00f0062a0298 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -153,7 +153,6 @@ static int max517_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
 	/* establish that the iio_dev is a child of the i2c device */
@@ -189,13 +188,7 @@ static int max517_probe(struct i2c_client *client,
 			data->vref_mv[chan] = platform_data->vref_mv[chan];
 	}
 
-	return iio_device_register(indio_dev);
-}
-
-static int max517_remove(struct i2c_client *client)
-{
-	iio_device_unregister(i2c_get_clientdata(client));
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id max517_id[] = {
@@ -214,7 +207,6 @@ static struct i2c_driver max517_driver = {
 		.pm	= &max517_pm_ops,
 	},
 	.probe		= max517_probe,
-	.remove		= max517_remove,
 	.id_table	= max517_id,
 };
 module_i2c_driver(max517_driver);
-- 
2.25.1

