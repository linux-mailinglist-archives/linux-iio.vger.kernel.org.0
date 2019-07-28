Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A248777FDE
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 16:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfG1Ogo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 10:36:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34233 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfG1Ogo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jul 2019 10:36:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so26693934pfo.1;
        Sun, 28 Jul 2019 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZJfnNtysLiC4XTp1HgEs2uOITRSitKSTACuAECWVcc=;
        b=PdE/BeuDhkkQ/xvsecAPIMZ4UdyFm+rsCgFHauyMVnVq846+tacytYU0OBH6qPAdQk
         1gWb48/gzqRXMvJCzjJ9wDUYqwztDF6fqOweAabAZACnituMGk3gS4PN7ygriuO1oeGu
         k4t+RQl3fuLfECODEoUJHk0G8s6aFAC3HYLY6LxBPPnIhEf3xqmTVfn51Apm58XqcLEd
         zOm1uG8RN/zBdWbTWa42wYnj1e4p4ehHAfnHaVtEagLR0ByuIEWdIQAsHmjf+ff43Oyk
         ejIUcAIuERlHq/zM0B+nOQFv97O0Ul6qBsGQFmDbBAqIX/kPSuR7my8pNKdQo5CiSohX
         s8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZJfnNtysLiC4XTp1HgEs2uOITRSitKSTACuAECWVcc=;
        b=ZWbXYzE+MPz7AwV9lEiYYPEwvRiStne8KJy2klpkeq/GdYi5DO08FiwuPGwc2WCh60
         g4JhsV097lFCY6cL8AvLpYDSiP+jyO4d0l8S6wIztHyw3HBzw3I8awPkHw2YmMS5uP0x
         A9tkOwVOwyhunI8hrXM0BJoD8YLGYE6CrkWRh65T8Wegz4IBOEXNAUfhjGA01Dg49LnP
         9E1FpqI/XomPR7OkqiJbKv5XG5Pbc8/o2k93juCZJ/ZbfDXH0uTzi35vIaoPPmYPW0wn
         JxeMJg6lXt7Z+VlAharrjUCiqNki09aOdlafGh5GKATUkw9hVTa/hzcxuDUMcBbzPEXO
         4OqA==
X-Gm-Message-State: APjAAAVa+stD8sx4OlU/W7gr2GoYB3H8lC0sMmRDxRW0VCJS4EdAnFwk
        Bo2sgWHgfMwt0G93Zb1DRyQ=
X-Google-Smtp-Source: APXvYqyDNA35DNBOOtNufPtgnsGS/a+jmEItkCvKrnOVXAwwEQleWYuTnyexXTtEWl4XmOadl+QxzA==
X-Received: by 2002:a62:1ac8:: with SMTP id a191mr31944970pfa.164.1564324603830;
        Sun, 28 Jul 2019 07:36:43 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id f27sm41786790pgm.60.2019.07.28.07.36.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 07:36:42 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] iio: light: cm3323: Use device-managed APIs
Date:   Sun, 28 Jul 2019 22:36:30 +0800
Message-Id: <20190728143630.7620-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device-managed APIs to simplify the code.
The remove functions are redundant now and can
be deleted.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Split v1 into two patches.
  - Drop the failed to register message and just
    return devm_iio_register.

 drivers/iio/light/cm3323.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 50f3438c2b49..0443861ba1ec 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -101,15 +101,16 @@ static int cm3323_init(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static void cm3323_disable(struct iio_dev *indio_dev)
+static void cm3323_disable(void *data)
 {
 	int ret;
-	struct cm3323_data *data = iio_priv(indio_dev);
+	struct iio_dev *indio_dev = data;
+	struct cm3323_data *cm_data = iio_priv(indio_dev);
 
-	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
+	ret = i2c_smbus_write_word_data(cm_data->client, CM3323_CMD_CONF,
 					CM3323_CONF_SD_BIT);
 	if (ret < 0)
-		dev_err(&data->client->dev, "Error writing reg_conf\n");
+		dev_err(&cm_data->client->dev, "Error writing reg_conf\n");
 }
 
 static int cm3323_set_it_bits(struct cm3323_data *data, int val, int val2)
@@ -243,26 +244,11 @@ static int cm3323_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to register iio dev\n");
-		goto err_init;
-	}
-
-	return 0;
-err_init:
-	cm3323_disable(indio_dev);
-	return ret;
-}
-
-static int cm3323_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	cm3323_disable(indio_dev);
+	ret = devm_add_action_or_reset(&client->dev, cm3323_disable, indio_dev);
+	if (ret < 0)
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id cm3323_id[] = {
@@ -276,7 +262,6 @@ static struct i2c_driver cm3323_driver = {
 		.name = CM3323_DRV_NAME,
 	},
 	.probe		= cm3323_probe,
-	.remove		= cm3323_remove,
 	.id_table	= cm3323_id,
 };
 
-- 
2.20.1

