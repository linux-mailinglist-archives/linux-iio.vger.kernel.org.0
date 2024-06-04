Return-Path: <linux-iio+bounces-5798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC298FBF69
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E16284DBA
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5014E2E2;
	Tue,  4 Jun 2024 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PblS7wNn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387414D2BF;
	Tue,  4 Jun 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541897; cv=none; b=Ux35umYoRDTPdUhwwiB5C7dwwKLBkiSM9MWvJqEXDvBhlkcrC7QoXoT1CFmQ5IMjF81wJSOEY8isHwEh0w3WrDjr62G59Rxcoc4fJH5c5Npnp4wTDTxkp2rO6mcdiVlF3OLVVzkHu6+4HX0kHzXJVlCiaR4mxrlMuTFOcVMBXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541897; c=relaxed/simple;
	bh=hBFRhU9jLcFXzLrq8iR9NyRX1lGd8Edes/2I6DiNTKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGf9JxWw4DGVgoCjlZFs9wrccBtTwHRkJ5jt4L9fCzEZ+3VyGVrkGiPK0+G+bHKsQsl3tRXAdb8LxqGN9j7P6lA8ZfGEqjh/eV8Wj8U8f+KUul2lDybXIy7lL20N24hJHF3HJbTI4zsQYD/VdrVHp3xAr/CHUkPPG6dYUdwheM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PblS7wNn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-702621d8725so3493918b3a.0;
        Tue, 04 Jun 2024 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717541895; x=1718146695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5+ZBH+n5A7gbuFFgRz4H/jOIhRg+AiCgR/DWUt6Km0=;
        b=PblS7wNnXC6mPQtCs5ndTf8A3b85p1cREoeKGPQygYAUuqN1UK52bBbSv4zxFxHsg8
         tsUfMgz03hOKIARdc1jUdpY/BNVTBpHU8udgfjTMnCX1TPGPtGYQ6XTyV/6OBEzAXwvx
         AHL7eG7lHjJE5YP/tn5y2jAt7cS24K237A4jfu3/jSCJA0d+oLz0eQZhm7jKK+Cs6RnA
         E+dIkFLbKwNMNbUOslwrm25TW4f3iEaDc47JhsjMHVq30F39A2YPb8iv7Hk86vLgMZYc
         yn0CAzK7pZ2rjI/C1EmenUpdCil31+q1S5hqHW9+zj5JYG8tkBl76AEmLVbnnhVpice3
         c03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541895; x=1718146695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5+ZBH+n5A7gbuFFgRz4H/jOIhRg+AiCgR/DWUt6Km0=;
        b=cg4sY2dpxo1G+kOZI+vdNvaBbEhoVBvSFKqcu6l+Co30D4/6m/XL7FBcDAV/taGHy1
         Wtt5W6ckCFvT8jDazClFSWbqbu287pFHNuYrGAGXUdZUdbk44knIyXKQPVGDyFm1Btxc
         hNyuC2/e+UsUqt/vavV02uv+PGkXxshC79P3jvPwolVgHxOUExRCV1+p228SkFnzDFrk
         EG/XkU4tmsTtfV7nc3GnMNTjRRErvSOW/cLIGZ+KALCK5vbikMnBuBBOpFP4Jku3BQ71
         RtbSUn3e93XM9UT90Q+GfdvMTu5Ag2hDdqh4VQTu4vAYsZux7qAxvYS85braxfPJICkS
         VoAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRq0FlGGBv/KOpJtqALAPlFYi4oFEqQ4Pe6X4sJ7VnFb1HF0zprx3fn7whgHDBe0qzVGkriTKAoFGzew7WA3DnbVUa9rAjt/kRwu+HS+9d46LISoRawrZjmg0JN88SSFPXVBPdZnf8Ae01q12o5bXv2AxeRQ7NNhdvCs0khvmT6OJ5mQ==
X-Gm-Message-State: AOJu0YxzWe3RRYoWDVMSG7zfXqqpYQTInjR4jvQISlBdZxSuXjalUdMd
	r0sy5YiB38X+XFNtaG7hYqretDKvSl3ys6OCV3GyjTslxOqND/1j
X-Google-Smtp-Source: AGHT+IHob8PqrCO2BuCFNMAtSUeLtAyaT6/H0QCdrriHfaaGmvF56ImsIM41kmirG4MYpUkq6AhB2Q==
X-Received: by 2002:a05:6a20:3c90:b0:1b1:d2a5:c7b1 with SMTP id adf61e73a8af0-1b2b713c6d7mr1256111637.49.1717541894917;
        Tue, 04 Jun 2024 15:58:14 -0700 (PDT)
Received: from localhost.localdomain ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025a955dd1sm5312125b3a.64.2024.06.04.15.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:58:14 -0700 (PDT)
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
Subject: [PATCH v3 4/6] iio: chemical: ens160: add triggered buffer support
Date: Tue,  4 Jun 2024 19:57:28 -0300
Message-ID: <20240604225747.7212-5-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604225747.7212-1-gustavograzs@gmail.com>
References: <20240604225747.7212-1-gustavograzs@gmail.com>
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
 drivers/iio/chemical/ens160.h      |   2 +-
 drivers/iio/chemical/ens160_core.c | 141 +++++++++++++++++++++++++++--
 drivers/iio/chemical/ens160_i2c.c  |   3 +-
 drivers/iio/chemical/ens160_spi.c  |   2 +-
 4 files changed, 136 insertions(+), 12 deletions(-)

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
index ae99a95c6..3da3b1095 100644
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
 
@@ -23,6 +26,11 @@
 
 #define ENS160_REG_OPMODE		0x10
 
+#define ENS160_REG_CONFIG		0x11
+#define ENS160_REG_CONFIG_INTEN		BIT(0)
+#define ENS160_REG_CONFIG_INTDAT	BIT(1)
+#define ENS160_REG_CONFIG_INT_CFG	BIT(5)
+
 #define ENS160_REG_MODE_DEEP_SLEEP	0x00
 #define ENS160_REG_MODE_IDLE		0x01
 #define ENS160_REG_MODE_STANDARD	0x02
@@ -48,7 +56,13 @@
 
 struct ens160_data {
 	struct regmap *regmap;
-	u8 fw_version[3] __aligned(IIO_DMA_MINALIGN);
+	/* Protect reads from the sensor */
+	struct mutex mutex;
+	struct {
+		__le16 chans[2];
+		s64 timestamp __aligned(8);
+	} scan __aligned(IIO_DMA_MINALIGN);
+	u8 fw_version[3];
 	__le16 buf;
 };
 
@@ -60,6 +74,13 @@ static const struct iio_chan_spec ens160_channels[] = {
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
@@ -68,7 +89,15 @@ static const struct iio_chan_spec ens160_channels[] = {
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
@@ -80,13 +109,16 @@ static int ens160_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = regmap_bulk_read(data->regmap, chan->address,
-				       &data->buf, sizeof(data->buf));
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
@@ -188,7 +220,83 @@ static const struct iio_info ens160_info = {
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
@@ -208,10 +316,25 @@ int devm_ens160_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->channels = ens160_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
 
+	if (irq > 0) {
+		ret = ens160_setup_trigger(indio_dev, irq);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to setup trigger\n");
+	}
+
 	ret = ens160_chip_init(data);
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
index f885903fe..f3fb45b75 100644
--- a/drivers/iio/chemical/ens160_i2c.c
+++ b/drivers/iio/chemical/ens160_i2c.c
@@ -29,7 +29,8 @@ static int ens160_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(regmap),
 				     "Failed to register i2c regmap\n");
 
-	return devm_ens160_core_probe(&client->dev, regmap, "ens160");
+	return devm_ens160_core_probe(&client->dev, regmap, client->irq,
+				      "ens160");
 }
 
 static const struct i2c_device_id ens160_i2c_id[] = {
diff --git a/drivers/iio/chemical/ens160_spi.c b/drivers/iio/chemical/ens160_spi.c
index 40c68c5c4..90e1e8386 100644
--- a/drivers/iio/chemical/ens160_spi.c
+++ b/drivers/iio/chemical/ens160_spi.c
@@ -29,7 +29,7 @@ static int ens160_spi_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
 				     "Failed to register spi regmap\n");
 
-	return devm_ens160_core_probe(&spi->dev, regmap, "ens160");
+	return devm_ens160_core_probe(&spi->dev, regmap, spi->irq, "ens160");
 }
 
 static const struct of_device_id ens160_spi_of_match[] = {
-- 
2.45.1


