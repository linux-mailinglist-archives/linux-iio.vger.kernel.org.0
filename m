Return-Path: <linux-iio+bounces-19622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A270ABAFC9
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D171898695
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E19021CC43;
	Sun, 18 May 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fidtkomw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDAC21B9FD;
	Sun, 18 May 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566826; cv=none; b=f/3cD8oeWqB3DhanFX5Zk8K7+aGRICQB1Xmmv1CY03EUfwC5LgeAxdGb1/GVoPVGPVtp3MUF+RtQwRGZpiCPSHRaatKDWwKrbPike4SWRvosQ0FnL96HD4071AZYxqW4Pm/1+T+iAEKCO0Tyy9ThgDoomBA0j05GFEaUvSfP3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566826; c=relaxed/simple;
	bh=2eYAtuPAxEomrjII9azThshrvACXgU7QkFRQ+DfSJOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZ3QiG07IDG+LsKacBxo3w95IHGt5O+rnNyKElG+WEmFMBO06LJNcE3Cyz7Sk060Hmap0Obp3MCcOUIt9t4WcIBBnzTeNBOk8GbF6IHru/qo2bHQ7NO3pbluv0TdEz+REF4fM+bduo0Sr4KIHdi/9hyD3zpAnvpEJ5OXe0x58yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fidtkomw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a35ae46214so270650f8f.2;
        Sun, 18 May 2025 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566822; x=1748171622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uNN7E1FK1U1Y8BuNgmbbshONk0ntIiyJ5/yC1vuARQ=;
        b=fidtkomwuB6IZvAYdgJyxm7elYF92IHCzpwBDs7UDi6bMUUMTBgSK2S58QxtbUVu3u
         6IAbEbmZA5I44UAknyvAHueriu9Lrd42/c7Ztr3bPjdCxCuDozRXmVU4oGXnQG0LPTOZ
         0Pgsv+q8MoP7FLIMV70wKWg5LpjrKxzIJJTwtyhQt0bBoENOS3FPUQB7ZM2+Mx/5lR/8
         LUa4tlxClhBpzWEVhUZgiPcqDOb3MzQCpeCt51E667fynsziyPbDv/aUps457V7bln+s
         pFwilp7thFvgmOYPSyQSxqa70LDEbWh4iuTJOrp8ayjwFDsOY/E4ZNzrMnOPHP0ZjmRo
         EgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566822; x=1748171622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uNN7E1FK1U1Y8BuNgmbbshONk0ntIiyJ5/yC1vuARQ=;
        b=Cdh7LOlNmodbgR6Iw8H/TAHJqnFzyDjEKKpxap6N7M6ayT0rTGWTPiJ/qj6a8tUQHp
         NiEBEhxq1Yl7fVcIfFM3jTTg0x19ZRmfz6u8ffXV9w3uwCkUaY7CCX0ktMublrHxnfGX
         ZyvgOnywhi0QIBJU/7/mUG1pxgbMLESnyaY+p8kOUzAiuB0FzBzISQbCoeDw38Hrn/FU
         F1IT2W2nC9VZUnOWDYOBVgjdZTpOGUQEiAvgVRgrrBDN1sy7XLVpDgZ5i4/4x7/B+SNv
         V6PbCi2AwM25UCriw5HfHSVCOxlKUctj7fnlCGSXpY7CYrrZAHHaYcJnrH177QzDGyCu
         iuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnxofcfpcUBoA2ZCNQDMdUcMnIF5u7KM39JnL+QflqtEiAlyF2AmlRGnVxhWSeEX7g1Vl8xsgy/ak=@vger.kernel.org, AJvYcCWZXDNLRPjgLGle38Oa1x4vENPAn9ZEHzblrXe6mCfTKLcDBLVwD9toMsH2dOi7UNL0bgZhxmmjv732a7FR@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHtZdj4hs2x8SUGqLYtreL6Fch4BZCg3905e5lnacPE/22uJ/
	8aJ3pWL0oGEOBH6uzF14Ww2W476Tkzo93dyG+/J0IeKNImGJGWGkI6Sk
X-Gm-Gg: ASbGncsMVt1JA44T55zFSe0GQrsEzMvtCUaHNl/QkOW5T/Af/+s8EQQFTUPmaJk8yo/
	xh4HOc27rb6bM5S481QSERIUUSvf/I1CbO+Ywx0+9LJhXhdfJ5olkAu0ufHUuNfohqo0cfBeCOn
	o9K5ft4Mt9CJpS2cDi8jWZOT7hsyHwJWcpnmo6jzT1RQHNvGqo7/IJMHqhN772JaWZ/Ujr6pE7q
	WQ+aMetcEleZzKQ+nLxtg5A3XQ1f4HMUm019g4exMrfkonB3rAH9JcQZ7l1l9Ephxvh082z4LSz
	4fNzmsLLB2mINdSSnX5GRieYlfrIk1f/kjuRzPIO6Yf7DQWs7NYP52HDpEOpU1aQ9Uh4cygQn10
	sqYxY4VEjeKkWsaCeC/EP0w==
X-Google-Smtp-Source: AGHT+IGkP5LqCSc0op2tqB9lI1ofqcAz50cM3ED8i523uCNvn4lrKNh/otoOtTxBKR+7KKZAhieGTA==
X-Received: by 2002:a5d:5989:0:b0:3a0:89df:3b91 with SMTP id ffacd0b85a97d-3a35c834f7amr3351512f8f.7.1747566822312;
        Sun, 18 May 2025 04:13:42 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:41 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 07/12] iio: accel: adxl313: add basic interrupt handling
Date: Sun, 18 May 2025 11:13:16 +0000
Message-Id: <20250518111321.75226-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 133 +++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

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
index 05e99708c2c1..574962a8f35d 100644
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
 
 #define ADXL313_INT_NONE			0
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
@@ -365,6 +374,118 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
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
+			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK,
+				      data->fifo_mode));
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
+	ret = 0;
+	count = sizeof(data->fifo_buf[0]) * ADXL313_NUM_AXIS;
+	for (i = 0; i < samples; i++) {
+		ret = regmap_bulk_read(data->regmap, ADXL313_REG_XYZ_BASE,
+				       data->fifo_buf + (i * count / 2), count);
+		if (ret)
+			return ret;
+	}
+	return ret;
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
@@ -486,6 +607,18 @@ int adxl313_core_probe(struct device *dev,
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


