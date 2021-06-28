Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FE23B5FCB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jun 2021 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhF1OTv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Jun 2021 10:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhF1OTv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jun 2021 10:19:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4512EC061760
        for <linux-iio@vger.kernel.org>; Mon, 28 Jun 2021 07:17:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so13866915wme.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Jun 2021 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuNJweosuipucr4vhg0XhclqW1q8Ja8Oi1r1gTGSAjc=;
        b=QygiPxCHhdIGBTdAvUgBSVXLuBadR+p7jLqHUw3tyMpunPOzeNyjovnSSD4TTT8RyR
         roQKK2BbsVBmSHAm82YwdthcpaN6J1rsmeJDjV+amE+v6tEduKw9K7g7mmt0kJtd7Nfp
         UQAvV6s5pggiDGHDClkwZeIzyRhXCZaoWP4WGsh1cPHqyoa7iDDn8/aENJ+IeWrRnu2G
         hmd4HFBwUJT7E9zf3P6+wjpgjCP+yzvVbghQXOYY59H8jn1PBm8z7WW5l4aIFSSuvE8g
         fhoygFTLfbUVeAr0gg0mMAtXS9yHuqhCoNie5QwM0W5I0NYiZ/F7DPgMewo5ruLID+iI
         +l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuNJweosuipucr4vhg0XhclqW1q8Ja8Oi1r1gTGSAjc=;
        b=S7QQkb8jjMLzmzBYPwzu4xecr6m3buVvBtklsL0HKw3e9Njz/zQ4iF8Pfu0dzzrtL0
         S8/wX/yGtQY7KmbI3JCHbehuE8Hadf1hn9bHFMSVxFi8x7goQaSY+OiskGMv+YQvCnQ0
         kPFKWbI9nvx27xBp0vpTEBkzjm+H3xcPGIkK/SZqlwZ6fTEwCuYcs6nD9C3TfZcLP6ni
         dG6kS8aXR9F+xCor/Fy8ANWFlzI1evPnR8+EW/9n6nbr3Tj5DVnerYogUmBLtRk0YYIW
         3YeD+OwDVwbEu7BKpwctMMoTfygG/gtfH4Vq4Kt8ovUbwEODzdobCUGwTsXidS8ph5l2
         BcIQ==
X-Gm-Message-State: AOAM5311fwFfsZbu0Eyzr5wG0on61+rQMxdKb5kICoaRLk04GwebYsVD
        naPHyQ9bRmKdvo7M5Wqp9ihGgwnsoRXk95CN+LY=
X-Google-Smtp-Source: ABdhPJz0TSrLse6qo1VCS1JWg6bZxhe+0Bg6alEz8bitTBlTCij+dn3eWVo/Cms/yJrkW8rO7zCegg==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr27530614wmo.36.1624889843664;
        Mon, 28 Jun 2021 07:17:23 -0700 (PDT)
Received: from neptune.anevia.com (ip-149-62-159-73.naitways.net. [149.62.159.73])
        by smtp.gmail.com with ESMTPSA id x81sm22524012wmg.36.2021.06.28.07.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 07:17:23 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: accel: da280: convert probe to device-managed functions
Date:   Mon, 28 Jun 2021 17:17:09 +0300
Message-Id: <20210628141709.80534-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is another simple conversion to device-managed functions, requiring
the use of devm_iio_device_register() and moving the disabling of the
device on a devm_add_action_or_reset() hook.

The i2c_set_clientdata() can be removed, as the PM functions can work with
just the device object, to obtain the i2c_client object.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/da280.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 5edff9ba72da..9633bdae5fd4 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -100,6 +100,11 @@ static enum da280_chipset da280_match_acpi_device(struct device *dev)
 	return (enum da280_chipset) id->driver_data;
 }
 
+static void da280_disable(void *client)
+{
+	da280_enable(client, false);
+}
+
 static int da280_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -118,7 +123,6 @@ static int da280_probe(struct i2c_client *client,
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	i2c_set_clientdata(client, indio_dev);
 
 	indio_dev->info = &da280_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -142,22 +146,11 @@ static int da280_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "device_register failed\n");
-		da280_enable(client, false);
-	}
-
-	return ret;
-}
-
-static int da280_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
+	ret = devm_add_action_or_reset(&client->dev, da280_disable, client);
+	if (ret)
+		return ret;
 
-	return da280_enable(client, false);
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -194,7 +187,6 @@ static struct i2c_driver da280_driver = {
 		.pm = &da280_pm_ops,
 	},
 	.probe		= da280_probe,
-	.remove		= da280_remove,
 	.id_table	= da280_i2c_id,
 };
 
-- 
2.31.1

