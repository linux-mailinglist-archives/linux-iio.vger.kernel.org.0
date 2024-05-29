Return-Path: <linux-iio+bounces-5416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0FF8D295A
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 02:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918391F25557
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 00:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CC6E552;
	Wed, 29 May 2024 00:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWuY/xk4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926DDDAB;
	Wed, 29 May 2024 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941724; cv=none; b=StDozf5rkbBwvrjTWcQUTOZe7FHGqR90SBOYJKA8Ja/mxOku5T3ShEAt4m0tZg2++1dTD9w1ASyXTDHHofrjoVDZiDz2fpNb8UmKh6TLTwrLJOdcBymhe4QHlHqoXnk0AQZq3Flb/Ny1pj5Kqk8+Itc1JoxAkjKbLIE2DLSb3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941724; c=relaxed/simple;
	bh=pM5JtpMIhFsrfOUykyidhfQIhYMu2P8fjbRkZeC7Qvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqeeDueAUfiTmHy0Nl9C45YKBaiKkCB17CbrA3hsmsyMsdiTi7VmlFclDcHVXmuK21Lew1Rc9hc6493Bz63VCjthEJed71AY1THRCMCnD+kTI/EIOLRRTfds9ayOiJSFFRvAqAfCk8guc8kxk7u6iOoDeZFv33PfughlD0Spz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWuY/xk4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f8eba8dcfcso1170139b3a.3;
        Tue, 28 May 2024 17:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716941722; x=1717546522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11h33bFGPY8PKHn8okMQNZ5Dqfl8yEakMmTNyggCBv8=;
        b=XWuY/xk4HlVJDAwhAId5JXZKKM2WHoWLirHihpA1mrPWO9b/Nu6vrZTzK/WhfL7Nqt
         w+nYlDg1lC1oXdksXCQyr/Vn6Fnc8SHHmhujA1jBeU2R4oJRYUh9Vw0ampBc7r6zU2ru
         /LxWoTbA7/6xawPirnyXhJQ/Oyb+JRBH3l4Ly+vtqsuETGs7S0oPHnhryIgpfHAkndTX
         8JG9rExyNVUIVCnx3VmfIfZRywV6QRHGH4SBXzcRqH7/WgUvZqxHgeabZu5HJ9INpm0l
         Yn7ha8uycGSFcQLeztyjPIO2BSuwRMHdbhAxo0fi2iNJS6wA7gDVk1XYVZ87AFRFjt/d
         kgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716941722; x=1717546522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11h33bFGPY8PKHn8okMQNZ5Dqfl8yEakMmTNyggCBv8=;
        b=jQcXqS0ylZFFtBe44gyjzrlGRioc5YGJ9TaRjaC3snBtUeqJZ/aeuF9vihFs0vYLkJ
         twoj1lkpQ9LGIJp3qTIu9y6YOHUFI03xKEIr3FOv5oX+IBCXz7dqzbou+wdaC23PtYPd
         SuNQxzSGgGC5fW3gYyFeEydIMCD7GerGV2J7hnz1k2xYTD07ldvxaprI4NtMuPJmIs3w
         cBDwlOtDBup9ccVF9pQ9J66gYoLlMMYM3R3pHgvndmIorMUfca+VTljPZU/9WIfhu4H0
         Wuzvo71afMqY9EOj6/TuEA/HS1qa8/FAMoowHa2zlVLNffTHnhePEicRmBLouD1Yu74T
         wCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Vtt4n0xkKivb1o080mBs7JpRgKjD+qFrYjxrWoWvQxiDhTTGKA9gfZkrz+U4VX5bYMKMgVqTW7wvYY1hk4Ia+zSChU+031V/9aFkk5WgMLYPioQwX9xTxj+oS66rdspN+QvyBCaCHqOnWaKJbhtSkkDe7HPiQvDEpeCTP8W2AoC7Yg==
X-Gm-Message-State: AOJu0YzzxT80dt58LfUFgkZlPnQSn9Jk+g/X4l8M3DGfXOCuf1yv6k41
	Xy0I5sJugeDKZvquJRgwJ9EBjdZB28bwloGL9GI70/ikm4GLw8ENMP+0MVCPqvk=
X-Google-Smtp-Source: AGHT+IFnNhaNVtTqwUzY+M93uep+B7Jd3zXvDIfM0Qxd50NKyyAit1+2feE4nYWCKBLCEeNJDaIkbQ==
X-Received: by 2002:a05:6a20:9684:b0:1a9:5b3f:f139 with SMTP id adf61e73a8af0-1b212d33064mr13774547637.25.1716941722452;
        Tue, 28 May 2024 17:15:22 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3dea2sm6941433b3a.24.2024.05.28.17.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 17:15:22 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] iio: chemical: ens160: add triggered buffer support
Date: Tue, 28 May 2024 21:14:21 -0300
Message-ID: <20240529001504.33648-4-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529001504.33648-1-gustavograzs@gmail.com>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ENS160 supports a data ready interrupt. Use it in combination with
triggered buffer for continuous data readings.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
changes in v2:
 - Remove copy of irq variable in device private data. Pass the variable
   directly to the required functions
 - Remove IRQ direction from irqflags in devm_request_threaded_irq()
   call
 - Use iio_trigger_generic_data_rdy_poll instead of custom irq handler
 - In the trigger handler, bulk read all the channels
 drivers/iio/chemical/ens160.h      |   2 +-
 drivers/iio/chemical/ens160_core.c | 144 ++++++++++++++++++++++++++---
 drivers/iio/chemical/ens160_i2c.c  |   3 +-
 drivers/iio/chemical/ens160_spi.c  |   3 +-
 4 files changed, 138 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/chemical/ens160.h b/drivers/iio/chemical/ens160.h
index d0df15f08..e6cc0987a 100644
--- a/drivers/iio/chemical/ens160.h
+++ b/drivers/iio/chemical/ens160.h
@@ -2,6 +2,6 @@
 #ifndef ENS160_H_
 #define ENS160_H_
 
-int devm_ens160_core_probe(struct device *dev, struct regmap *regmap,
+int devm_ens160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			   const char *name);
 #endif
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index a535f62c4..74ef7f150 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -10,6 +10,9 @@
 
 #include <linux/bitfield.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
@@ -19,9 +22,14 @@
 
 #define ENS160_BOOTING_TIME_MS 10U
 
-#define ENS160_REG_PART_ID	0x00
+#define ENS160_REG_PART_ID		0x00
 
-#define ENS160_REG_OPMODE	0x10
+#define ENS160_REG_OPMODE		0x10
+
+#define ENS160_REG_CONFIG		0x11
+#define ENS160_REG_CONFIG_INTEN		BIT(0)
+#define ENS160_REG_CONFIG_INTDAT	BIT(1)
+#define ENS160_REG_CONFIG_INT_CFG	BIT(5)
 
 #define ENS160_REG_MODE_DEEP_SLEEP	0x00
 #define ENS160_REG_MODE_IDLE		0x01
@@ -48,7 +56,12 @@
 
 struct ens160_data {
 	struct regmap *regmap;
-	u8 fw_version[3] __aligned(IIO_DMA_MINALIGN);
+	struct mutex mutex;
+	struct {
+		__le16 chans[2];
+		s64 timestamp __aligned(8);
+	} scan __aligned(IIO_DMA_MINALIGN);
+	u8 fw_version[3];
 	__le16 buf;
 };
 
@@ -60,6 +73,13 @@ static const struct iio_chan_spec ens160_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.address = ENS160_REG_DATA_TVOC,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
 	},
 	{
 		.type = IIO_CONCENTRATION,
@@ -68,7 +88,15 @@ static const struct iio_chan_spec ens160_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.address = ENS160_REG_DATA_ECO2,
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static int ens160_read_raw(struct iio_dev *indio_dev,
@@ -80,13 +108,16 @@ static int ens160_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = regmap_bulk_read(data->regmap, chan->address,
-					&data->buf, sizeof(data->buf));
-		if (ret)
-			return ret;
-		*val = le16_to_cpu(data->buf);
-		return IIO_VAL_INT;
-
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			guard(mutex)(&data->mutex);
+			ret = regmap_bulk_read(data->regmap, chan->address,
+					       &data->buf, sizeof(data->buf));
+			if (ret)
+				return ret;
+			*val = le16_to_cpu(data->buf);
+			return IIO_VAL_INT;
+		}
+		unreachable();
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->channel2) {
 		case IIO_MOD_CO2:
@@ -184,7 +215,83 @@ static const struct iio_info ens160_info = {
 	.read_raw = ens160_read_raw,
 };
 
-int devm_ens160_core_probe(struct device *dev, struct regmap *regmap,
+static irqreturn_t ens160_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ens160_data *data = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&data->mutex);
+
+	ret = regmap_bulk_read(data->regmap, ENS160_REG_DATA_TVOC,
+			       data->scan.chans, sizeof(data->scan.chans));
+	if (ret)
+		goto err;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+					   pf->timestamp);
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ens160_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct ens160_data *data = iio_priv(indio_dev);
+	unsigned int int_bits = ENS160_REG_CONFIG_INTEN |
+				ENS160_REG_CONFIG_INTDAT |
+				ENS160_REG_CONFIG_INT_CFG;
+
+	if (state)
+		return regmap_set_bits(data->regmap, ENS160_REG_CONFIG,
+				       int_bits);
+	else
+		return regmap_clear_bits(data->regmap, ENS160_REG_CONFIG,
+					 int_bits);
+}
+
+static const struct iio_trigger_ops ens160_trigger_ops = {
+	.set_trigger_state = ens160_set_trigger_state,
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int ens160_setup_trigger(struct iio_dev *indio_dev, int irq)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_trigger *trig;
+	int ret;
+
+	trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+				      iio_device_id(indio_dev));
+	if (!trig)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to allocate trigger\n");
+
+	trig->ops = &ens160_trigger_ops;
+	iio_trigger_set_drvdata(trig, indio_dev);
+
+	ret = devm_iio_trigger_register(dev, trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(trig);
+
+	ret = devm_request_threaded_irq(dev, irq,
+					iio_trigger_generic_data_rdy_poll,
+					NULL,
+					IRQF_ONESHOT,
+					indio_dev->name,
+					indio_dev->trig);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq\n");
+
+	return 0;
+}
+
+int devm_ens160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			   const char *name)
 {
 	struct ens160_data *data;
@@ -204,6 +311,13 @@ int devm_ens160_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->channels = ens160_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
 
+	if (irq > 0) {
+		ret = ens160_setup_trigger(indio_dev, irq);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to setup trigger\n");
+	}
+
 	ret = devm_add_action_or_reset(dev, ens160_set_idle, data);
 	if (ret)
 		return ret;
@@ -212,6 +326,14 @@ int devm_ens160_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return dev_err_probe(dev, ret, "chip initialization failed\n");
 
+	mutex_init(&data->mutex);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ens160_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS(devm_ens160_core_probe, IIO_ENS160);
diff --git a/drivers/iio/chemical/ens160_i2c.c b/drivers/iio/chemical/ens160_i2c.c
index 2f0b08e52..4bf3c455c 100644
--- a/drivers/iio/chemical/ens160_i2c.c
+++ b/drivers/iio/chemical/ens160_i2c.c
@@ -29,7 +29,8 @@ static int ens160_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(regmap),
 				     "Failed to register i2c regmap\n");
 
-	return devm_ens160_core_probe(&client->dev, regmap, "ens160_i2c");
+	return devm_ens160_core_probe(&client->dev, regmap, client->irq,
+				      "ens160_i2c");
 }
 
 static const struct i2c_device_id ens160_i2c_id[] = {
diff --git a/drivers/iio/chemical/ens160_spi.c b/drivers/iio/chemical/ens160_spi.c
index 9a6c9c7e3..91528c5e3 100644
--- a/drivers/iio/chemical/ens160_spi.c
+++ b/drivers/iio/chemical/ens160_spi.c
@@ -29,7 +29,8 @@ static int ens160_spi_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
 				     "Failed to register spi regmap\n");
 
-	return devm_ens160_core_probe(&spi->dev, regmap, "ens160_spi");
+	return devm_ens160_core_probe(&spi->dev, regmap, spi->irq,
+				      "ens160_spi");
 }
 
 static const struct of_device_id ens160_spi_of_match[] = {
-- 
2.45.1


