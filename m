Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457DF3B29D7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhFXIIC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 04:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhFXIIB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jun 2021 04:08:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E5C061574
        for <linux-iio@vger.kernel.org>; Thu, 24 Jun 2021 01:05:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s6so7189868edu.10
        for <linux-iio@vger.kernel.org>; Thu, 24 Jun 2021 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umBwtkhrSHwFrljnPOuOKVRuZZ2n2cUtpGj8YFIOkIA=;
        b=SKIPoc5iG3fG5SA7nspUWpIbsVLYK+y2Z8tpzc5T8g1shNPVxgDPcp9coziLuilLN4
         0VrTM6heBFZzmR+QZNt1+KDjwUU0fWaWKFtwvXGw/WtWztdXKynH1ClKl1VLr9t/IAwC
         /I/+M3jFowOCx5TdigFfBmqXXpIjGUiSlIU3XzcO7q192C2CblXwfODT7a8i0WVD0Sfa
         zZtMQejZh6cwX2uv23TNwZTxlE5D1PEG7w8x7vVKgSVsgWUxQW5t0w7xaqhcWTPJ5h1/
         267OmKVKThlgwgE21nvP0lMEj/yH9tWKXYVKyxykGPa+Gdl3CU7jJcrs5oSKZJr0gx9I
         ScmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umBwtkhrSHwFrljnPOuOKVRuZZ2n2cUtpGj8YFIOkIA=;
        b=Gj7RLDK0pvUBwlgO/rLQYADVcYU4wqB/5IbXNY2ecKsm0hs0d5q04SmDB0Lx3eP1Zi
         iAiVetT9D3iuOJLSHdzCeDelwBexGkVqVcOUU8kuzt3HPOaAMCpsrOQ/TXzivuald1sC
         am+nZjSJSyZChYyeAvHx0JNDH9i1rG6ILvlsECM7ZivNe6Gws5u7HuEEoMkuc/Yn5j3/
         NpeSvQaeNR5mMnbz7fYWodMhb4DSNK62qQhSm/bqAgNl2n45SgNaPQqjqut9BJAT2jTk
         oH8ustPQ502l8Gx0xg/yl8TfVzKiRl40YrOCWwnMnfnaTPW1GoIHu5RvoHjBaonOhCxz
         fgOg==
X-Gm-Message-State: AOAM532OIlKvbxxh7QqyyxGUUCjOqvD1IzrQ96Y6D9eUkpqxsd155XJ3
        +aogWFy58oQAUAWw/35F1a8YrRJVbEi3jWpt
X-Google-Smtp-Source: ABdhPJwbcV7DdSZZdd3qTmrqphcMBwjXE5Kd8vp3+PXO3x3KpuZCmZuXz/eDq2BegFMy0PLypzagBQ==
X-Received: by 2002:a05:6402:138c:: with SMTP id b12mr5498588edv.268.1624521938886;
        Thu, 24 Jun 2021 01:05:38 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id w10sm1405936edv.34.2021.06.24.01.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 01:05:38 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: light: tcs3414: convert probe to device-managed routines
Date:   Thu, 24 Jun 2021 11:05:34 +0300
Message-Id: <20210624080534.9209-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the driver to use only device-managed init routines in
the probe function of the driver.

This way, we no longer need the tcs3414_remove() hook.
We still need to keep the i2c_set_clientdata() call, as that's being used
for the PM routines.

And lastly, a devm_add_action_or_reset() hook is added to call the
powerdown handler when the chip is uninitialized or the probe fails.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/light/tcs3414.c | 48 +++++++++++++++----------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 0593abd600ec..b87222141429 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -267,6 +267,18 @@ static const struct iio_buffer_setup_ops tcs3414_buffer_setup_ops = {
 	.predisable = tcs3414_buffer_predisable,
 };
 
+static int tcs3414_powerdown(struct tcs3414_data *data)
+{
+	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
+		data->control & ~(TCS3414_CONTROL_POWER |
+		TCS3414_CONTROL_ADC_EN));
+}
+
+static void tcs3414_powerdown_cleanup(void *data)
+{
+	tcs3414_powerdown(data);
+}
+
 static int tcs3414_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -309,6 +321,11 @@ static int tcs3414_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(&client->dev, tcs3414_powerdown_cleanup,
+				       data);
+	if (ret < 0)
+		return ret;
+
 	data->timing = TCS3414_INTEG_12MS; /* free running */
 	ret = i2c_smbus_write_byte_data(data->client, TCS3414_TIMING,
 		data->timing);
@@ -320,38 +337,12 @@ static int tcs3414_probe(struct i2c_client *client,
 		return ret;
 	data->gain = ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
 		tcs3414_trigger_handler, &tcs3414_buffer_setup_ops);
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto buffer_cleanup;
-
-	return 0;
-
-buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return ret;
-}
-
-static int tcs3414_powerdown(struct tcs3414_data *data)
-{
-	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
-		data->control & ~(TCS3414_CONTROL_POWER |
-		TCS3414_CONTROL_ADC_EN));
-}
-
-static int tcs3414_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	tcs3414_powerdown(iio_priv(indio_dev));
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -385,7 +376,6 @@ static struct i2c_driver tcs3414_driver = {
 		.pm	= &tcs3414_pm_ops,
 	},
 	.probe		= tcs3414_probe,
-	.remove		= tcs3414_remove,
 	.id_table	= tcs3414_id,
 };
 module_i2c_driver(tcs3414_driver);
-- 
2.31.1

