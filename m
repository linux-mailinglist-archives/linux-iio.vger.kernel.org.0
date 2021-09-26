Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A35A418A21
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhIZQW5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 12:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhIZQW4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 12:22:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E3FC061570
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 09:21:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y35so7303360ede.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ELIGrQH/sMSDaYiXS07AXqkk+94JGp/aiOT+ALKxTU8=;
        b=l3dZ3Q/CM6R2USTGYmG7/OugITD2xqAGhgPPFp/Rxld4C7u0GteD6zSXpgwds2Jw7q
         N3nBrygDwPTMAcoHjHqFzlDGcePYWEavRqhmQgRFxHXSyoiSOZ1HmqJVvED+Dww5GolM
         dClauktCGdGg4MWevB8c8iKRjoZUgJVT1QVKhJ9gJ5OlDWIs0bqdE9CHaQHaWE6M3/Tg
         nN0Lhp8zkw21MxCrVevIhuflokY3sBVuUSMoseLFPT2ZS3J1BLV6czb+daPky3hP+w0I
         PnjTEI8pRL37eA7UvRnJheIAPhy58gHpW0LbgtqRZXtH+/0x5d/4gh4Bd0OsN4kd/oTH
         Wh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ELIGrQH/sMSDaYiXS07AXqkk+94JGp/aiOT+ALKxTU8=;
        b=OUTgp0NbCP+VrN0sq1w080nnCoyngZ0Atk2FDVSGjk5Qf1a8ZvNBb+67DDbGzTPm0R
         7w2XGkSkmVgq7eUkZ0Vyw5ysa3ySa7kQ6mmU6CYJskRSF6AWYSf8nPyVBTkrq65AP+RL
         VLvPL8h34AZDq465WtaNZ0pQy8qlU7K/uXFEo6eHX7HQ8hOWNfyvLQTDtA+5rX2Wilxj
         X9XAxiQ2WRjyWGAyY1mJfoA11qmTDGSyZMqsI6U5g8shQfIZ7d8i+0nENudczudyU9Jf
         9wthBy+eaR927DDk0QZZRsx+K6JAxE/asmvVXPCjZ/MifbtyMDdcg33DQ6vJ+FExqAmm
         VvMA==
X-Gm-Message-State: AOAM5313Y1V3CsKAdAO3eda4ir/1NYg7DW2+gdRj6fOfD5+dARtAGQH+
        T4/TkaMGgsbDH7ambwdG93pZ/twtZxY5TA==
X-Google-Smtp-Source: ABdhPJwyJtjbg0DKAH9UOR1nJGQT+HJ9vEaIVAp32JxrPnrLkNoQZubLwiU7mHsd0/UsP+Mwc5ll0Q==
X-Received: by 2002:a17:906:f0cc:: with SMTP id dk12mr9937096ejb.36.1632673278647;
        Sun, 26 Sep 2021 09:21:18 -0700 (PDT)
Received: from neptune.. ([188.27.128.17])
        by smtp.gmail.com with ESMTPSA id ba29sm9202477edb.5.2021.09.26.09.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 09:21:18 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: adc: max1363: convert probe to full device-managed
Date:   Sun, 26 Sep 2021 19:21:10 +0300
Message-Id: <20210926162110.3536436-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For this conversion, the 2 regulators (being enabled) require each a
devm_add_action_or_reset() hook registration.

For the other functions, there are device-managed variants.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/max1363.c | 82 ++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index f2b576c69949..eef55ed4814a 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1577,6 +1577,11 @@ static const struct of_device_id max1363_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, max1363_of_match);
 
+static void max1363_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int max1363_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1590,7 +1595,8 @@ static int max1363_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
+	ret = devm_iio_map_array_register(&client->dev, indio_dev,
+					  client->dev.platform_data);
 	if (ret < 0)
 		return ret;
 
@@ -1598,17 +1604,16 @@ static int max1363_probe(struct i2c_client *client,
 
 	mutex_init(&st->lock);
 	st->reg = devm_regulator_get(&client->dev, "vcc");
-	if (IS_ERR(st->reg)) {
-		ret = PTR_ERR(st->reg);
-		goto error_unregister_map;
-	}
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
 
 	ret = regulator_enable(st->reg);
 	if (ret)
-		goto error_unregister_map;
+		return ret;
 
-	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, indio_dev);
+	ret = devm_add_action_or_reset(&client->dev, max1363_reg_disable, st->reg);
+	if (ret)
+		return ret;
 
 	st->chip_info = device_get_match_data(&client->dev);
 	if (!st->chip_info)
@@ -1622,13 +1627,17 @@ static int max1363_probe(struct i2c_client *client,
 
 		ret = regulator_enable(vref);
 		if (ret)
-			goto error_disable_reg;
+			return ret;
+
+		ret = devm_add_action_or_reset(&client->dev, max1363_reg_disable, vref);
+		if (ret)
+			return ret;
+
 		st->vref = vref;
 		vref_uv = regulator_get_voltage(vref);
-		if (vref_uv <= 0) {
-			ret = -EINVAL;
-			goto error_disable_reg;
-		}
+		if (vref_uv <= 0)
+			return -EINVAL;
+
 		st->vref_uv = vref_uv;
 	}
 
@@ -1640,13 +1649,12 @@ static int max1363_probe(struct i2c_client *client,
 		st->send = max1363_smbus_send;
 		st->recv = max1363_smbus_recv;
 	} else {
-		ret = -EOPNOTSUPP;
-		goto error_disable_reg;
+		return -EOPNOTSUPP;
 	}
 
 	ret = max1363_alloc_scan_masks(indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
 	indio_dev->name = id->name;
 	indio_dev->channels = st->chip_info->channels;
@@ -1655,12 +1663,12 @@ static int max1363_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	ret = max1363_initial_setup(st);
 	if (ret < 0)
-		goto error_disable_reg;
+		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		&max1363_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+					      &max1363_trigger_handler, NULL);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, st->client->irq,
@@ -1671,39 +1679,10 @@ static int max1363_probe(struct i2c_client *client,
 					   indio_dev);
 
 		if (ret)
-			goto error_uninit_buffer;
+			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto error_uninit_buffer;
-
-	return 0;
-
-error_uninit_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_reg:
-	if (st->vref)
-		regulator_disable(st->vref);
-	regulator_disable(st->reg);
-error_unregister_map:
-	iio_map_array_unregister(indio_dev);
-	return ret;
-}
-
-static int max1363_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct max1363_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (st->vref)
-		regulator_disable(st->vref);
-	regulator_disable(st->reg);
-	iio_map_array_unregister(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id max1363_id[] = {
@@ -1756,7 +1735,6 @@ static struct i2c_driver max1363_driver = {
 		.of_match_table = max1363_of_match,
 	},
 	.probe = max1363_probe,
-	.remove = max1363_remove,
 	.id_table = max1363_id,
 };
 module_i2c_driver(max1363_driver);
-- 
2.31.1

