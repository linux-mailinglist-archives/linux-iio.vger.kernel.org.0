Return-Path: <linux-iio+bounces-4995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E0E8C3874
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE49281B34
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 21:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9B65476B;
	Sun, 12 May 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxumkIdy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734957894;
	Sun, 12 May 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715547913; cv=none; b=V3DhE8j1XEPMZynV0+nes28d3UkA1l854+9UwDAcGmbyQVHQbWShpkdBqXgXozEWpMwFYaSUJ+u16aR5YS8vm6e2HTraItUxquCSdG78w+BojhTs5WEh4RKrBlGpZAATa7ZBhcD3045wkaiCQcD1skUhesYqFrzFc+NkMjKaKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715547913; c=relaxed/simple;
	bh=EBDld87KvJAj/I0c18JBino3RiZQyH9BSREwpqgwERo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kln3vmZq+u0UZErTKxAnn2WKALsue3DB+49N2N5dlryKqlo8s9lypVQeSbN90rBSRv4srpQYv9MpQsChCVQRmwj0Okl8e1t1xvZTKDeJDa47f+XjkmaJDLidar+3U1Qp9+bYyB09WV1583/qlXTJYxYJ1VY6/v2GW8eGVRwtQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxumkIdy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2792673a12.3;
        Sun, 12 May 2024 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715547911; x=1716152711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z87FZpuN5IR2DouSKJ56603NoDkQMEQxOqDBWOsG8W0=;
        b=kxumkIdy43XwjEGNd1kBVYGRdOwNqBHQ7BKd9LBz+bW3ks+xO1kLeKqVeXIQpNaMz9
         8CuC8mCf++mJLTQ8ebYFsiwcGphTzZ8BicDNgZnzFZ9mbUQdIGGXQZgHlvKcHo/KMoLr
         fznNToOs6tLmcMUqC7rJ8lqVnqV1wHtTfxKWSPRE9bnKk+bAJ0IuvdvygtAPeBMR93ZM
         06GKuRxXzygyWonljubUlXpb0YmQ3+EYjpoMhEOOOSrtClX0lxwFTIGxf2ME7iWDnnts
         c2qZoSX5s1DND5cQh1bvUQNJavertA+7/0v5JVPDkNz0BiVESH7MUdqkqUrRkEq9vvV1
         L2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715547911; x=1716152711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z87FZpuN5IR2DouSKJ56603NoDkQMEQxOqDBWOsG8W0=;
        b=i6AbqGgJRUMIcrQBvNbBUjao5a2D58bUVHiEPWS7jsEg6xz/q4LuPtILM21NsqEj5s
         eJvmVe0vc2NseSG/zD8cZ9tAoJNeP5JVMHxhYeuVc1+4HVJyyu6ILzd4aTY/DhN5jq9F
         F0tCBpyVW/vfojcCY3NtOd/aTq2pRZMoAx1yI+rZIwfLTFkLvPV9E3db52VhT5RSPv4z
         LdkHB0wASKoQRUx8us78oBgpWVK6BuAp1cI6xgUiZenJ0Z+Z5lWinQ5dNA7CvoKViGTE
         ofrtE/bwG2XaBbxDXRBvBK4gW1E361yltXqIIry9XVOn30mEJGVu9uCgU4D3rMQJDUAZ
         OhfA==
X-Forwarded-Encrypted: i=1; AJvYcCWszkMaWYlQHcAyPtStoZlPXbbuyRH4ugB7fkaXO/pyNZO2C22UnmXNW8k2fc180CvfXF8boTgJNcRFXh4exU/4Vn/WCQiUqr3bdxpofLFzYYqEWemMTCjqwdyWZ97fgJ+McsBMEGdquWKQnsqB3Q5P4mNDEWI5+AAt8t/QmzNgkH+Ymw==
X-Gm-Message-State: AOJu0Yzt/ys9MM3Ubg2m4mYQVGzXbP8Q8GIYNcnbPhi6JESKji4vlW26
	Sw0csUnkta3IEdrasR3ZusiJykZ+PkdwWbI9mWE5MDo6pNdLiQAA
X-Google-Smtp-Source: AGHT+IFymzebPmYz++SUsZXrJ38Qi9kGCc5OUSNjc+OAUrq9tWQEZjPgPmDO6q5lPPvMPdI+zaNxfQ==
X-Received: by 2002:a05:6a21:9181:b0:1af:dba9:2ff8 with SMTP id adf61e73a8af0-1afde130cd6mr11757563637.37.1715547910991;
        Sun, 12 May 2024 14:05:10 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a447391sm6534865a12.3.2024.05.12.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 14:05:10 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	gerald.loacker@wolfvision.net,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iio: chemical: ens160: add triggered buffer support
Date: Sun, 12 May 2024 18:04:40 -0300
Message-ID: <20240512210444.30824-5-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512210444.30824-1-gustavograzs@gmail.com>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
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
 drivers/iio/chemical/ens160_core.c | 155 ++++++++++++++++++++++++++++-
 drivers/iio/chemical/ens160_i2c.c  |   2 +-
 drivers/iio/chemical/ens160_spi.c  |   2 +-
 4 files changed, 156 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/chemical/ens160.h b/drivers/iio/chemical/ens160.h
index 3fd079bc4..a8a2f1263 100644
--- a/drivers/iio/chemical/ens160.h
+++ b/drivers/iio/chemical/ens160.h
@@ -2,7 +2,7 @@
 #ifndef ENS160_H_
 #define ENS160_H_
 
-int ens160_core_probe(struct device *dev, struct regmap *regmap,
+int ens160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		      const char *name);
 void ens160_core_remove(struct device *dev);
 
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 25593420d..4b960ef00 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -11,6 +11,9 @@
 
 #include <linux/bitfield.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
@@ -24,6 +27,11 @@
 
 #define ENS160_REG_OPMODE	0x10
 
+#define ENS160_REG_CONFIG		0x11
+#define ENS160_REG_CONFIG_INTEN		BIT(0)
+#define ENS160_REG_CONFIG_INTDAT	BIT(1)
+#define ENS160_REG_CONFIG_INT_CFG	BIT(5)
+
 #define ENS160_REG_MODE_DEEP_SLEEP	0x00
 #define ENS160_REG_MODE_IDLE		0x01
 #define ENS160_REG_MODE_STANDARD	0x02
@@ -48,6 +56,12 @@
 
 struct ens160_data {
 	struct regmap *regmap;
+	struct mutex mutex;
+	struct {
+		u16 chans[2];
+		s64 timestamp __aligned(8);
+	} scan;
+	int irq;
 };
 
 static const struct iio_chan_spec ens160_channels[] = {
@@ -58,6 +72,13 @@ static const struct iio_chan_spec ens160_channels[] = {
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
@@ -66,7 +87,15 @@ static const struct iio_chan_spec ens160_channels[] = {
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
@@ -79,10 +108,19 @@ static int ens160_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		mutex_lock(&data->mutex);
 		ret = regmap_bulk_read(data->regmap, chan->address,
 					&buf, sizeof(buf));
-		if (ret)
+		if (ret) {
+			mutex_unlock(&data->mutex);
+			iio_device_release_direct_mode(indio_dev);
 			return ret;
+		}
+		mutex_unlock(&data->mutex);
+		iio_device_release_direct_mode(indio_dev);
 		*val = le16_to_cpu(buf);
 		return IIO_VAL_INT;
 
@@ -182,7 +220,104 @@ static const struct iio_info ens160_info = {
 	.read_raw = ens160_read_raw,
 };
 
-int ens160_core_probe(struct device *dev, struct regmap *regmap,
+static irqreturn_t ens160_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ens160_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ens160_data *data = iio_priv(indio_dev);
+	__le16 val;
+	int ret, i, j = 0;
+
+	mutex_lock(&data->mutex);
+
+	for_each_set_bit(i, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		ret = regmap_bulk_read(data->regmap,
+				       ENS160_REG_DATA_TVOC + 2 * i, &val, 2U);
+		if (ret)
+			goto err;
+
+		data->scan.chans[j++] = val;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+					   pf->timestamp);
+err:
+	mutex_unlock(&data->mutex);
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
+	int ret;
+
+	if (state)
+		ret = regmap_set_bits(data->regmap, ENS160_REG_CONFIG,
+				      int_bits);
+	else
+		ret = regmap_clear_bits(data->regmap, ENS160_REG_CONFIG,
+					int_bits);
+
+	return ret;
+}
+
+static const struct iio_trigger_ops ens160_trigger_ops = {
+	.set_trigger_state = ens160_set_trigger_state,
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int ens160_setup_trigger(struct iio_dev *indio_dev)
+{
+	struct ens160_data *data = iio_priv(indio_dev);
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
+	ret = devm_request_threaded_irq(dev, data->irq,
+					ens160_irq_handler,
+					NULL,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					indio_dev->name,
+					indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq\n");
+
+	return 0;
+}
+
+int ens160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		      const char *name)
 {
 	struct ens160_data *data;
@@ -196,6 +331,7 @@ int ens160_core_probe(struct device *dev, struct regmap *regmap,
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
+	data->irq = irq;
 
 	indio_dev->name = name;
 	indio_dev->info = &ens160_info;
@@ -203,12 +339,27 @@ int ens160_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->channels = ens160_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
 
+	if (data->irq > 0) {
+		ret = ens160_setup_trigger(indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to setup trigger\n");
+	}
+
 	ret = ens160_chip_init(data);
 	if (ret) {
 		dev_err_probe(dev, ret, "chip initialization failed\n");
 		return ret;
 	}
 
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
 EXPORT_SYMBOL_NS(ens160_core_probe, IIO_ENS160);
diff --git a/drivers/iio/chemical/ens160_i2c.c b/drivers/iio/chemical/ens160_i2c.c
index ee2b44184..28d4988c0 100644
--- a/drivers/iio/chemical/ens160_i2c.c
+++ b/drivers/iio/chemical/ens160_i2c.c
@@ -31,7 +31,7 @@ static int ens160_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
-	return ens160_core_probe(&client->dev, regmap, client->name);
+	return ens160_core_probe(&client->dev, regmap, client->irq, client->name);
 }
 
 static void ens160_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/chemical/ens160_spi.c b/drivers/iio/chemical/ens160_spi.c
index effc4acee..568b9761d 100644
--- a/drivers/iio/chemical/ens160_spi.c
+++ b/drivers/iio/chemical/ens160_spi.c
@@ -32,7 +32,7 @@ static int ens160_spi_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return ens160_core_probe(&spi->dev, regmap, id->name);
+	return ens160_core_probe(&spi->dev, regmap, spi->irq, id->name);
 }
 
 static void ens160_spi_remove(struct spi_device *spi)
-- 
2.45.0


