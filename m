Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C1233A3EF
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 10:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhCNJed (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 05:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhCNJec (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Mar 2021 05:34:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE024C061574;
        Sun, 14 Mar 2021 01:34:31 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id s21so4787897pfm.1;
        Sun, 14 Mar 2021 01:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=50Yu8kRAczurx9Iye9QEQJW7J2f9sj2gmPo3j4z9tyQ=;
        b=pJRbLGYF4Vd+nSlRRISnYYfYuKYhZLUhXYlM0/lL1eDFVz/5F8S2ynx+/nrCSS5+Ik
         aLIoreIrFBczGNwajQTojh8+2JG+/8aCqvZc0Ug/XAO/QvnIHF8sTxQkdb3wq0bUwfNp
         siwpOScKVUSLZpOChd4mbmqyMfAC7ZSiZLowPjgTDTpVasfvy/BnKoribPw2GPYGsB1G
         zcNdk0+QQfFpboON6fO9E/OpLbYOnZ7piBl3/94Vpb3X39eQkDdbIAJHjHffIfCZhMaT
         n03y2ilHgHnu+YgOXVHDQocFeqdHSeOAraSNg1ljcOk6qVeaBzA2BRy3FUJFxeLrDR4S
         lXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=50Yu8kRAczurx9Iye9QEQJW7J2f9sj2gmPo3j4z9tyQ=;
        b=LVLFaWrsmu35czE70/tghcSk2fERmP7ejVrDaWXZoNqXW7wMmLJXXcvMvlDoaHOJNd
         j9ovCV/9SgUuu1uaTq2lcQDIxZQQKN9wOFr7DZtin+3EaqSf/gQq9qdh/ogwzcUiJjA7
         TRzw0GR3m53hYX644oxGD0gvH0S3bleEZGrACziN4Bcm+cD/gGmu0Da7t/BaH620vJBl
         x1WK89EFbtrJgHgpZLELOZfv9hDCV63+HBqnV8HuP2iiNFssjGZOAwF3tRPB42uYTjmT
         UonyHQlndR5sAuuR1JMXZ+t01zCCyvSysSZkesvcv+fmAgHP/PJ8ATOFPl71b/Voc56M
         v0ew==
X-Gm-Message-State: AOAM5333wzcM0lSCqIkWVvg8FZTD477xjcr3NeugXs/e5ZJBI4yttrXE
        8XbDqOzV3pxWumc+WICFIbE=
X-Google-Smtp-Source: ABdhPJxne6eIRAhDeCEZ9HqFnB32LSvHWJiFLNNsOlsCQC8pnuqhKVy10mRfKB6rhlVlBTb9RwuiZg==
X-Received: by 2002:a63:520e:: with SMTP id g14mr18653079pgb.350.1615714471119;
        Sun, 14 Mar 2021 01:34:31 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:61a:47fe:52e6:571b:e80a:141e])
        by smtp.googlemail.com with ESMTPSA id s15sm10274722pfe.108.2021.03.14.01.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 01:34:30 -0800 (PST)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     ardeleanalex@gmail.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio:dac:max517: Use devm_iio_device_register()
Date:   Sun, 14 Mar 2021 15:03:56 +0530
Message-Id: <20210314093356.10609-1-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_iio_device_register() to avoid remove function and 
drop explicit call to iio_device_unregister().

Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 drivers/iio/dac/max517.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 7e01838ef4d0..5f72f126162d 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -189,13 +189,7 @@ static int max517_probe(struct i2c_client *client,
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
@@ -214,7 +208,6 @@ static struct i2c_driver max517_driver = {
 		.pm	= &max517_pm_ops,
 	},
 	.probe		= max517_probe,
-	.remove		= max517_remove,
 	.id_table	= max517_id,
 };
 module_i2c_driver(max517_driver);
-- 
2.25.1

