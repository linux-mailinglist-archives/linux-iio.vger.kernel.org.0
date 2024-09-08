Return-Path: <linux-iio+bounces-9339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27469708E8
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 19:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050F71C20E4B
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0066176226;
	Sun,  8 Sep 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQFCYat4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DE175D3E;
	Sun,  8 Sep 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816163; cv=none; b=Dqb8MmD+qeBbUK3E7l6tSyQLfuNSMcKYUu6GNFM+YT9O3xZQ5Pso9ERI+2RFBvd5roZkIQtWisX0bwYRGqcqMkpoWpc/pnhphP8oiBPjahLkq4dzphyeXHJm4byCps64H1f/6r6YVpfYTJR6O3qzDNz5lRXjoehq5974mMOJL04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816163; c=relaxed/simple;
	bh=gh3uFkaznO3j23fiZaGBieaEDpZaHMIDQTRsOGXN1tE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ioWPZMrbGhXRAl/gWtWzVnz9SpdjmgrcyyaWzSiyZSQOe/BOgpI8qx6cIo6GdCm80Qu3sIAiZJAGUED4bD3mSR0Gan5j6qWNQqSmtxaIY6loM/QogCYWLFvTSP883uUlv/HvD4HUsBVuLBfr+DhZP/STuTKseaTfG0F7tiDSYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQFCYat4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c1120a32so2043423f8f.1;
        Sun, 08 Sep 2024 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725816160; x=1726420960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiU1Gbd3tco+JkokVWJLy3BcPwaBLpyJS4hn2evoYQw=;
        b=iQFCYat4SEx3RsnTCyBC9Ro47cQtXIAT+vnNBZt+7B54SJU32m4LKWSlE3S4QJ7KEa
         RaL3R+OTXC8K66p7qO2jU7GSS/9DTUXee6i3vpSSRafVMY0lPK0xuH+G5DwdskupaSqC
         qfeLaVLkjsjUNxRKh8R1C7KsKChz80TlQa+G+RUT+dnpXN/guOKQqXzUzWtuwu2Rpth0
         1CXtbJ+dQTM56GIJ3ndt2ILrxymum+FONAYAGo+TQ37Ho4KEiulF2aORL//wGGC6Z8sb
         6JE2LuPls1pExfG1T5FDBu5XYnXNYIrnmyLzbJXin28gSaR76+lgT1j347WugLGc/RE5
         yXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725816160; x=1726420960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiU1Gbd3tco+JkokVWJLy3BcPwaBLpyJS4hn2evoYQw=;
        b=oGvvwCmOVUrahB9ra+mx8fXVhLBs997d6qaaukoCWuLxJDES5lcAUqjuNSJlb9lCf7
         5ngrSD+Z/19UZzcAYE3mEY6O3PmY0y+ZQ7faJe1SQzlViEUwgYxr+JycATq7coMBDnXL
         M/id/GhubxDNKx/EnakmcFp4+t4w63qImx2JG47QaR4dDekhklHgdZXgcIDnQwmEWAMk
         30s2o0NQ8ckbNgA8rzoHwXfTCyS5RSKhxa3R82z8bc59v0Aqn545gpN9S9FAQxoZm4mC
         NhZWGOJEsbaKALzu80sJxbwMV5/YxXyXHZ4Vfb5jRZsccwJnXbgd5qB1h9Ja8FcrbUvg
         Ro9A==
X-Forwarded-Encrypted: i=1; AJvYcCVx+ijf86WdRzlAUW/qlRoh4RrPvosdMDCyeB4Kqcf6o5etp8APNlQJmaLXSXMQu64851XN6QuA51+m@vger.kernel.org, AJvYcCWzdbqMXF6cHSHEqijJ8xub8khkJOKXdAY/5a58EVMj8jn53WO6sI1HxEZTA+FdiBdKn4f+30hP/AHD@vger.kernel.org, AJvYcCX9GceuyDM5kleEKAgtxm/wFmMyDCydFpf9EHHWUokEiiyvdJR3Ij46xlXlcllMZiKsd1aN2Ir9BqIHcDDy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1YwP/Y4G/bLj71NIwLtfzLpRnnwdWH417fE61L138+4ivcVrK
	a9Dv5pprMYR/UIYFZG9IUrHjlC/36baUmhgeZ1LLaws5n4UHDFnn
X-Google-Smtp-Source: AGHT+IG8tzZQtknALGRzjL6H8sFW76PhSugJHhjoITww5O2nokTY8Exfc6+nhGsu+OQ6QCnaDF8zMQ==
X-Received: by 2002:adf:efc4:0:b0:371:8750:419e with SMTP id ffacd0b85a97d-37889682e74mr5659852f8f.47.1725816159121;
        Sun, 08 Sep 2024 10:22:39 -0700 (PDT)
Received: from localhost.localdomain ([78.210.149.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61258sm228048066b.116.2024.09.08.10.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 10:22:38 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 1/2] iio: temperature: tmp006: add triggered buffer support
Date: Sun,  8 Sep 2024 19:21:53 +0200
Message-Id: <20240908172153.177406-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908172153.177406-1-apokusinski01@gmail.com>
References: <20240908172153.177406-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for continuous data capture using triggered buffers for the
tmp006 sensor. The device features a "data ready" interrupt line which
is pulled down once a new measurement is ready to be read.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/temperature/Kconfig  |   2 +
 drivers/iio/temperature/tmp006.c | 134 ++++++++++++++++++++++++++++---
 2 files changed, 123 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index ed0e4963362f..1244d8e17d50 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -91,6 +91,8 @@ config MLX90635
 config TMP006
 	tristate "TMP006 infrared thermopile sensor"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  TMP006 infrared thermopile sensor.
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 6d8d661f0c82..0c844137d7aa 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -7,8 +7,6 @@
  * Driver for the Texas Instruments I2C 16-bit IR thermopile sensor
  *
  * (7-bit I2C slave address 0x40, changeable via ADR pins)
- *
- * TODO: data ready irq
  */
 
 #include <linux/err.h>
@@ -21,6 +19,9 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define TMP006_VOBJECT 0x00
 #define TMP006_TAMBIENT 0x01
@@ -45,6 +46,7 @@
 struct tmp006_data {
 	struct i2c_client *client;
 	u16 config;
+	struct iio_trigger *drdy_trig;
 };
 
 static int tmp006_read_measurement(struct tmp006_data *data, u8 reg)
@@ -83,15 +85,19 @@ static int tmp006_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (channel->type == IIO_VOLTAGE) {
 			/* LSB is 156.25 nV */
-			ret = tmp006_read_measurement(data, TMP006_VOBJECT);
-			if (ret < 0)
-				return ret;
+			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+				ret = tmp006_read_measurement(data, TMP006_VOBJECT);
+				if (ret < 0)
+					return ret;
+			}
 			*val = sign_extend32(ret, 15);
 		} else if (channel->type == IIO_TEMP) {
 			/* LSB is 0.03125 degrees Celsius */
-			ret = tmp006_read_measurement(data, TMP006_TAMBIENT);
-			if (ret < 0)
-				return ret;
+			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+				ret = tmp006_read_measurement(data, TMP006_TAMBIENT);
+				if (ret < 0)
+					return ret;
+			}
 			*val = sign_extend32(ret, 15) >> TMP006_TAMBIENT_SHIFT;
 		} else {
 			break;
@@ -128,7 +134,7 @@ static int tmp006_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct tmp006_data *data = iio_priv(indio_dev);
-	int i;
+	int ret, i;
 
 	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
 		return -EINVAL;
@@ -136,13 +142,19 @@ static int tmp006_write_raw(struct iio_dev *indio_dev,
 	for (i = 0; i < ARRAY_SIZE(tmp006_freqs); i++)
 		if ((val == tmp006_freqs[i][0]) &&
 		    (val2 == tmp006_freqs[i][1])) {
+			ret = iio_device_claim_direct_mode(indio_dev);
+			if (ret)
+				return ret;
+
 			data->config &= ~TMP006_CONFIG_CR_MASK;
 			data->config |= i << TMP006_CONFIG_CR_SHIFT;
 
-			return i2c_smbus_write_word_swapped(data->client,
-							    TMP006_CONFIG,
-							    data->config);
+			ret = i2c_smbus_write_word_swapped(data->client,
+							   TMP006_CONFIG,
+							   data->config);
 
+			iio_device_release_direct_mode(indio_dev);
+			return ret;
 		}
 	return -EINVAL;
 }
@@ -164,13 +176,29 @@ static const struct iio_chan_spec tmp006_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		}
 	},
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	}
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+			.shift = TMP006_TAMBIENT_SHIFT,
+			.endianness = IIO_BE,
+		}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static const struct iio_info tmp006_info = {
@@ -213,6 +241,54 @@ static void tmp006_powerdown_cleanup(void *dev)
 	tmp006_power(dev, false);
 }
 
+static irqreturn_t tmp006_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct tmp006_data *data = iio_priv(indio_dev);
+	struct {
+		s16 channels[2];
+		s64 ts __aligned(8);
+	} scan;
+	s32 ret;
+
+	ret = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
+	if (ret < 0)
+		goto err;
+	scan.channels[0] = ret;
+
+	ret = i2c_smbus_read_word_data(data->client, TMP006_TAMBIENT);
+	if (ret < 0)
+		goto err;
+	scan.channels[1] = ret;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
+					   iio_get_time_ns(indio_dev));
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int tmp006_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct tmp006_data *data = iio_priv(indio_dev);
+
+	if (state)
+		data->config |= TMP006_CONFIG_DRDY_EN;
+	else
+		data->config &= ~TMP006_CONFIG_DRDY_EN;
+
+	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
+					    data->config);
+}
+
+static const struct iio_trigger_ops tmp006_trigger_ops = {
+	.set_trigger_state = tmp006_set_trigger_state,
+};
+
+static const unsigned long tmp006_scan_masks[] = { 0x3, 0 };
+
 static int tmp006_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
@@ -241,6 +317,7 @@ static int tmp006_probe(struct i2c_client *client)
 
 	indio_dev->channels = tmp006_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tmp006_channels);
+	indio_dev->available_scan_masks = tmp006_scan_masks;
 
 	ret = i2c_smbus_read_word_swapped(data->client, TMP006_CONFIG);
 	if (ret < 0)
@@ -258,6 +335,37 @@ static int tmp006_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	if (client->irq > 0) {
+		data->drdy_trig = devm_iio_trigger_alloc(&client->dev,
+							 "%s-dev%d",
+							 indio_dev->name,
+							 iio_device_id(indio_dev));
+		if (!data->drdy_trig)
+			return -ENOMEM;
+
+		data->drdy_trig->ops = &tmp006_trigger_ops;
+		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
+		ret = iio_trigger_register(data->drdy_trig);
+		if (ret)
+			return ret;
+
+		indio_dev->trig = iio_trigger_get(data->drdy_trig);
+
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						iio_trigger_generic_data_rdy_poll,
+						NULL,
+						IRQF_ONESHOT,
+						"tmp006_irq",
+						data->drdy_trig);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+					      tmp006_trigger_handler, NULL);
+	if (ret < 0)
+		return ret;
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.25.1


