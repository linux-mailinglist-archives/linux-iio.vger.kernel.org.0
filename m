Return-Path: <linux-iio+bounces-24333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C81FB8DC44
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 15:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E40175A6B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFBD2D94B3;
	Sun, 21 Sep 2025 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Ve/H2d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB92D948D
	for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461683; cv=none; b=UQpVXLODNBFMCvuP8W/cJopL1Fxb1q2Zh86NQw/aG6ZNb2DpQXiZPE3VCRLeaJxc5sz+E0YjpuB4Sb3Tofwe8NL1fQRkR08oy6AJNiCawFuHgFWxxBsysURAOPpSkzM5LkiLPSyKj3Tl84R93vA/MayQRyigsqOnQDqrTLSpJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461683; c=relaxed/simple;
	bh=81jfElT+Uu1WsC22AV/IBz8+QoKa8HXMgzShHuOlkhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SY5NHOal/jFpbKr3QbNgRk5d4+x3ExftL+ECX4e0aZJC6x3bfFq7LDbtYFkTnN9KWlcW9d7wJNb3wvtfAyDnN8dtoGes1v4M3Y1rW2r0Wc4Sgz0XKQE80FpH083jXknj2BNVkCB5GJ+A3eArST2F0zIaOt1tk0gBz25IHW75ihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Ve/H2d; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso3449617f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758461680; x=1759066480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4HwlmQXbMGKR7EUm5AwWqhgJMTwfe32w2jF192UNyg=;
        b=U1Ve/H2d45wrChMbngHoIkzxbE00P1EcNiGGeQdvSvWKA7+A4NMG4Tp8lcZ1VDizVV
         3wfbD4bJ3gOc1fO5qzLtWT89yDaJtXn5NeG0SPyIV1iN0PwRrSCr2Z73bfaqWm9VVymZ
         KXgN+JShq+lP2pJ9sxoz3wxi+ixSIOfqaQOTkmn50WhufDAb+O2hQHFuWmjIPvCUFBAE
         SpJ9QQu/zACsubVU3DMayqfwXzeqddpJYF9yeiQcpCpaYGFEIjt7ACuHSegF8Cwt00j5
         4H5C6xRyQ59duv9qXewogznsBbjZ0efe3RUd2VvcbOAKh6RiteypD7z5RQ7xTyW48Gdx
         p41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758461680; x=1759066480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4HwlmQXbMGKR7EUm5AwWqhgJMTwfe32w2jF192UNyg=;
        b=agCRPYHwjGr8bwzDjQw+tv0Kx0iomPnMIq+PKmEAOYpDBrzSF/NC8fULGUQoKhL3xx
         H7MUs6PnQFJRPvmxjWrgoCig0zZJrpuSVm/rqmICdv6/JBimpfhgZyqdXyxOLCL3BxB9
         /O4Yw/74R7raXOwip0Mm4FctE7wbZDW+Eu9zPkesE2vNiJdxtOdie33y8UxaFyiX3Pna
         JvndPsszQB2KOZa2047rOq30fRpj+CaeIUKQmVqlUZplrr5rlTztLnuB61z2wPvgANrb
         OHqNm0xU1RkG1nHrXL/hFslKVaZqISVcgw4aIvJEAb80HGN6d/ZPVR2ab1LXrEBfcA3m
         0Rmw==
X-Forwarded-Encrypted: i=1; AJvYcCUcZtLmOJjHIQAIGnEhwsyPjRCQPrsASy1QjFH/8HTvCm1K7qKGZtNnDa5XvsNXlwaE+N7WpmXtChM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/f4F8q4J54Hzw2j5xY5gL8UW85BwVSdH6ht/HtJGwJ0mrN7xm
	hRKU95B2EycfOHDppW/lJPVoml3ZLxspQz20RSvy//HuyuYhPWt69wDO
X-Gm-Gg: ASbGncvk2BarhVUqRZWZYktg0CDFlyusZiguIIKFhV4D2g6QptR9qe4XZDQYreD8zhg
	EACFFJ9j1TQBnHsIrvspdw98pFg4JtMJ2mPiqbpVV1aQJsEbZBF5doNpL2ZiEPNx0vqWEM3aRRv
	2mLmtO5Rj+HCVI20Q/X0ExAUnnKZuNSr8xaUlvWy83pPgXVgJG/fHz7NuVfiXcqWOW3WPj1zwc4
	8lPeHs0ZsLnhbzguq223TJFwWmTWc8+dZcbLyR+y17YKVBjIcKOmoRIRZCfUqxZA5wDWi1XBs54
	QHeSAO0oIl4WUSFPd1PcdiR88+xX7QG2curyzE8KMQvQWOTdf1VmiSf1cscZNleR8HZKhfHspDY
	tIioY1DjfCrrCSFyqBR+jtZO7PXiqcTUFkRb7+rz1
X-Google-Smtp-Source: AGHT+IHxymcup0TT31CIxNxUqvMWlfeSKAfx8pWLhaixbhHmShmvxh0BXBBNLYKtGSGa8qXcFq0rMQ==
X-Received: by 2002:a5d:5d03:0:b0:3ec:4e41:fd86 with SMTP id ffacd0b85a97d-3ee86d6cf94mr7457394f8f.50.1758461679822;
        Sun, 21 Sep 2025 06:34:39 -0700 (PDT)
Received: from localhost.localdomain ([78.211.117.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fc00a92sm15910316f8f.63.2025.09.21.06.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:34:39 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 2/3] iio: mpl3115: add support for DRDY interrupt
Date: Sun, 21 Sep 2025 15:33:27 +0200
Message-Id: <20250921133327.123726-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250921133327.123726-1-apokusinski01@gmail.com>
References: <20250921133327.123726-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPL3115 sensor features a "data ready" interrupt which indicates the
presence of new measurements.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 167 ++++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 579da60ef441..cf34de8f0d7e 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -7,7 +7,7 @@
  * (7-bit I2C slave address 0x60)
  *
  * TODO: FIFO buffer, altimeter mode, oversampling, continuous mode,
- * interrupts, user offset correction, raw mode
+ * user offset correction, raw mode
  */
 
 #include <linux/module.h>
@@ -17,26 +17,45 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger.h>
 #include <linux/delay.h>
+#include <linux/property.h>
 
 #define MPL3115_STATUS 0x00
 #define MPL3115_OUT_PRESS 0x01 /* MSB first, 20 bit */
 #define MPL3115_OUT_TEMP 0x04 /* MSB first, 12 bit */
 #define MPL3115_WHO_AM_I 0x0c
+#define MPL3115_INT_SOURCE 0x12
+#define MPL3115_PT_DATA_CFG 0x13
 #define MPL3115_CTRL_REG1 0x26
+#define MPL3115_CTRL_REG3 0x28
+#define MPL3115_CTRL_REG4 0x29
+#define MPL3115_CTRL_REG5 0x2a
 
 #define MPL3115_DEVICE_ID 0xc4
 
 #define MPL3115_STATUS_PRESS_RDY BIT(2)
 #define MPL3115_STATUS_TEMP_RDY BIT(1)
 
+#define MPL3115_CTRL_INT_SRC_DRDY BIT(7)
+
+#define MPL3115_PT_DATA_EVENT_ALL (BIT(2) | BIT(1) | BIT(0))
+
 #define MPL3115_CTRL_RESET BIT(2) /* software reset */
 #define MPL3115_CTRL_OST BIT(1) /* initiate measurement */
 #define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
 #define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling */
 
+#define MPL3115_CTRL_IPOL1 BIT(5)
+#define MPL3115_CTRL_IPOL2 BIT(1)
+
+#define MPL3115_CTRL_INT_EN_DRDY BIT(7)
+
+#define MPL3115_CTRL_INT_CFG_DRDY BIT(7)
+
 struct mpl3115_data {
 	struct i2c_client *client;
+	struct iio_trigger *drdy_trig;
 	struct mutex lock;
 	u8 ctrl_reg1;
 };
@@ -164,10 +183,12 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	int ret, pos = 0;
 
 	mutex_lock(&data->lock);
-	ret = mpl3115_request(data);
-	if (ret < 0) {
-		mutex_unlock(&data->lock);
-		goto done;
+	if (!(data->ctrl_reg1 & MPL3115_CTRL_ACTIVE)) {
+		ret = mpl3115_request(data);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			goto done;
+		}
 	}
 
 	if (test_bit(0, indio_dev->active_scan_mask)) {
@@ -228,10 +249,142 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (!(ret & MPL3115_CTRL_INT_SRC_DRDY))
+		return IRQ_NONE;
+
+	iio_trigger_poll_nested(data->drdy_trig);
+
+	return IRQ_HANDLED;
+}
+
+static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 ctrl_reg1 = data->ctrl_reg1;
+
+	if (state)
+		ctrl_reg1 |= MPL3115_CTRL_ACTIVE;
+	else
+		ctrl_reg1 &= ~MPL3115_CTRL_ACTIVE;
+
+	guard(mutex)(&data->lock);
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+					ctrl_reg1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
+					state ? MPL3115_CTRL_INT_EN_DRDY : 0);
+	if (ret < 0)
+		goto reg1_cleanup;
+
+	data->ctrl_reg1 = ctrl_reg1;
+
+	return 0;
+
+reg1_cleanup:
+	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+				  data->ctrl_reg1);
+	return ret;
+}
+
+static const struct iio_trigger_ops mpl3115_trigger_ops = {
+	.set_trigger_state = mpl3115_set_trigger_state,
+};
+
 static const struct iio_info mpl3115_info = {
 	.read_raw = &mpl3115_read_raw,
 };
 
+static int mpl3115_trigger_probe(struct mpl3115_data *data,
+				 struct iio_dev *indio_dev)
+{
+	struct fwnode_handle *fwnode;
+	int ret, irq, irq_type;
+	bool act_high, is_int2 = false;
+
+	fwnode = dev_fwnode(&data->client->dev);
+	if (!fwnode)
+		return -ENODEV;
+
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq < 0) {
+		irq = fwnode_irq_get_byname(fwnode, "INT2");
+		if (irq < 0)
+			return 0;
+
+		is_int2 = true;
+	}
+
+	irq_type = irq_get_trigger_type(irq);
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+		act_high = true;
+		break;
+	case IRQF_TRIGGER_FALLING:
+		act_high = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_PT_DATA_CFG,
+					MPL3115_PT_DATA_EVENT_ALL);
+	if (ret < 0)
+		return ret;
+
+	if (!is_int2) {
+		ret = i2c_smbus_write_byte_data(data->client,
+						MPL3115_CTRL_REG5,
+						MPL3115_CTRL_INT_CFG_DRDY);
+		if (ret)
+			return ret;
+	}
+	if (act_high) {
+		ret = i2c_smbus_write_byte_data(data->client,
+						MPL3115_CTRL_REG3,
+						is_int2 ? MPL3115_CTRL_IPOL2 :
+							  MPL3115_CTRL_IPOL1);
+		if (ret)
+			return ret;
+	}
+
+	data->drdy_trig = devm_iio_trigger_alloc(&data->client->dev,
+						 "%s-dev%d",
+						 indio_dev->name,
+						 iio_device_id(indio_dev));
+	if (!data->drdy_trig)
+		return -ENOMEM;
+
+	data->drdy_trig->ops = &mpl3115_trigger_ops;
+	iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
+	ret = iio_trigger_register(data->drdy_trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(data->drdy_trig);
+
+	return devm_request_threaded_irq(&data->client->dev, irq,
+					 NULL,
+					 mpl3115_interrupt_handler,
+					 IRQF_ONESHOT,
+					 "mpl3115_irq",
+					 indio_dev);
+}
+
 static int mpl3115_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -271,6 +424,10 @@ static int mpl3115_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = mpl3115_trigger_probe(data, indio_dev);
+	if (ret)
+		return ret;
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		mpl3115_trigger_handler, NULL);
 	if (ret < 0)
-- 
2.25.1


