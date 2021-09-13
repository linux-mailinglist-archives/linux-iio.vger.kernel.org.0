Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE6408A9D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Sep 2021 14:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbhIMMB1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Sep 2021 08:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbhIMMB0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Sep 2021 08:01:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CBEC061574
        for <linux-iio@vger.kernel.org>; Mon, 13 Sep 2021 05:00:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bt14so20507548ejb.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Sep 2021 05:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ynajf2oRl8azvt52XtMtresyxi/WIto0zTPxM5Y5zrw=;
        b=Led5fII4VE69DOnwm9T2XQ4xXTFwIScKHx9X0W3Z3A5JvPt8vGXQA+neWtA72Pz70h
         Hbwx5O9DqpRvUzFANGyzDeXh0cu4CJ3zasmgyioIVjrNk11SbhYOZsVOeLMVb9BAZHYI
         He2R7eQwDWUG44klITQm3Pfpjg6RKj4I2K6woxttPCWjlZZEtEtn9Jnl3DjUBHrGPxy9
         gAZlVYBjMcajbOks3FMQzKmchmOekojmdOJ3Wd55MEk/f63N+wXBjOo3lq+4Gy52XWrj
         4P94UMTp/zxD6OybYnDxel6ChfqCz9PrMKVB8y391vaum6Wr4Hz7881QlDTfnEuSNH2N
         W7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ynajf2oRl8azvt52XtMtresyxi/WIto0zTPxM5Y5zrw=;
        b=Jz+9rt/LCpy53gfMlruXGbjjA1I+aFJ7DsId5ACd+qO+xe9/HtSNlKvUMaNg4U0Qh5
         XWLXyHrTRMocplpekPXP7mu8JU8rI8JmVC2j9fmdBmP0gJ029yd5ZN3lPKKC8E7IeuJi
         ifLzXQySiImpBePxTRcFr/fOWbziG7FhlDdCJSjQBPIbkSPECv9hjR0GVFZCbrsT6law
         P73JVsZCCXE2upeZpTx34vvWEqHlHZcO8794Bq3KqEU7CZrRTYODdtcxw/hkM5owS6+d
         5bqs+H6mAdwv93I90z/OkLtbsBBvo0m7ff8IR/VVDRPo3+xjc3JV3pIGIS/sdk81yiYp
         KPBQ==
X-Gm-Message-State: AOAM531xzTcDtG4H7sMc45+r/ADeJKHX6wq52n8olUR5FdyQhv85Rao3
        cDe36ja4SkP8XX7kmkDOkEA637DOIcTPHQ==
X-Google-Smtp-Source: ABdhPJwHK6H5AOwEmalaxWftZfLlNc4fCrsZCEgBQSyyjzmHqi7m+zHkBmxoeJ0QAyH8W9IoDBd5uQ==
X-Received: by 2002:a17:906:2350:: with SMTP id m16mr12431728eja.340.1631534406897;
        Mon, 13 Sep 2021 05:00:06 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id la1sm2412974ejc.48.2021.09.13.05.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 05:00:06 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: light: max44000: use device-managed functions in probe
Date:   Mon, 13 Sep 2021 15:00:02 +0300
Message-Id: <20210913120002.306280-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a simple conversion. Both iio_device_register() and
iio_triggered_buffer_setup() functions have device-managed variants.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/light/max44000.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index b8e721bced5b..85689dffbcbf 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -540,7 +540,6 @@ static int max44000_probe(struct i2c_client *client,
 		return PTR_ERR(data->regmap);
 	}
 
-	i2c_set_clientdata(client, indio_dev);
 	mutex_init(&data->lock);
 	indio_dev->info = &max44000_info;
 	indio_dev->name = MAX44000_DRV_NAME;
@@ -589,23 +588,14 @@ static int max44000_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL, max44000_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+					      max44000_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		return ret;
 	}
 
-	return iio_device_register(indio_dev);
-}
-
-static int max44000_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id max44000_id[] = {
@@ -628,7 +618,6 @@ static struct i2c_driver max44000_driver = {
 		.acpi_match_table = ACPI_PTR(max44000_acpi_match),
 	},
 	.probe		= max44000_probe,
-	.remove		= max44000_remove,
 	.id_table	= max44000_id,
 };
 
-- 
2.31.1

