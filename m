Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D526BE70
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIPHpl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 03:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgIPHpj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 03:45:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1206AC06174A
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2020 00:45:39 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x69so5920070lff.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2020 00:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9qIv3P/9a7ycxlsj+59N5vCClSShV8EKMZIfaSc7p2c=;
        b=WFlRZwiMyE0EVRrs7UHyo+/4qfHmVTjWtVLDeSbVDwRd7nbGFhIEgt/ypARKRwlcpt
         Dw6QP1w2m9u/cAQ6+K2hxM03RF2QX5E35o+R4eJjb6vMUm7l/XsaTjPA/xEyI210gwb1
         N2oX23UVi6BTvoBGxZCWptGKO3cFOmLGM6X1O9a++zFVIDUm+ZAsT5foJrouhTn3dPbM
         1tdoFZSjnb9GAhwbFD20uxpJJdW7VEzrqTh4C/u2gUx0eUUw7Y7fW+hFPtN/ia9CjxrH
         BXCK8G25fMfPzM/aP42LOcSuxSRVocps0LOsm2KPOwwqOTkszhx0S0RCuO4rp72lsibe
         9hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9qIv3P/9a7ycxlsj+59N5vCClSShV8EKMZIfaSc7p2c=;
        b=a2rsmKDm3+D0ADIKAHKJEZNSPphb6kKgH/pKW5Q18NnF3LQcdyT2LNwwlHuW0+mULc
         7AdTWOzzjHAuZ2/ie8cKJsigynYcYVpUkr7YvbU1RDmeMcNhleyV65im/KWctkwYwREX
         8T4uMd6hJ5RpWfScrQsxexjFG5vb7DtxMBGmbNV50H+1tyY2QXt/LUtZurjmAWqnXuVU
         3JVXVwJUEvdBfgQcbv1+j/W0v8DLady01mvZmgFWhOvl7yPZOOqXz8pRn/OHY7snNMUH
         SaZqkfV9Nq0Ec66SjsPfZxLTog5FpRr9zHaCrNSiSNaMlo8qLkZvAtO6X/W4ZltKPcWm
         CZhQ==
X-Gm-Message-State: AOAM531c54Ut/4KcVaSRshEyEoc90fATv6rtYrtCBAx7yYTf7r8rmIzH
        rF+N1mWT7C+jKVL927+5f9E6HtlGRZ68NHL9
X-Google-Smtp-Source: ABdhPJw/oqlA9NOzWq8+9dw5aN/biEWZiVLsbdkOTv3psrI2wVTa3S3R23+0YFSQTuUSZGzBM/0Tog==
X-Received: by 2002:a05:6512:1142:: with SMTP id m2mr6799144lfg.22.1600242337279;
        Wed, 16 Sep 2020 00:45:37 -0700 (PDT)
Received: from localhost.localdomain ([193.201.216.203])
        by smtp.gmail.com with ESMTPSA id t2sm4442845lff.157.2020.09.16.00.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 00:45:36 -0700 (PDT)
From:   Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     songqiang1304521@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Subject: [PATCH v2 2/2] iio: proximity: vl53l0x: Add IRQ support
Date:   Wed, 16 Sep 2020 10:44:58 +0300
Message-Id: <20200916074458.873359-2-drobyshevskyi@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200916074458.873359-1-drobyshevskyi@gmail.com>
References: <20200913113357.47e0c0a1@archlinux>
 <20200916074458.873359-1-drobyshevskyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

VL53L0X can be configured to use interrupt pin (GPIO1)
to notify host about readiness of new measurement.

If interrupt pin is not specified, driver still uses polling.

Signed-off-by: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
---
changes since v1:
 - remove explicit DT parsing for IRQ number, reuse i2c_client's irq
 - add checking of i2c_smbus_write_byte_data return value
 - fix checking of i2c_smbus_read_byte_data return value
 - other styling/cosmetic changes as suggested by Jonathan

 drivers/iio/proximity/vl53l0x-i2c.c | 104 +++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index b48216cc1..e92a0bf79 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -4,18 +4,19 @@
  *
  * Copyright (C) 2016 STMicroelectronics Imaging Division.
  * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
+ * Copyright (C) 2020 Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
  *
  * Datasheet available at
  * <https://www.st.com/resource/en/datasheet/vl53l0x.pdf>
  *
  * Default 7-bit i2c slave address 0x29.
  *
- * TODO: FIFO buffer, continuous mode, interrupts, range selection,
- * sensor ID check.
+ * TODO: FIFO buffer, continuous mode, range selection, sensor ID check.
  */
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
@@ -29,14 +30,72 @@
 #define VL_REG_SYSRANGE_MODE_TIMED			BIT(2)
 #define VL_REG_SYSRANGE_MODE_HISTOGRAM			BIT(3)
 
+#define VL_REG_SYSTEM_INTERRUPT_CONFIG_GPIO		0x0A
+#define VL_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY	BIT(2)
+
+#define VL_REG_SYSTEM_INTERRUPT_CLEAR			0x0B
+
 #define VL_REG_RESULT_INT_STATUS			0x13
 #define VL_REG_RESULT_RANGE_STATUS			0x14
 #define VL_REG_RESULT_RANGE_STATUS_COMPLETE		BIT(0)
 
 struct vl53l0x_data {
 	struct i2c_client *client;
+	struct completion completion;
 };
 
+static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
+{
+	struct iio_dev *indio_dev = priv;
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+
+	complete(&data->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int vl53l0x_configure_irq(struct i2c_client *client,
+				 struct iio_dev *indio_dev)
+{
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = devm_request_irq(&client->dev, client->irq, vl53l0x_handle_irq,
+			IRQF_TRIGGER_FALLING, indio_dev->name, indio_dev);
+	if (ret) {
+		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
+		return ret;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client,
+			VL_REG_SYSTEM_INTERRUPT_CONFIG_GPIO,
+			VL_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
+	if (ret < 0)
+		dev_err(&client->dev, "failed to configure IRQ: %d\n", ret);
+
+	return ret;
+}
+
+static void vl53l0x_clear_irq(struct vl53l0x_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					VL_REG_SYSTEM_INTERRUPT_CLEAR, 1);
+	if (ret < 0)
+		dev_err(dev, "failed to clear error irq: %d\n", ret);
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					VL_REG_SYSTEM_INTERRUPT_CLEAR, 0);
+	if (ret < 0)
+		dev_err(dev, "failed to clear range irq: %d\n", ret);
+
+	ret = i2c_smbus_read_byte_data(data->client, VL_REG_RESULT_INT_STATUS);
+	if (ret < 0 || ret & 0x07)
+		dev_err(dev, "failed to clear irq: %d\n", ret);
+}
+
 static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 				  const struct iio_chan_spec *chan,
 				  int *val)
@@ -50,19 +109,31 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 	if (ret < 0)
 		return ret;
 
-	do {
-		ret = i2c_smbus_read_byte_data(client,
-					       VL_REG_RESULT_RANGE_STATUS);
+	if (data->client->irq) {
+		reinit_completion(&data->completion);
+
+		ret = wait_for_completion_timeout(&data->completion, HZ/10);
 		if (ret < 0)
 			return ret;
+		else if (ret == 0)
+			return -ETIMEDOUT;
 
-		if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
-			break;
+		vl53l0x_clear_irq(data);
+	} else {
+		do {
+			ret = i2c_smbus_read_byte_data(client,
+					       VL_REG_RESULT_RANGE_STATUS);
+			if (ret < 0)
+				return ret;
 
-		usleep_range(1000, 5000);
-	} while (--tries);
-	if (!tries)
-		return -ETIMEDOUT;
+			if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
+				break;
+
+			usleep_range(1000, 5000);
+		} while (--tries);
+		if (!tries)
+			return -ETIMEDOUT;
+	}
 
 	ret = i2c_smbus_read_i2c_block_data(client, VL_REG_RESULT_RANGE_STATUS,
 					    12, buffer);
@@ -141,6 +212,17 @@ static int vl53l0x_probe(struct i2c_client *client)
 	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	/* usage of interrupt is optional */
+	if (client->irq) {
+		int ret;
+
+		init_completion(&data->completion);
+
+		ret = vl53l0x_configure_irq(client, indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.26.0

