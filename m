Return-Path: <linux-iio+bounces-20103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A4AC9F8E
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF95172B05
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F5204C2E;
	Sun,  1 Jun 2025 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq9g9Smr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E5201034;
	Sun,  1 Jun 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798520; cv=none; b=otJVdT+yYlBptBm3planjdVMxTj/JBSwlxqZ5XihwV8gQBrr0mdvbPKdTs096ist8myN5mr8osJ/V//+LkIOCJ30HFk7q1POvymRQYjZo7neJy5dFNksAEAQirs9vUM/dtU4jcwedTaAe7wCl8g+KfKPxkPzD3+5Mm3rS21e3VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798520; c=relaxed/simple;
	bh=/sOc9fTkJnyXISGbgO7H++cvOaIUVU1TXCPxM9nLBYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CTl9u6bpZtMv7AZp9htghGZF0g9IHjeJw+m5ek+j7rlfd/O2NAQK3vFgoY11bqTmse0dIGY8CvSjpOShEGP9/2nY4VfzJiw0MGtUBMsmoHX7wMefwhji4sIqLX2Z5+CZcoii8ZVWeIPs5RW6Ew7L892s8G48O/xDN7oPBq3j+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq9g9Smr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d4ff56136so957335e9.3;
        Sun, 01 Jun 2025 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798517; x=1749403317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n238sgCw6wcL+GgmAKal3WeJnfpIGHYNLmJxhnga+i8=;
        b=Zq9g9SmrjS6p4zMeEs0HLUlgnd5fwnWNSZEUmZq2ixMZtIqLgp1CZy0ZrCni4oP1Vl
         aFN5srW+x+KqgjxfSM1AVjwmB8Td1jmB8hH0YzSVhX3+pRuH0m0m4r47n1J7VeN9Qxmg
         roYJ1Ko9T1WcgCvosWta5JR8o+lG3MSr/yCV77880W/dj23lYTIYPFMAxBbl2NH2sBQ0
         nGSUud/Tk4c2D5I1tswshNVgiTFi1M8m/mBGSx0HfbmdWoLBFfW9Qf9ZSMXvPQICLmqs
         xArFhLNDLRZvnmxx8evHHYb47yuAQv1xNIYgXpJ/D8nG5oT+bqhf+DBtIp9YOIztXo5Y
         r8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798517; x=1749403317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n238sgCw6wcL+GgmAKal3WeJnfpIGHYNLmJxhnga+i8=;
        b=BTCRQJ6jFu5dIhnpQJtXQyq1dKSK4qmgRnr2k39Gg3S+sh6vYCZJOMVl2XkHUB0j8+
         n9wJsd1N9Ell0lME8T8BCOV5MW5rklbzj5rKaJpeKeFKZh7xXHXHC5U8amMq+Wzg3r73
         g23XQ4jjoaby5wuDI+TDDAj/to+7C7dCc2qtVr2WCDYFETSajnGIpWN2NADLLeTR1Q7t
         xJKUSOmiH45n2o39PHxAzHVxM4stvL3i9NQ7QkP8oAlZ/LINHGJ5pvJ7/q95PTDrve7a
         55a9M2DKwIvuYmpGafP9k4NWCpevkDtjPg5JA411rh7DKmf+OTfR7dfKc5U/YwlBwdm8
         sQTw==
X-Forwarded-Encrypted: i=1; AJvYcCUZsaTp78x2Ju1jz93UJojIRQxRi/KWx/XvO8tObmiduJf8f4zchHk4lvucwxgnVRwWoHHfqe8gHM8=@vger.kernel.org, AJvYcCVW5806xtborkyxVF75zhlCu980q8AwLNQTwjyORP8Hm6Hh00TogXfygp8EkSqWNkR5MhWxwAuZOKqT@vger.kernel.org, AJvYcCW727kjPKn0hqng8pH3vzASSKYNGYHAkVpc+FNQalnv6ujA3BhihFrJe1MsVqmSWTwlKmxTF7UMDt49ebXZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rG0ZZsH8GVuKUiUqqnM0R/PAuOp2KmjPNtvHhOtw9FUBrQF1
	eZ56zCv9Nz5NubUrq9bEMT3wvENOlUAqDn7gwyv5Fz4p6ZF/yoJm2hdFCxUewQ==
X-Gm-Gg: ASbGncuNBtFFL+NR09IFwqsyktbtGhYXPdjUmT9Nln6wredOuOwSJPusv7elfYfj/j9
	BacyAuuDByJl9w9v3MjxmTfONYTutYkCmclO3F2fi7ZgI9DNv4zHAB8Q7Tk9vge3dENylZffjl2
	wwl7tBlq77YUe2fprMtEgdnro6HCesPfwHs0t6sKKW+zrDsjgWuzGUX5DdDIKbGUmLMaNg/yFm/
	ruRQxN8Ar8rjN0G+/nInloJ06hvVsvW3B6VAknZlsbmD4cQoDm/283E9vdd4uRagm+cabf2nPwv
	Q16kJl5KuTQhkwvVS3TOBDsgyOuvgFRFD7smNzqTFZ62We5o2gMuU7mKpp3xq1YaqlV2IFwRvT1
	Pf1YR4a2cLzhJ0iEdAiP9qw==
X-Google-Smtp-Source: AGHT+IEcKoL7Ca4GfQfrQmw1dzgsMg68OQtuZaP2xa0aOHt/jZUFmbZsPsIhT5JWDtqfdQp/K/t+MA==
X-Received: by 2002:a05:600c:444b:b0:439:9a40:aa1a with SMTP id 5b1f17b1804b1-450d6556cd1mr31440305e9.6.1748798517044;
        Sun, 01 Jun 2025 10:21:57 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:21:56 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] iio: accel: adxl313: add basic interrupt handling for FIFO watermark
Date: Sun,  1 Jun 2025 17:21:34 +0000
Message-Id: <20250601172139.59156-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare the interrupt handler. Add register entries to evaluate the
incoming interrupt. Add functions to clear status registers and reset the
FIFO.

Add FIFO watermark configuration and evaluation. Let a watermark to be
configured. Evaluate the interrupt accordingly. Read out the FIFO content
and push the values to the IIO channel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  10 ++
 drivers/iio/accel/adxl313_core.c | 190 +++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index ab6b9e11fde4..4f4a9fd39f6d 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -53,11 +53,19 @@
 #define ADXL313_INT_ACTIVITY		BIT(4)
 #define ADXL313_INT_DREADY		BIT(7)
 
+/* FIFO entries: how many values are stored in the FIFO */
+#define ADXL313_REG_FIFO_STATUS_ENTRIES_MSK	GENMASK(5, 0)
+/* FIFO samples: number of samples needed for watermark (FIFO mode) */
+#define ADXL313_REG_FIFO_CTL_SAMPLES_MSK	GENMASK(4, 0)
 #define ADXL313_REG_FIFO_CTL_MODE_MSK		GENMASK(7, 6)
 
 #define ADXL313_FIFO_BYPASS			0
 #define ADXL313_FIFO_STREAM			2
 
+#define ADXL313_FIFO_SIZE			32
+
+#define ADXL313_NUM_AXIS			3
+
 extern const struct regmap_access_table adxl312_readable_regs_table;
 extern const struct regmap_access_table adxl313_readable_regs_table;
 extern const struct regmap_access_table adxl314_readable_regs_table;
@@ -78,7 +86,9 @@ struct adxl313_data {
 	struct regmap	*regmap;
 	const struct adxl313_chip_info *chip_info;
 	struct mutex	lock; /* lock to protect transf_buf */
+	u8 watermark;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
+	__le16		fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
 };
 
 struct adxl313_chip_info {
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 31ce1b218488..8a0b5542fb40 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -10,15 +10,21 @@
 #include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+
 #include "adxl313.h"
 
 #define ADXL313_INT_NONE			U8_MAX
 #define ADXL313_INT1				1
 #define ADXL313_INT2				2
 
+#define ADXL313_REG_XYZ_BASE			ADXL313_REG_DATA_AXIS(0)
+
 static const struct regmap_range adxl312_readable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
 	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
@@ -62,6 +68,7 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
 	case ADXL313_REG_DATA_AXIS(4):
 	case ADXL313_REG_DATA_AXIS(5):
 	case ADXL313_REG_FIFO_STATUS:
+	case ADXL313_REG_INT_SOURCE:
 		return true;
 	default:
 		return false;
@@ -363,6 +370,176 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	const unsigned int fifo_mask = 0x1f, interrupt_mask = 0x02;
+	int ret;
+
+	value = min(value, ADXL313_FIFO_SIZE - 1);
+
+	ret = regmap_update_bits(data->regmap, ADXL313_REG_FIFO_CTL,
+				 fifo_mask, value);
+	if (ret)
+		return ret;
+
+	data->watermark = value;
+
+	return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				  interrupt_mask, ADXL313_INT_WATERMARK);
+}
+
+static int adxl313_get_samples(struct adxl313_data *data)
+{
+	unsigned int regval = 0;
+	int ret;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_FIFO_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
+}
+
+static int adxl313_fifo_transfer(struct adxl313_data *data, int samples)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < samples; i++) {
+		ret = regmap_bulk_read(data->regmap, ADXL313_REG_XYZ_BASE,
+				       data->fifo_buf + (i * ADXL313_NUM_AXIS),
+				       2 * ADXL313_NUM_AXIS);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * adxl313_fifo_reset() - Reset the FIFO and interrupt status registers.
+ * @data: The device data.
+ *
+ * Reset the FIFO status registers. Reading out status registers clears the
+ * FIFO and interrupt configuration. Thus do not evaluate regmap return values.
+ * Ignore particular read register content. Register content is not processed
+ * any further. Therefore the function returns void.
+ */
+static void adxl313_fifo_reset(struct adxl313_data *data)
+{
+	unsigned int regval;
+	int samples;
+
+	adxl313_set_measure_en(data, false);
+
+	samples = adxl313_get_samples(data);
+	if (samples > 0)
+		adxl313_fifo_transfer(data, samples);
+
+	regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &regval);
+
+	adxl313_set_measure_en(data, true);
+}
+
+static int adxl313_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = adxl313_set_measure_en(data, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
+			   FIELD_PREP(ADXL313_REG_FIFO_CTL_SAMPLES_MSK,	data->watermark) |
+			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK, ADXL313_FIFO_STREAM));
+	if (ret)
+		return ret;
+
+	return adxl313_set_measure_en(data, true);
+}
+
+static int adxl313_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = adxl313_set_measure_en(data, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
+			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK, ADXL313_FIFO_BYPASS));
+
+	ret = regmap_write(data->regmap, ADXL313_REG_INT_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	return adxl313_set_measure_en(data, true);
+}
+
+static const struct iio_buffer_setup_ops adxl313_buffer_ops = {
+	.postenable = adxl313_buffer_postenable,
+	.predisable = adxl313_buffer_predisable,
+};
+
+static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	unsigned int i;
+	int ret;
+
+	ret = adxl313_fifo_transfer(data, samples);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ADXL313_NUM_AXIS * samples; i += ADXL313_NUM_AXIS)
+		iio_push_to_buffers(indio_dev, &data->fifo_buf[i]);
+
+	return 0;
+}
+
+static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	int samples;
+
+	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
+		samples = adxl313_get_samples(data);
+		if (samples < 0)
+			return samples;
+
+		return adxl313_fifo_push(indio_dev, samples);
+	}
+
+	/* Return error if no event data was pushed to the IIO channel. */
+	return -ENOENT;
+}
+
+static irqreturn_t adxl313_irq_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct adxl313_data *data = iio_priv(indio_dev);
+	int int_stat;
+
+	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
+		return IRQ_NONE;
+
+	if (adxl313_push_event(indio_dev, int_stat))
+		goto err;
+
+	if (FIELD_GET(ADXL313_INT_OVERRUN, int_stat))
+		goto err;
+
+	return IRQ_HANDLED;
+
+err:
+	adxl313_fifo_reset(data);
+
+	return IRQ_HANDLED;
+}
+
 static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			      unsigned int writeval, unsigned int *readval)
 {
@@ -377,6 +554,7 @@ static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
 	.read_avail	= adxl313_read_freq_avail,
+	.hwfifo_set_watermark = adxl313_set_watermark,
 	.debugfs_reg_access = &adxl313_reg_access,
 };
 
@@ -487,6 +665,18 @@ int adxl313_core_probe(struct device *dev,
 					 int_map_msk, int_line == ADXL313_INT2);
 		if (ret)
 			return ret;
+
+		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+						  &adxl313_buffer_ops);
+		if (ret)
+			return ret;
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						&adxl313_irq_handler,
+						IRQF_SHARED | IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return ret;
 	} else {
 		/*
 		 * FIFO_BYPASSED mode
-- 
2.39.5


