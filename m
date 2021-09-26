Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662BF418AD8
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 21:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhIZTo5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 15:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhIZTo4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 15:44:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD8AC061570
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 12:43:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y35so8786077ede.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+FqvCf5osAEwUJvV00eWIuuRwW5rXLzyPiLGVp8SKng=;
        b=Kanj6in+B0Fx4dH3EbYTaDVlFJEkWXI9oRKfdTyxjT+G3+wnkaB3BYqts832OVWmxq
         CS2GhnE91NBJYFNloXrDmvZcVwgTyKKFyYqaQDAtJ/fozrn2PJdwy9qJgoEm0eMAUYBL
         qNyQOYJ2t0yrF2lt6wCi9aFkSd24gHaTH80A/nUizYD0pkOlOQtix2xSNZMS/ciuaePH
         /0AW7uofgqydthYM94ISTZm/avcEDI7vWp4IHKOAiABW/wxXNP8KJAu3PPkRtDT+MGaK
         EczlOWeLMss8vpAHXiCrmsJwW2ZTB/02D/9u2gmZxb6v0DQ4xsGSAjBD444f3jpw+Ykt
         6Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+FqvCf5osAEwUJvV00eWIuuRwW5rXLzyPiLGVp8SKng=;
        b=Mv/BGb6Jn7+7WNWPscs3Aj/I+e+Mg400Pg1NU3yQsYhkpX9J1c2q7IDpYvYRAAnOdG
         AbiY2TKn+XPNdig9ACblnOVjw8V8VhgCq5MPj87dEh/BwsqzpWSdVLh8YTQw0hPGrp/q
         9rXFm7f8aOOjDH+CUAcMKsLT62ipI3AYLK+zoO5UA4Z9ncrxavIB/jN3sAl9lW4Iclne
         FUyZGud62BXvGyOUwlnqy+NKLsFGf5fhlVbJ+XUJmlY4iKOkHkijJSW4wQ3J9a0QapJU
         R7+89EvRpSwxYC0weVl+1NS6BNyJKg4h5/d9rwWK8cAf9omWu8FU3hIgTeMtN9kBMwy6
         JCJQ==
X-Gm-Message-State: AOAM531I0xcwT8JFPT7SafDQSs3j+ubJk68IT8K7YYIfcgX6ValIsCO1
        R30/bKwjqiSVnpzPP5C6UArrrw==
X-Google-Smtp-Source: ABdhPJwMOlCNHt8sfNlt04grZFgJ/qzr8FZQLGjpR+8zw7t9SX1zLCxw1tKYmtlUcw5fSkpJHvAvfA==
X-Received: by 2002:a05:6402:1808:: with SMTP id g8mr19068079edy.188.1632685398682;
        Sun, 26 Sep 2021 12:43:18 -0700 (PDT)
Received: from neptune.. ([188.27.128.17])
        by smtp.gmail.com with ESMTPSA id a23sm1872347edx.69.2021.09.26.12.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:43:18 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: adc: ad7291: convert probe to device-managed only
Date:   Sun, 26 Sep 2021 22:43:15 +0300
Message-Id: <20210926194315.7742-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a simple conversion for to device-managed with using
devm_request_threaded_irq(), disabling the regulator via a
devm_add_action_or_reset() hook and finally using
devm_iio_device_register().

The i2c_set_clientdata() call is removed as it becomes redundant after this
change.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7291.c | 70 +++++++++++++---------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index 2301a0e27f23..e9129dac762f 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -460,6 +460,11 @@ static const struct iio_info ad7291_info = {
 	.write_event_value = &ad7291_write_event_value,
 };
 
+static void ad7291_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7291_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -473,8 +478,6 @@ static int ad7291_probe(struct i2c_client *client,
 	chip = iio_priv(indio_dev);
 
 	mutex_init(&chip->state_lock);
-	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, indio_dev);
 
 	chip->client = client;
 
@@ -495,6 +498,11 @@ static int ad7291_probe(struct i2c_client *client,
 		if (ret)
 			return ret;
 
+		ret = devm_add_action_or_reset(&client->dev, ad7291_reg_disable,
+					       chip->reg);
+		if (ret)
+			return ret;
+
 		chip->command |= AD7291_EXT_REF;
 	}
 
@@ -506,58 +514,25 @@ static int ad7291_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ad7291_i2c_write(chip, AD7291_COMMAND, AD7291_RESET);
-	if (ret) {
-		ret = -EIO;
-		goto error_disable_reg;
-	}
+	if (ret)
+		return -EIO;
 
 	ret = ad7291_i2c_write(chip, AD7291_COMMAND, chip->command);
-	if (ret) {
-		ret = -EIO;
-		goto error_disable_reg;
-	}
+	if (ret)
+		return -EIO;
 
 	if (client->irq > 0) {
-		ret = request_threaded_irq(client->irq,
-					   NULL,
-					   &ad7291_event_handler,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					   id->name,
-					   indio_dev);
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL,
+						&ad7291_event_handler,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						id->name,
+						indio_dev);
 		if (ret)
-			goto error_disable_reg;
+			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_irq;
-
-	return 0;
-
-error_unreg_irq:
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-error_disable_reg:
-	if (chip->reg)
-		regulator_disable(chip->reg);
-
-	return ret;
-}
-
-static int ad7291_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ad7291_chip_info *chip = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-
-	if (chip->reg)
-		regulator_disable(chip->reg);
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id ad7291_id[] = {
@@ -579,7 +554,6 @@ static struct i2c_driver ad7291_driver = {
 		.of_match_table = ad7291_of_match,
 	},
 	.probe = ad7291_probe,
-	.remove = ad7291_remove,
 	.id_table = ad7291_id,
 };
 module_i2c_driver(ad7291_driver);
-- 
2.31.1

