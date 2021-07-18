Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E743CCAA5
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhGRUou (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 16:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhGRUot (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Jul 2021 16:44:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7E8C061762
        for <linux-iio@vger.kernel.org>; Sun, 18 Jul 2021 13:41:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v14so8468739plg.9
        for <linux-iio@vger.kernel.org>; Sun, 18 Jul 2021 13:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oS+cKBOJStTCiPyZBHfD/Osp7vsTyjS+lvw+amReXJ0=;
        b=Z5HUkglxeDRK+2yyr4vfFDQYZwTTUZs+405wpZLV225StOGmCtPOw5OR+zgNMuGa4G
         kkft/8uBuiBiEwndYp/FIAj9KH0LoDuWqYj+2zwIDYlRWalN8RQj4LeJrdMTSphY1Uxu
         eAefZfk39nK27b9Fr1Sl48fxPNlGFyR/Pv05M5GnjIAd5d1ZWgqr//PFEc7J7I8/oQLH
         icPUnwPcBJ2FbnzEfAzEO1zRGRJJ10fXBzmV6t3s2B+XK+zzFc7B5TYXM/ZLP/NNYB7t
         28LdUB+tKnqUIgcMGOvNn3bOh44u5GNK0GFzAknnQ9bj7VeYHNMePWsnue7sMjQS819M
         9Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oS+cKBOJStTCiPyZBHfD/Osp7vsTyjS+lvw+amReXJ0=;
        b=Lmrjg98PLOqlsug/c/2UYL/XPjvYqPVKb5ZToblx3YNRcrJRt2ZS7qRi4C6NhrF7oY
         jM3I6ZKo6fE7PuHYbIVeWE2EcFbexaBaYAqaCLJmzTWcPaRndc/oa+L0RpbxJMzJdVnC
         qAiInNysv+2hbqiQlFPo9Fnv61vBZHWWn8UjeQNYsGpqEbnXTkvaRxNc1FCfdKralL1P
         JJ985uiVKIYRq+2GOgniMeF2HYrKeT9hJSqrqhdQ/FIMqP5fZmx9yMXlhXfMT7SEVdtm
         T0J8NJA/KQxGpUm2lu1FXC7JriARiWWMXfxjO7MaHzaSEXL0ITlHUnpnT+fHlpxmT5SX
         lpNw==
X-Gm-Message-State: AOAM532h2yK/Mz2IY6EYy9grIuOyRW8fZJx9FDSf8vnF6AazVzJ+ZkG+
        N2q0cMnPqVpUbePya3J6c7rWDw==
X-Google-Smtp-Source: ABdhPJx/qNoEH4v9SK3sSmqk1ef7KgBKq/9wd9W1UXuBRZXUW3cro5yyIRS4q5UM6mqXk+zUTTpsZA==
X-Received: by 2002:a17:902:c20d:b029:12b:565f:691e with SMTP id 13-20020a170902c20db029012b565f691emr16172922pll.75.1626640910648;
        Sun, 18 Jul 2021 13:41:50 -0700 (PDT)
Received: from localhost.localdomain ([187.36.163.88])
        by smtp.gmail.com with ESMTPSA id o3sm17407475pjr.49.2021.07.18.13.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 13:41:50 -0700 (PDT)
From:   =?UTF-8?q?Th=C3=A9o=20Bor=C3=A9m=20Fabris?= <theobf@usp.br>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Th=C3=A9o=20Bor=C3=A9m=20Fabris?= <theobf@usp.br>
Subject: [PATCH] iio: dac: max5821: convert device register to device managed function
Date:   Sun, 18 Jul 2021 17:37:48 -0300
Message-Id: <20210718203746.7159-1-theobf@usp.br>
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

Signed-off-by: Théo Borém Fabris <theobf@usp.br>
---
 drivers/iio/dac/max5821.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index bd6e75699a63..44c04ae70b32 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -294,6 +294,13 @@ static const struct iio_info max5821_info = {
 	.write_raw = max5821_write_raw,
 };
 
+static void max5821_regulator_disable(void *data)
+{
+	struct regulator *rdata = data;
+
+	regulator_disable(rdata);
+}
+
 static int max5821_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -306,7 +313,6 @@ static int max5821_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
 
@@ -331,6 +337,14 @@ static int max5821_probe(struct i2c_client *client,
 		goto error_free_reg;
 	}
 
+	ret = devm_add_action_or_reset(&client->dev, max5821_regulator_disable,
+				       data->vref_reg);
+	if (ret) {
+		dev_err(&client->dev,
+			"Failed to add action to managed regulator: %d\n", ret);
+		goto error_disable_reg;
+	}
+
 	ret = regulator_get_voltage(data->vref_reg);
 	if (ret < 0) {
 		dev_err(&client->dev,
@@ -346,7 +360,7 @@ static int max5821_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &max5821_info;
 
-	return iio_device_register(indio_dev);
+	return devm_iio_device_register(&client->dev, indio_dev);
 
 error_disable_reg:
 	regulator_disable(data->vref_reg);
@@ -356,17 +370,6 @@ static int max5821_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int max5821_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct max5821_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	regulator_disable(data->vref_reg);
-
-	return 0;
-}
-
 static const struct i2c_device_id max5821_id[] = {
 	{ "max5821", ID_MAX5821 },
 	{ }
@@ -386,7 +389,6 @@ static struct i2c_driver max5821_driver = {
 		.pm     = &max5821_pm_ops,
 	},
 	.probe		= max5821_probe,
-	.remove		= max5821_remove,
 	.id_table	= max5821_id,
 };
 module_i2c_driver(max5821_driver);
-- 
2.20.1

