Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763C626407D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIJIst (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgIJIso (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 04:48:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B575C061573
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2020 01:48:43 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id k25so7083296ljg.9
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2020 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HyPjrOGIRH7vR7cIV2XAaaVh1v08Dx1vkQ14BANSmL4=;
        b=MvCEwuZZuoWIMHfnZJrAVXDiS+GwhScIOEO6NP4cPXWAImJpMfaUvHX+DewKesZ/M1
         V77d6aBCVNYOsIC4FlhybtjrEUGVG4osOSWeF/4pgq9VnQ3Msm+Om04b5UgXmuUSOHBf
         Ni4xloiObB8ji560LUizYacSlgaYed7FqiChguEQDaJlwDx0urWF5qQZQMlFXwiZNGkb
         ty4QNiElMo6UAGMAh5ARTfrBYG2Mkm96BBqpHvLVaUetypsM10mqesKWITpxz7ukG2zT
         gQyjZOSLjvNY3nI41ucW2G4sbTxx0DYtk1m37O9DNg6CtkH7e0+IKprSvr9Y0IT44Z/7
         m7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyPjrOGIRH7vR7cIV2XAaaVh1v08Dx1vkQ14BANSmL4=;
        b=Ue2NsuNRJkwuQN1ypK1ly+wgKgM03+ZiFwXw4uOTt/WcUFZGlCoyFry7ltj8YWLjyp
         UgIYc6bKIF7EioTOC/gwXZWS7Rf/vg/To3MGNYJHwaemdgAisrhQTnv0bGbH0ZMLbLrv
         JiMGJd801gPjHAVHbOdQgDcLylnJNLg4UvoISOuZf0XgnWAt8JxhFpCXOqmV1102idwI
         XNrBdao1msWGDhVvYg/TyqyBi0KuaBlHXCJEasFrXmG05QwZ9xfFSCmFv2CuQWUeZcng
         rlLmAv9aoKdINa2M1wuxS5m3/J1PX3t1QCExBus7CLZ42IwODrsIJH8MxKdfOoJUz1QC
         cXmg==
X-Gm-Message-State: AOAM530LvDTmY/iHs8aLGgD6qsfoe0yt6qQhrQ5j6kEIMOJm3p+p/SNy
        z23T7AE/I216ld3/rzhOuNsR75PBdhcfdntu
X-Google-Smtp-Source: ABdhPJyG9GUmV5qnt5pRhe1sAELgJQV61Bv+368D6K7ykL2Mn5mi4O0qWw+PqaCDnTIasLTU7RxEEQ==
X-Received: by 2002:a2e:3210:: with SMTP id y16mr4058758ljy.417.1599727719923;
        Thu, 10 Sep 2020 01:48:39 -0700 (PDT)
Received: from localhost.localdomain ([193.201.216.229])
        by smtp.gmail.com with ESMTPSA id u9sm1131500lju.95.2020.09.10.01.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:48:39 -0700 (PDT)
From:   Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     songqiang1304521@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Subject: [PATCH 2/2] iio: proximity: vl53l0x: Add IRQ support
Date:   Thu, 10 Sep 2020 11:48:17 +0300
Message-Id: <20200910084817.209131-2-drobyshevskyi@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200910084817.209131-1-drobyshevskyi@gmail.com>
References: <20200910084817.209131-1-drobyshevskyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

VL53L0X can be configured to use interrupt pin (GPIO1)
to notify host about readiness of new measurement.

If interrupt pin is not specified in DT, driver still uses polling.

Signed-off-by: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 104 ++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index b48216cc1..b676e3702 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -4,19 +4,21 @@
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
+#include <linux/of_irq.h>
 
 #include <linux/iio/iio.h>
 
@@ -29,14 +31,67 @@
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
-	struct i2c_client *client;
+	struct i2c_client	*client;
+	struct completion	completion;
+	int			irq;
 };
 
+static irqreturn_t vl53l0x_handle_irq(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+
+	complete(&data->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int vl53l0x_configure_irq(struct device *dev, struct iio_dev *indio_dev)
+{
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = devm_request_irq(dev, data->irq, vl53l0x_handle_irq,
+			IRQF_TRIGGER_FALLING, indio_dev->name, indio_dev);
+	if (ret) {
+		dev_err(dev, "devm_request_irq error: %d\n", ret);
+		return ret;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client,
+			VL_REG_SYSTEM_INTERRUPT_CONFIG_GPIO,
+			VL_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
+	if (ret)
+		dev_err(dev, "failed to configure IRQ: %d\n", ret);
+
+	return ret;
+}
+
+static void vl53l0x_clear_irq(struct vl53l0x_data *data)
+{
+	u8 status;
+
+	i2c_smbus_write_byte_data(data->client,
+					VL_REG_SYSTEM_INTERRUPT_CLEAR, 1);
+	i2c_smbus_write_byte_data(data->client,
+					VL_REG_SYSTEM_INTERRUPT_CLEAR, 0);
+
+	status = i2c_smbus_read_byte_data(data->client,
+						VL_REG_RESULT_INT_STATUS);
+	if (status & 0x07)
+		dev_err(&data->client->dev, "failed to clear irq\n");
+}
+
 static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 				  const struct iio_chan_spec *chan,
 				  int *val)
@@ -50,19 +105,31 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 	if (ret < 0)
 		return ret;
 
-	do {
-		ret = i2c_smbus_read_byte_data(client,
-					       VL_REG_RESULT_RANGE_STATUS);
+	if (data->irq) {
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
+
+			if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
+				break;
 
-		usleep_range(1000, 5000);
-	} while (--tries);
-	if (!tries)
-		return -ETIMEDOUT;
+			usleep_range(1000, 5000);
+		} while (--tries);
+		if (!tries)
+			return -ETIMEDOUT;
+	}
 
 	ret = i2c_smbus_read_i2c_block_data(client, VL_REG_RESULT_RANGE_STATUS,
 					    12, buffer);
@@ -120,6 +187,7 @@ static int vl53l0x_probe(struct i2c_client *client)
 {
 	struct vl53l0x_data *data;
 	struct iio_dev *indio_dev;
+	struct device *dev = &client->dev;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -141,6 +209,18 @@ static int vl53l0x_probe(struct i2c_client *client)
 	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	data->irq = irq_of_parse_and_map(dev->of_node, 0);
+	/* usage of interrupt is optional */
+	if (data->irq) {
+		int ret;
+
+		init_completion(&data->completion);
+
+		ret = vl53l0x_configure_irq(dev, indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.26.0

