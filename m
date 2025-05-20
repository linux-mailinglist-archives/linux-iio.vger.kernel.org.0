Return-Path: <linux-iio+bounces-19755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52367ABE795
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EE017E08C
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868092641C3;
	Tue, 20 May 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpwOG5Yi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC1262D0C;
	Tue, 20 May 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781448; cv=none; b=G/VKM4jEBY8fgibq32VMAwN8h/N6VqoHwY1S92SVJdxrvKJNjwwYiTU/tso60E0FAa1NdLQwFwUE30rrAtn4L5DnRSIsVzvQwuRNoK2PLAVmSLhcSgQfbrSuVYdxAG8VozlrR+q++STAd2//gvrB2oXhee7GFGz4S2+//I9k+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781448; c=relaxed/simple;
	bh=03qxrog3gn/oGJgUyXC0VRRbUyUMgSFNsGAbMYt7K44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=spzMmtpaQLBX+9Vt+jaX/fwziImPJj8FIP7FMZYBN2bb/b78n6gE7LYXC6pNYlHEUiVSlCfwQweBk7xV/1Pz9Jv1IPxzjRjQl/STRKGZU116nmUsuPyQOzZxfOqf+YaPo1yjbNf4kVcPrgFd+2yxDeE6ElzI0k8gyDgyTwGUlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpwOG5Yi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-440668acbf3so3236625e9.0;
        Tue, 20 May 2025 15:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781444; x=1748386244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8VUd2aQwHAY7kh1IBfReT0PW2kSB1JTfPrkeq2sTu4=;
        b=hpwOG5YiWVapV9mECYXxc6YhxQc3TYFWyRNxP+DgepNY0YzfoglXU3o7IDhP5c7RsW
         fdaFoUcYYkgCCuohypMP7EhU+y4V6ctfouKk9eeYDe5VHFgoz0gr4qTz9MKdN3HTBnfG
         Z2J3Do80urXhPxocf7ahUsY0+2IpEgdjzcAM6I4YgYBWIUXCIvGB/D01TuSPpOVF+SnL
         y6iAz9JfWgRZrDfp3CfeI9jh4UM4xBQ4SgI/LVXptPpiuPN8/6y59nHOTyafPDhwEHSI
         2wddaAQ8p5NN+ZLCS2fQhtrebiqi9SOQPqRaPUB3QEJCBP76EPmdx/lqvcMbn+mUUlan
         Zazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781444; x=1748386244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8VUd2aQwHAY7kh1IBfReT0PW2kSB1JTfPrkeq2sTu4=;
        b=aeoQrwKKyasVI5yx4FZzLak0zIinxlQ1Mn0i2KYBruTTQwi3mJ5eEbyG+pUSRv1NaA
         D6T3SqMRWaQODSYhf02Xl5jowGjWZt2HwhLY1qLcMX++C/hGgPO3EaKBeHjA04T5Vhp0
         gg5PxhxMVWsNi+lj1esRpEryHHgfIVI9/hpz4xvyph420Z2cgYKJCPeKreu0LGEPmB16
         wi07ZQKL2Ikps0uzBgzNghk/PazeHcjAVLu6ZXEm5Q/M1P8CjbR+DYKN4Q37YG9Orl47
         yjhiEEfcDCk4Vyq4T7ZiY1FVaEvy0aTv0a6Bp3nKgj3B7wA9T1rOTdU7GeKP7djQhtjE
         wlZg==
X-Forwarded-Encrypted: i=1; AJvYcCUfl3Yud6ixSSolBCQMW8Sg1lqAuv6EAlGoqsXL9+5lJFqGytXVvNefzlPOV4OfHi8Trxbdqfu5TdBZvTXf@vger.kernel.org, AJvYcCVLagOt+vgglwkqRZ8DGyTg2sWT/8paQcdhAS0UatiYHzkCzHKHnFa4W+9Ks1xZiFj3CFblqpuaowU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw2gowNWQz2wVEc0yJNtg4gsQbeSYrAaFCHSzq43aGOozwt2vB
	/XvK0ZqocY+vyqsjK+bKpwPRG3HPLFz6dMJoJkk39ZfPKLWkDKCB2QCA
X-Gm-Gg: ASbGnctXczuViKimSuFXQ/G1RV3VbUe6EUaTLtA+hqup0zqduEztGp5EvrKT4sfty47
	8I7geIJh3up7oiYNs7ZkadOEqzUbsdxPxeY8O4H6USdQkqgKIaS62xL68mIIz3EoOHCS75fsQqA
	lNwXsCjEIWkNXURL4Q8Q8lPTgiqftoceCYR3UVC5XRYWkHDRvvtYzWcQDnmjbt5Kt5cPHqYKdy+
	eu+VB0YLRYltOiIWg0Zi02sP49T/vr/UNZ6MFgBGZrREgtaMUzrUkmqjfHWSH+7Dih/gEb/pv8S
	wKW/gRekelKYiOT2xeeN0Gq0pUID3HkuXF+wlnYgIr0sZlRvd28TULGAdlZDvZJdLE4DT7+8YHB
	FLkAtEjmhSEZ2JgesR7c43A==
X-Google-Smtp-Source: AGHT+IHBf3ePZMI9lOUUD1ltsZ/8CIuUnYC8ntd/0f6j/BbrqWEhbOjdwF5/Fsih2tSKgVm4fyYatQ==
X-Received: by 2002:a05:600c:5305:b0:43b:c0fa:f9c4 with SMTP id 5b1f17b1804b1-442fda14a10mr62569665e9.4.1747781444344;
        Tue, 20 May 2025 15:50:44 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:43 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/12] iio: accel: adxl313: add basic interrupt handling
Date: Tue, 20 May 2025 22:50:02 +0000
Message-Id: <20250520225007.10990-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 131 +++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index c5673f1934fb..4cb1fe1f2616 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -49,11 +49,25 @@
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
@@ -75,7 +89,9 @@ struct adxl313_data {
 	const struct adxl313_chip_info *chip_info;
 	struct mutex	lock; /* lock to protect transf_buf */
 	int irq;
+	u8 fifo_mode;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
+	__le16		fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
 };
 
 struct adxl313_chip_info {
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 52fb10680939..8eecd2851512 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -13,12 +13,20 @@
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
@@ -62,6 +70,7 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
 	case ADXL313_REG_DATA_AXIS(4):
 	case ADXL313_REG_DATA_AXIS(5):
 	case ADXL313_REG_FIFO_STATUS:
+	case ADXL313_REG_INT_SOURCE:
 		return true;
 	default:
 		return false;
@@ -365,6 +374,116 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
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
+	int i;
+	int ret;
+
+	count = sizeof(data->fifo_buf[0]) * ADXL313_NUM_AXIS;
+	for (i = 0; i < samples; i++) {
+		ret = regmap_bulk_read(data->regmap, ADXL313_REG_XYZ_BASE,
+				       data->fifo_buf + (i * count / 2), count);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static void adxl313_fifo_reset(struct adxl313_data *data)
+{
+	int regval;
+	int samples;
+
+	adxl313_set_measure_en(data, false);
+
+	/* clear samples */
+	samples = adxl313_get_samples(data);
+	if (samples)
+		adxl313_fifo_transfer(data, samples);
+
+	/* clear interrupt register */
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
+	if (FIELD_GET(ADXL313_INT_OVERRUN, int_stat))
+		goto err;
+
+	return IRQ_HANDLED;
+err:
+	adxl313_fifo_reset(data);
+
+	return IRQ_HANDLED;
+}
+
 static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			      unsigned int writeval, unsigned int *readval)
 {
@@ -486,6 +605,18 @@ int adxl313_core_probe(struct device *dev,
 		ret = regmap_write(data->regmap, ADXL313_REG_INT_MAP, regval);
 		if (ret)
 			return ret;
+
+		ret  = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+						   &adxl313_buffer_ops);
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


