Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CE83B82C5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jun 2021 15:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhF3NUD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 09:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhF3NUB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 09:20:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392ABC061766
        for <linux-iio@vger.kernel.org>; Wed, 30 Jun 2021 06:17:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id nd37so4187168ejc.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Jun 2021 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiTb0xD8le1nLQtDW6IFqKE9RONZcsoN+E9Y8GN3Uak=;
        b=ouYycHezo0GkOlzma46gP0wox4xgLOqMBUPFAjGWmz6jR9FV03kFcQUzmutNsgVU2I
         eCjzXZRIoVxF/4NXBwkAIfphL00xvSG7pvwNC1bB1Jvn8L/NPAcLXdsrpQC84mPsDScc
         nYQqsu/oNUwv9ocJhjUXs7SuULNIz+BLL1SP6WpqStQew1sPU5mZ7+l6Zopgau0+9Zh2
         AMo6jhK9ee0cbm8O8pz1fNJyQscjFUIO+UAzCvjLB1VgshsGKWE4gez98Xz/yfTSBZgl
         vLhMY11GK9yxv3bz8vIfd9P1A8zU3gm/aPR0PbTEwFgPZYxgeA00KvG6yEMQBnrR8zxh
         Ba9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiTb0xD8le1nLQtDW6IFqKE9RONZcsoN+E9Y8GN3Uak=;
        b=kmD4UOKojLPmb9TlwsmFHqvE7SEBaqptqzgns3I9rZkmmlRb9YBav9wUpGXHQj3O5V
         mKR0gJf5feCVsRhHIzxq0cx772W28SapT5egnDqVmDJj8OGAUSbXTr1WCuUpDHKvyjeb
         lfuBFiNntFgcV9yf9w4NPNbLF8wQuw9vrZDHy6WrsdDHskWotsiSWZItdtsqZw6yKZZf
         xb5u6RWQLKecoGpo58pbwWR4tnzT9BZzttym+Fi8hVl3epi14BK2Ko06QJrJVSXaNCRp
         htWgVHEgv9NIqEzrVxNBW4t0IRgYqBm1Y2RXAUra9q1ssC/5NCoRSPIqGQ9WgbLNvONq
         FLSw==
X-Gm-Message-State: AOAM532To9SrF89VCEyGLiQokfRQcpmh638cmux3jSnzpOzA5mBhWNpZ
        giRnXRI7xWlGXNiJVonQ49NfXCQWfqIkrXQD
X-Google-Smtp-Source: ABdhPJwqLnHfx4Dc0iEwF0a1zdqrchPCQxBKN1WprVuk/qHh4jQ4fFBfzqlr7q8Vw/RS6vWt4RllQQ==
X-Received: by 2002:a17:906:cb81:: with SMTP id mf1mr36138317ejb.199.1625059049450;
        Wed, 30 Jun 2021 06:17:29 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id md14sm39511ejb.125.2021.06.30.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 06:17:29 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 1/2] iio: proximity: rfd77402: use i2c_client for rfd77402_{init,powerdown}()
Date:   Wed, 30 Jun 2021 16:16:35 +0300
Message-Id: <20210630131636.1563148-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These 2 functions only do I2C reads/writes and don't require any of the
private data of the driver.

They're also used in the PM suspend/resume part of the driver.

Converting them to take an i2c_client object as parameter simplifies things
a bit (especially in the suspend/resume) as the driver mostly needs the
reference for i2c_client, so no need to jump through hoops to get it from
the private data (as was done in many places).

The rfd77402_measure() function has also been converted to take an
i2c_client object, since it also does only I2C ops.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/proximity/rfd77402.c | 60 ++++++++++++++------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 7a0472323f17..f349526421f3 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -90,18 +90,18 @@ static const struct iio_chan_spec rfd77402_channels[] = {
 	},
 };
 
-static int rfd77402_set_state(struct rfd77402_data *data, u8 state, u16 check)
+static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
 {
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, RFD77402_CMD_R,
+	ret = i2c_smbus_write_byte_data(client, RFD77402_CMD_R,
 					state | RFD77402_CMD_VALID);
 	if (ret < 0)
 		return ret;
 
 	usleep_range(10000, 20000);
 
-	ret = i2c_smbus_read_word_data(data->client, RFD77402_STATUS_R);
+	ret = i2c_smbus_read_word_data(client, RFD77402_STATUS_R);
 	if (ret < 0)
 		return ret;
 	if ((ret & RFD77402_STATUS_PM_MASK) != check)
@@ -110,24 +110,24 @@ static int rfd77402_set_state(struct rfd77402_data *data, u8 state, u16 check)
 	return 0;
 }
 
-static int rfd77402_measure(struct rfd77402_data *data)
+static int rfd77402_measure(struct i2c_client *client)
 {
 	int ret;
 	int tries = 10;
 
-	ret = rfd77402_set_state(data, RFD77402_CMD_MCPU_ON,
+	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
 				 RFD77402_STATUS_MCPU_ON);
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, RFD77402_CMD_R,
+	ret = i2c_smbus_write_byte_data(client, RFD77402_CMD_R,
 					RFD77402_CMD_SINGLE |
 					RFD77402_CMD_VALID);
 	if (ret < 0)
 		goto err;
 
 	while (tries-- > 0) {
-		ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
+		ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
 		if (ret < 0)
 			goto err;
 		if (ret & RFD77402_ICSR_RESULT)
@@ -140,7 +140,7 @@ static int rfd77402_measure(struct rfd77402_data *data)
 		goto err;
 	}
 
-	ret = i2c_smbus_read_word_data(data->client, RFD77402_RESULT_R);
+	ret = i2c_smbus_read_word_data(client, RFD77402_RESULT_R);
 	if (ret < 0)
 		goto err;
 
@@ -153,7 +153,7 @@ static int rfd77402_measure(struct rfd77402_data *data)
 	return (ret & RFD77402_RESULT_DIST_MASK) >> 2;
 
 err:
-	rfd77402_set_state(data, RFD77402_CMD_MCPU_OFF,
+	rfd77402_set_state(client, RFD77402_CMD_MCPU_OFF,
 			   RFD77402_STATUS_MCPU_OFF);
 	return ret;
 }
@@ -168,7 +168,7 @@ static int rfd77402_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&data->lock);
-		ret = rfd77402_measure(data);
+		ret = rfd77402_measure(data->client);
 		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
@@ -188,23 +188,23 @@ static const struct iio_info rfd77402_info = {
 	.read_raw = rfd77402_read_raw,
 };
 
-static int rfd77402_init(struct rfd77402_data *data)
+static int rfd77402_init(struct i2c_client *client)
 {
 	int ret, i;
 
-	ret = rfd77402_set_state(data, RFD77402_CMD_STANDBY,
+	ret = rfd77402_set_state(client, RFD77402_CMD_STANDBY,
 				 RFD77402_STATUS_STANDBY);
 	if (ret < 0)
 		return ret;
 
 	/* configure INT pad as push-pull, active low */
-	ret = i2c_smbus_write_byte_data(data->client, RFD77402_ICSR,
+	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
 					RFD77402_ICSR_INT_MODE);
 	if (ret < 0)
 		return ret;
 
 	/* I2C configuration */
-	ret = i2c_smbus_write_word_data(data->client, RFD77402_I2C_INIT_CFG,
+	ret = i2c_smbus_write_word_data(client, RFD77402_I2C_INIT_CFG,
 					RFD77402_I2C_ADDR_INCR |
 					RFD77402_I2C_DATA_INCR |
 					RFD77402_I2C_HOST_DEBUG	|
@@ -213,42 +213,42 @@ static int rfd77402_init(struct rfd77402_data *data)
 		return ret;
 
 	/* set initialization */
-	ret = i2c_smbus_write_word_data(data->client, RFD77402_PMU_CFG, 0x0500);
+	ret = i2c_smbus_write_word_data(client, RFD77402_PMU_CFG, 0x0500);
 	if (ret < 0)
 		return ret;
 
-	ret = rfd77402_set_state(data, RFD77402_CMD_MCPU_OFF,
+	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_OFF,
 				 RFD77402_STATUS_MCPU_OFF);
 	if (ret < 0)
 		return ret;
 
 	/* set initialization */
-	ret = i2c_smbus_write_word_data(data->client, RFD77402_PMU_CFG, 0x0600);
+	ret = i2c_smbus_write_word_data(client, RFD77402_PMU_CFG, 0x0600);
 	if (ret < 0)
 		return ret;
 
-	ret = rfd77402_set_state(data, RFD77402_CMD_MCPU_ON,
+	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
 				 RFD77402_STATUS_MCPU_ON);
 	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(rf77402_tof_config); i++) {
-		ret = i2c_smbus_write_word_data(data->client,
+		ret = i2c_smbus_write_word_data(client,
 						rf77402_tof_config[i].reg,
 						rf77402_tof_config[i].val);
 		if (ret < 0)
 			return ret;
 	}
 
-	ret = rfd77402_set_state(data, RFD77402_CMD_STANDBY,
+	ret = rfd77402_set_state(client, RFD77402_CMD_STANDBY,
 				 RFD77402_STATUS_STANDBY);
 
 	return ret;
 }
 
-static int rfd77402_powerdown(struct rfd77402_data *data)
+static int rfd77402_powerdown(struct i2c_client *client)
 {
-	return rfd77402_set_state(data, RFD77402_CMD_STANDBY,
+	return rfd77402_set_state(client, RFD77402_CMD_STANDBY,
 				  RFD77402_STATUS_STANDBY);
 }
 
@@ -280,7 +280,7 @@ static int rfd77402_probe(struct i2c_client *client,
 	indio_dev->name = RFD77402_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = rfd77402_init(data);
+	ret = rfd77402_init(client);
 	if (ret < 0)
 		return ret;
 
@@ -291,7 +291,7 @@ static int rfd77402_probe(struct i2c_client *client,
 	return 0;
 
 err_powerdown:
-	rfd77402_powerdown(data);
+	rfd77402_powerdown(client);
 	return ret;
 }
 
@@ -300,7 +300,7 @@ static int rfd77402_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
-	rfd77402_powerdown(iio_priv(indio_dev));
+	rfd77402_powerdown(client);
 
 	return 0;
 }
@@ -308,18 +308,12 @@ static int rfd77402_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int rfd77402_suspend(struct device *dev)
 {
-	struct rfd77402_data *data = iio_priv(i2c_get_clientdata(
-				     to_i2c_client(dev)));
-
-	return rfd77402_powerdown(data);
+	return rfd77402_powerdown(to_i2c_client(dev));
 }
 
 static int rfd77402_resume(struct device *dev)
 {
-	struct rfd77402_data *data = iio_priv(i2c_get_clientdata(
-				     to_i2c_client(dev)));
-
-	return rfd77402_init(data);
+	return rfd77402_init(to_i2c_client(dev));
 }
 #endif
 
-- 
2.31.1

