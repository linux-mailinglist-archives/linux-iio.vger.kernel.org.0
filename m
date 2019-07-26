Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8046975F22
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 08:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfGZGgZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 02:36:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43154 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfGZGgZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 02:36:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so24257145pgv.10;
        Thu, 25 Jul 2019 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lcoZXPtSp/wxUMfqgXW1h46tt/pEtTdf5lES+lIfNjY=;
        b=CK0Nm/cZObATd0FvruGpXbkqddbfohXc5OoFbB4a+oHeEUQf7juuQ+msMl39QnHZ7W
         IHmNmG+VB8gRMpbPwE61ddXB7281kThCT634qOpy/k9qjN6d49mArw6VDNOq1o/GNMTB
         0NqV53Xmv5ynNxq8ZVTWP7b8gYkIiF7frpCum2J/F1/XxSTelOWY3/HrHHxJ7INqt79I
         8yK8PscMm8sJM8VKgGmbC9ja5HQKv3jBK4PVHBHfvvrFX/eArO1O+RSa6zxrfn3J7e9k
         9jEpgYdXcmwCivkgx+1ctEaL0iXpAb+KTGyJYGdWYqlYSc7IudaD9Brz6+iDJmYMEGAz
         LHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lcoZXPtSp/wxUMfqgXW1h46tt/pEtTdf5lES+lIfNjY=;
        b=mi7MlR0lwVhXKIZK5dO4f3L2/Tf8dGluugb35NX/HxaV0BZHA/TOwdhh68mOl0kmW8
         U8GDRniWPNbCvbqveyLkiYBAd+Nrkjh+zot/Nt6SFEF7flrj2DgWL2F/Ynnmnq+JKXy2
         4N2Dryz4PYn0mxnrPc1LOpOBcQUCrwYducz4gclSr+oRNAFuTGT8U7Wq6OZbS2ieszIq
         qU2US4PZMwOne9skG/TayEUZ8p/m+v5YaAQs3zuZ24nu16+h8W1BMg0L7L2rmrAGKTZ7
         4mv6LKSXSjANl8v7FP1dhSGMVXMD3tjLo5I6M3Q/Z5+4Q1rJXTQGonOQ7jkZ2v2ZDNR/
         TDBA==
X-Gm-Message-State: APjAAAXvsPCUU1iC17cNf5DEm0vHiUo7CbbaoITuAW3uGH4me9e7VY+R
        80OGLfupB7vdjBqpOxAuse/IFlEruic=
X-Google-Smtp-Source: APXvYqxb30LCQgKeMMbebeKOBvFZaq0vERTv1eMXIV3uhiMSimV1h9tVvT46HRwLRpoP2k21iZowVA==
X-Received: by 2002:a63:e5a:: with SMTP id 26mr86665156pgo.3.1564122984708;
        Thu, 25 Jul 2019 23:36:24 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id v126sm12446278pgb.23.2019.07.25.23.36.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 23:36:23 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] iio: mxc4005: Use device-managed APIs
Date:   Fri, 26 Jul 2019 14:36:16 +0800
Message-Id: <20190726063616.11045-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device-managed APIs to simplify the code.
The remove function is redundant now and can
be deleted.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/iio/accel/mxc4005.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 637e6e676061..d8b999023ef2 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -424,7 +424,7 @@ static int mxc4005_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mxc4005_info;
 
-	ret = iio_triggered_buffer_setup(indio_dev,
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
 					 iio_pollfunc_store_time,
 					 mxc4005_trigger_handler,
 					 NULL);
@@ -452,7 +452,7 @@ static int mxc4005_probe(struct i2c_client *client,
 		if (ret) {
 			dev_err(&client->dev,
 				"failed to init threaded irq\n");
-			goto err_buffer_cleanup;
+			return ret;
 		}
 
 		data->dready_trig->dev.parent = &client->dev;
@@ -460,43 +460,23 @@ static int mxc4005_probe(struct i2c_client *client,
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		indio_dev->trig = data->dready_trig;
 		iio_trigger_get(indio_dev->trig);
-		ret = iio_trigger_register(data->dready_trig);
+		ret = devm_iio_trigger_register(&client->dev,
+						data->dready_trig);
 		if (ret) {
 			dev_err(&client->dev,
 				"failed to register trigger\n");
-			goto err_trigger_unregister;
+			return ret;
 		}
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"unable to register iio device %d\n", ret);
-		goto err_buffer_cleanup;
+		return ret;
 	}
 
 	return 0;
-
-err_trigger_unregister:
-	iio_trigger_unregister(data->dready_trig);
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static int mxc4005_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct mxc4005_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (data->dready_trig)
-		iio_trigger_unregister(data->dready_trig);
-
-	return 0;
 }
 
 static const struct acpi_device_id mxc4005_acpi_match[] = {
@@ -517,7 +497,6 @@ static struct i2c_driver mxc4005_driver = {
 		.acpi_match_table = ACPI_PTR(mxc4005_acpi_match),
 	},
 	.probe		= mxc4005_probe,
-	.remove		= mxc4005_remove,
 	.id_table	= mxc4005_id,
 };
 
-- 
2.20.1

