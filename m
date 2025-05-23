Return-Path: <linux-iio+bounces-19843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ECBAC2BD6
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37557BCEB0
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4C214232;
	Fri, 23 May 2025 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqL34LV5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0F21D3D9;
	Fri, 23 May 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039763; cv=none; b=aTusRArohUyyEwiLnmBTrkSM8yy+Om0FwH5sTctWX07UbG4Z7X7/Cffd1vfhmmkRhMNBpJPW3L2T3kXsdzxOeozX9l3IZRLhmiDaBmhzXFMtsOPqEeC6TS4bVIHTz4cWskm3IZZUt7Wr3HZZUyl1wg856NLpq/QxWs3AxSVPBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039763; c=relaxed/simple;
	bh=vBVLfDokfd6MkmYCWp5Sdd7VWE+BSKaLLjVvgAkVQ28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RadzD56xytYS/PS7/Q3ibFbzqGhXSwwdOemMk8qzubzHAffSbGr/E0ErlsLLArLVaP/OCiEOF1IcKl/m00DDkbPYU2/mju/3DYEB5hIwexJujO4BAnT9a+XR6S4M0djI7acYnm3qCZw4x3dtoncrIeYu1g3ja+FvcZLLl2CtOFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqL34LV5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a37b5de515so59808f8f.2;
        Fri, 23 May 2025 15:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039759; x=1748644559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGmeA98fWDQFVRJJ+lNw1U0Dir/MrHbdSk7w4tf8beA=;
        b=fqL34LV53I7nSF8T/TzP+ipxvthJAQT187PJLTxP1PxyyZefh3AfZnixL8YF1jp4LQ
         1iUID86SE5kgtBDrfprORdpWOuirUta5ETPZ3rMxF6etKLOLZ1EfsStBp8mLg/cXUUDz
         nZUDlrKNjbZPWAvyvWzT8ghS/SpdxSHEIKiFhllkoTU8OUFUsNg4RAtI+E2n+TUr2AF+
         ZUJwPNX3SGFqRx7iYHedKLPNf+LSg3buCoJAPtkcqUERcHlET2wJFMyX5Ak9X2LNthlh
         hV6hsLcScSoJyBIJIQWoe9u/KjLNBfLV5asOQj8w66XqKvsBRcG1m3lgtJv+zP2t/dD2
         tA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039759; x=1748644559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGmeA98fWDQFVRJJ+lNw1U0Dir/MrHbdSk7w4tf8beA=;
        b=uWVAz88mxE6Gj/ntrkco9Hfk/GO0AD+LwHG5qd6DifWmU/Fki+bYuZ0ONiL0rm/goa
         VmpOhoGH1AEB81IeLhnix01gnRAX6lC4/cIuRhJLy1wWuBwGgqhP3qOBDwy5JZZ9RHcW
         843GXd071ZzQt4WQNRAojfo7HzQJbtuaPVpM3hritYv2Gwo0DQJDa9fKPVqXEuA6FUkC
         n2zntNDLB1WmemlR7YyflraVs56z+Al7fQVAHrF1Wxm3AvSsWlCwXA1P3p7JJPlSbDpv
         WTSczZfmOsHKalQmL+9b0ChzhD9etLNtIAIdTSkgLMLGQZTnWPIO7pp2C6B3yBcUmkY2
         EGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC+uCN5skFDp30JxFm4yPnn3+EQgKkcVzS0G53S8KW+ix0JIHolUNWwf1sjLxaiKgPNtvPTzWTA2SuUUiq@vger.kernel.org, AJvYcCVqorVEt735ZO1dGHXGUcHYlPeS/vQN3U0VkeQJESNQ2HWKfnDiCnThrn14beCpc76DvvHD1A93ZEc=@vger.kernel.org, AJvYcCXPOGxewGyPTBapIiCPbyBIl3HDilhsy3H5+L9RAkrvZJhxp+mE/UDI1yWoDcGUt7oRDgWHGJqEaxyA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OQwM2j8m8339KKMdesVWKFpp4BTko0I14eJBRfdY9SwIyj9B
	LKDzC5rkj6ANKsbzCQJXnMPhLSxRpY7ItmDlj8mZf2NAJwugtYWHm6B723BplBmf
X-Gm-Gg: ASbGncv/11619oPFl6rN68nzkgX+XeZAn3eKsB9LrKkDrlygpYaqYp4YpA2aLymg1uJ
	QmbiSrlVqEKwfKGGWYpkoK3cfgu6e3QPUh2Vdfx7w2A28ZmVp57iEn8rQdrZ5c3Ov09KTYRzgkM
	YYMn4qW2viPLmjC6VySTb96hsvVRoTPmKn3eNIkp2ZtJnKjmZjEx+gLTGqX6Aj99ysY0EYBhy0w
	5EwGrExEejdsdkthbEkbxWofBJdKat6JXCY8xeCchkPMKfHu3tuTySdR7dPtfMd9NmoDiKwUAvU
	6r/4gyTgOx8mIgt9zvc20qdeaN0vCL9exVVw6Z4NqBGd0lLWqRWipGk2VwpNModttj/ORfT+csI
	NQr/bzo6I7f1bVAHY0JJJpg==
X-Google-Smtp-Source: AGHT+IE0IKScAEBsPP2JKe9BOR2U+8SXsG4z4IeDukuStypXlsZzo5z9v2dpWqkHKB1BPAjjjk5WeA==
X-Received: by 2002:a05:6000:26cb:b0:3a3:5cc9:2f67 with SMTP id ffacd0b85a97d-3a4cb4db4afmr251262f8f.16.1748039759260;
        Fri, 23 May 2025 15:35:59 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:35:58 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/12] iio: accel: adxl313: add basic interrupt handling
Date: Fri, 23 May 2025 22:35:18 +0000
Message-Id: <20250523223523.35218-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
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

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  16 ++++
 drivers/iio/accel/adxl313_core.c | 134 +++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index ab109d1c359e..9cdad55dd350 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -47,11 +47,25 @@
 #define ADXL313_SPI_3WIRE		BIT(6)
 #define ADXL313_I2C_DISABLE		BIT(6)
 
+#define ADXL313_INT_OVERRUN		BIT(0)
+#define ADXL313_INT_WATERMARK		BIT(1)
+#define ADXL313_INT_INACTIVITY		BIT(3)
+#define ADXL313_INT_ACTIVITY		BIT(4)
+#define ADXL313_INT_DREADY		BIT(7)
+
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
@@ -73,7 +87,9 @@ struct adxl313_data {
 	const struct adxl313_chip_info *chip_info;
 	struct mutex	lock; /* lock to protect transf_buf */
 	int irq;
+	u8 fifo_mode;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
+	__le16		fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
 };
 
 struct adxl313_chip_info {
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 9db318a03eea..1e085f0c61a0 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -10,15 +10,24 @@
 #include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
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
@@ -62,6 +71,7 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
 	case ADXL313_REG_DATA_AXIS(4):
 	case ADXL313_REG_DATA_AXIS(5):
 	case ADXL313_REG_FIFO_STATUS:
+	case ADXL313_REG_INT_SOURCE:
 		return true;
 	default:
 		return false;
@@ -363,6 +373,118 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
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
+static int adxl313_set_fifo(struct adxl313_data *data)
+{
+	unsigned int int_line;
+	int ret;
+
+	ret = adxl313_set_measure_en(data, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_INT_MAP, &int_line);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
+			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK, data->fifo_mode));
+
+	return adxl313_set_measure_en(data, true);
+}
+
+static int adxl313_fifo_transfer(struct adxl313_data *data, int samples)
+{
+	size_t count;
+	unsigned int i;
+	int ret;
+
+	count = array_size(sizeof(data->fifo_buf[0]), ADXL313_NUM_AXIS);
+	for (i = 0; i < samples; i++) {
+		ret = regmap_bulk_read(data->regmap, ADXL313_REG_XYZ_BASE,
+				       data->fifo_buf + (i * count / 2), count);
+		if (ret)
+			return ret;
+	}
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
+
+	data->fifo_mode = ADXL313_FIFO_STREAM;
+	return adxl313_set_fifo(data);
+}
+
+static int adxl313_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	int ret;
+
+	data->fifo_mode = ADXL313_FIFO_BYPASS;
+	ret = adxl313_set_fifo(data);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, ADXL313_REG_INT_ENABLE, 0);
+}
+
+static const struct iio_buffer_setup_ops adxl313_buffer_ops = {
+	.postenable = adxl313_buffer_postenable,
+	.predisable = adxl313_buffer_predisable,
+};
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
+	adxl313_fifo_reset(data);
+
+	return IRQ_HANDLED;
+}
+
 static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			      unsigned int writeval, unsigned int *readval)
 {
@@ -483,6 +605,18 @@ int adxl313_core_probe(struct device *dev,
 					 0xff, int_line == ADXL313_INT2);
 		if (ret)
 			return ret;
+
+		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+						  &adxl313_buffer_ops);
+		if (ret)
+			return ret;
+
+		ret = devm_request_threaded_irq(dev, data->irq, NULL,
+						&adxl313_irq_handler,
+						IRQF_SHARED | IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return ret;
 	} else {
 		/* FIFO_BYPASSED mode */
 		ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
-- 
2.39.5


