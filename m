Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077113D4A6B
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 00:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhGXVYM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhGXVYL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jul 2021 17:24:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE8DC061575
        for <linux-iio@vger.kernel.org>; Sat, 24 Jul 2021 15:04:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u8so7413427plr.1
        for <linux-iio@vger.kernel.org>; Sat, 24 Jul 2021 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSo1Mvuhy7iMGZQB05F8GGxSRpDsS4PUfeVa8vq5qgY=;
        b=kKumIIpb+vE3Wiry/cnmgXqXU0kCcwj/yZZ/zAF0xvX7r+E1+h8YrD7fUI294v6QL8
         CyObxcc7OsrLKcEnWxmvZZadA7PXCR+QQhn1qjpv1ptHzqtJp1Q6iSqwm+jxgq/zsnrN
         rSMYzAvGJwSkENyeE5W5wiV3zZJHHfYzuCjC0IbAO5ipTcrb087FsyXfEpwwQ+uFnKHc
         DjUSjwKpA6YGakonGFTBmqibK+/WWWPlP3dn6hDHVuTI6x1TLIGCPrDAAKFAGpgB/P4y
         3RQ6P323uZkQi24QRbHPkKxIj6GFMQtPV+PtMYyyvnE6ldIrTbEra5jVa6uLVgwiLXho
         iMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSo1Mvuhy7iMGZQB05F8GGxSRpDsS4PUfeVa8vq5qgY=;
        b=CHvl+6ptvRVixFuzlh9iGbzB2NWNtqXx+GOXYbTf2uScGm2Rp7TgEQKZSDvgbCPy9D
         L8HXYLCxU2ehQeI+QOtfxXjfzU2t1EzJpWQxUffqxuN62/PBFbYkuvdbwDp4CVNaAhwi
         L9XX588zFSc4U+LQILmCVpbYwct8LvuTao4kpgcAoa2nYcsuH1W2ffNf1M5s0SABZphO
         ggqUaKu5tclBzqnIrbpIFd3b0gJMP2Trwehs9SiVmMOkX1/yUwQNzin1USpOiwUaCd1s
         ORmpPbEz0+SwkXlZzEooK2ZZTyEeIWu+pjdEq/mlQDAVP3ZYkWYLwLOYquINgoeJZifU
         OPxg==
X-Gm-Message-State: AOAM530XU99QUnok6mLQYQ0wmjWDA3goJeht23AvUZNj60xh6weaAB94
        Ztq8YUle57K2krkYu5KQaOge2/e5yPe4KC5/
X-Google-Smtp-Source: ABdhPJz5e0CWpiLyOn3pvIAiOI/tSzUKrK/sTARFUEf6vMjEQmW9Uxc5Zok36OjbBNXH4LJNafpQvw==
X-Received: by 2002:a63:1f0e:: with SMTP id f14mr11222259pgf.65.1627164281010;
        Sat, 24 Jul 2021 15:04:41 -0700 (PDT)
Received: from localhost.localdomain ([187.36.163.88])
        by smtp.gmail.com with ESMTPSA id d15sm36859088pfl.82.2021.07.24.15.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 15:04:40 -0700 (PDT)
From:   =?UTF-8?q?Th=C3=A9o=20Bor=C3=A9m=20Fabris?= <theobf@usp.br>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Th=C3=A9o=20Bor=C3=A9m=20Fabris?= <theobf@usp.br>
Subject: [PATCH v2] iio: dac: max5821: convert device register to device managed function
Date:   Sat, 24 Jul 2021 19:02:00 -0300
Message-Id: <20210724220159.11998-1-theobf@usp.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a device managed hook, via devm_add_action_or_reset() and
max5821_regulator_disable(), to disable voltage regulator on device
detach.
Replace iio_device_register() by devm_iio_device_register() and remove
the max5821_remove() function used to unregister the device and disable the
voltage regulator.
Remove i2c_set_clientdata() from the probe function, since
i2c_get_clientdata() is not used anymore.
Remove regulator_disable() calls from the probe function.

Signed-off-by: Théo Borém Fabris <theobf@usp.br>
---
Changelog:
V1 -> V2: Removed regulator_disable() calls and goto statements

 drivers/iio/dac/max5821.c | 41 ++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index bd6e75699a63..bd0b7f361154 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -294,6 +294,11 @@ static const struct iio_info max5821_info = {
 	.write_raw = max5821_write_raw,
 };
 
+static void max5821_regulator_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int max5821_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -306,7 +311,6 @@ static int max5821_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
 
@@ -321,21 +325,29 @@ static int max5821_probe(struct i2c_client *client,
 		ret = PTR_ERR(data->vref_reg);
 		dev_err(&client->dev,
 			"Failed to get vref regulator: %d\n", ret);
-		goto error_free_reg;
+		return ret;
 	}
 
 	ret = regulator_enable(data->vref_reg);
 	if (ret) {
 		dev_err(&client->dev,
 			"Failed to enable vref regulator: %d\n", ret);
-		goto error_free_reg;
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&client->dev, max5821_regulator_disable,
+				       data->vref_reg);
+	if (ret) {
+		dev_err(&client->dev,
+			"Failed to add action to managed regulator: %d\n", ret);
+		return ret;
 	}
 
 	ret = regulator_get_voltage(data->vref_reg);
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"Failed to get voltage on regulator: %d\n", ret);
-		goto error_disable_reg;
+		return ret;
 	}
 
 	data->vref_mv = ret / 1000;
@@ -346,25 +358,7 @@ static int max5821_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &max5821_info;
 
-	return iio_device_register(indio_dev);
-
-error_disable_reg:
-	regulator_disable(data->vref_reg);
-
-error_free_reg:
-
-	return ret;
-}
-
-static int max5821_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct max5821_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	regulator_disable(data->vref_reg);
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id max5821_id[] = {
@@ -386,7 +380,6 @@ static struct i2c_driver max5821_driver = {
 		.pm     = &max5821_pm_ops,
 	},
 	.probe		= max5821_probe,
-	.remove		= max5821_remove,
 	.id_table	= max5821_id,
 };
 module_i2c_driver(max5821_driver);
-- 
2.20.1

