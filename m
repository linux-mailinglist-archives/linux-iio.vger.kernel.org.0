Return-Path: <linux-iio+bounces-21273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01545AF65FB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8184A68BC
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D99C2F5C4A;
	Wed,  2 Jul 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3w7pq5t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FBE2BE644;
	Wed,  2 Jul 2025 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497711; cv=none; b=ijkbEWPFweZ5nuoGSrgWqYmVaUGeYxzUSAXXy+ebxGGtRkbsx4BfcVPPuXu8TbUw49ANh6VR3+NhfLVK50OQOa0SK9p7q23PDOVflUgA4TW3HbeAKa2i3sjAVNbpFVUcNyiqhLGavIg17bN/D5xA7gJEDaEF2xfcz1ObhREGo2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497711; c=relaxed/simple;
	bh=W8UnioKDfdx8IP5If9lsSbYY5UctZMdXwbu8U8GxSJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PON+x+niNSctoslLDLPNYKw8dFolR0IllEIVVVq0IA8GA7fnwFuA0oR5RMUSrKUo7kJ8GceNkR1vAGYsONx+T+wdW3jOCHUeu8isZXCIXc9yEU2EXi1pgTfOgZwigMN/SyZqWOHPvC4QnaWp0v4oLWI35MJmPQE8dCuyQQUD+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3w7pq5t; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae34f43be56so76265666b.2;
        Wed, 02 Jul 2025 16:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497707; x=1752102507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2YbcLMTJ6lKMMhbKpAMSycC4sdmH5CcU8bHTvj6qNM=;
        b=O3w7pq5twoyLFg/X3lg7I5FRpRXsTDpWpaYiulTGS+GTGLYeuWYzzlv9aGSVAK0VTp
         rP/WrUm/fbG12h/b26Hk9PyEhphkvD4BsN5BRhUYv844asHY3Tkhhmle+nKokdEszACr
         i0eEikG9kBL0AODhm2jxjobY/kGXz6wUFpZnRTy+/XQGf8MoiLMqJSdxZQ/Y0jigOMor
         ZSclhNlDPoBZjBjXiVHn5UvsW9YEwPFmMcDmSG8Lwz8zgwdtBTJ8VIDZIRIEEMIy8JAL
         Zm0Ga/EKYKIKPpRjCuf01KP22zTsjtsVd7HQi/0zoLcx3zhAFUjGY71xBLcSe84b32Yn
         TofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497707; x=1752102507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2YbcLMTJ6lKMMhbKpAMSycC4sdmH5CcU8bHTvj6qNM=;
        b=sYT/jyXqkVuQwFs9+nuPzgh8495AyNVTCWjYHacXNdzn98d2Quzf5fnV90UZlX/nH1
         mZSuWrCFGNh0wVh8fPvr43SRrfqOY3qTNuPq9rFSICiEASg0UBz9ecw+u3b71Wgq5FoB
         Rg+fwKNxHus2zQu1ke/RPlyzjHyvbgtJDqOO4DVbFCOuQMePRVlfvxpiVX05hDJpbYlw
         LOjS5ZL1T/ooCItOpn3g4msgaSd57cM4Lw/N/yKpnKiEqctqtPbjux8ZJBFeIi9aaL7v
         bGLlUZXSQ2g/JqF87a8VQ9JgDWaIJxqskNSasrSouEtwto+rT+izjO3DyvQs0itLKvPf
         70Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUtUR3TAGUjgpNTxWYNeBW8rM5QWTjP/PLPZjyWuXkpeTGyjCuIK1Z3z60luk0lLI/IBQ9m/X/pY+I=@vger.kernel.org, AJvYcCW9DN2KgFDbphqU64XxQj5fAwQJWG5dLFlBHkiGKgHfWT7tVX23vBUenfVCuzM1Wvlwg5EsAqKvrpQD@vger.kernel.org, AJvYcCWftkO0zI0vtDYTXkKpumb86j4klsdx3eAnZBRW+bhmWCRyxZi2QxidZ8P0I5xyEEhTiCKH4LLFyIjsOBBy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5p8LiystMo3PuZ8L1PJqlm14Vhfo6ZRCfGq7/Y5WNKRTiiUdX
	uUScSM4J7TXFD8JK+Cq4oltnrn2/WxCIfMZE2diqO/9AGu0G8hRJLcxz
X-Gm-Gg: ASbGnctcHs3pLRrsOnwwXdREovd+eiyvjxdh+1Q5X3Zil3H9QPs7gX3UHYoefw71zsb
	9/4MF54ZzNyuROb+L7i4Rx3VqumuzgFHTuj2BTyq4KB2SFbE7f/kboo/ytvkNPhQ4AXifsqhOQg
	vZLbdTkzKwzFlPx4+8Oh74DJxkkOJAa/we28vSV9MNkMcuOlpU5XldNLdGjOaBwkSR74Kg6Xvou
	1O/u1fSUAPvhKfDSGnHBmHzgVIU5FhtHCQWIk8TiHangNMbbDcbb3DOMI6V9/yH/r4cTTTeJQq1
	lztR6DatxDpeFzc06S0AmoRAqkaYu1ceBy3OPjp2YfIn6X8qWi2pGrDl05NgnYQgES2u9fob0Ba
	WIlbOOfNRq/xfRd7HihwZj+eYrt2ZwRqE
X-Google-Smtp-Source: AGHT+IHlKKNOl6+RP+oZRuJOjqNDWG9NmplZVCyQxd86eWd/e1cfkgu/ZaXBRkyK209LuTLcFltnhg==
X-Received: by 2002:a17:907:8688:b0:ae0:caeb:276d with SMTP id a640c23a62f3a-ae3e2558432mr6260666b.4.1751497707142;
        Wed, 02 Jul 2025 16:08:27 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca18bbsm1158355566b.151.2025.07.02.16.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:26 -0700 (PDT)
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
Subject: [PATCH v7 3/8] iio: accel: adxl313: add buffered FIFO watermark with interrupt handling
Date: Wed,  2 Jul 2025 23:08:14 +0000
Message-Id: <20250702230819.19353-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230819.19353-1-l.rubusch@gmail.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover the following tasks:
- Add scan_mask and scan_index to the IIO channel configuration. The
scan_index sets up buffer usage. According to the datasheet, the ADXL313
uses a 13-bit wide data field in full-resolution mode. Set the
signedness, number of storage bits, and endianness accordingly.

- Parse the devicetree for an optional interrupt line and configure the
interrupt mapping based on its presence. If no interrupt line is
specified, keep the FIFO in bypass mode as currently implemented.

- Set up the interrupt handler. Add register access to detect and
evaluate interrupts. Implement functions to clear status registers and
reset the FIFO.

- Implement FIFO watermark configuration and handling. Allow the
watermark level to be set, evaluate the corresponding interrupt, read
the FIFO contents, and push the data to the IIO channel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  22 +++
 drivers/iio/accel/adxl313_core.c | 264 ++++++++++++++++++++++++++++++-
 2 files changed, 280 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 6958a00f5e8f..4f4a9fd39f6d 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -21,6 +21,7 @@
 #define ADXL313_REG_ACT_INACT_CTL	0x27
 #define ADXL313_REG_BW_RATE		0x2C
 #define ADXL313_REG_POWER_CTL		0x2D
+#define ADXL313_REG_INT_ENABLE		0x2E
 #define ADXL313_REG_INT_MAP		0x2F
 #define ADXL313_REG_INT_SOURCE		0x30
 #define ADXL313_REG_DATA_FORMAT		0x31
@@ -46,6 +47,25 @@
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
+#define ADXL313_REG_FIFO_CTL_MODE_MSK		GENMASK(7, 6)
+
+#define ADXL313_FIFO_BYPASS			0
+#define ADXL313_FIFO_STREAM			2
+
+#define ADXL313_FIFO_SIZE			32
+
+#define ADXL313_NUM_AXIS			3
+
 extern const struct regmap_access_table adxl312_readable_regs_table;
 extern const struct regmap_access_table adxl313_readable_regs_table;
 extern const struct regmap_access_table adxl314_readable_regs_table;
@@ -66,7 +86,9 @@ struct adxl313_data {
 	struct regmap	*regmap;
 	const struct adxl313_chip_info *chip_info;
 	struct mutex	lock; /* lock to protect transf_buf */
+	u8 watermark;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
+	__le16		fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
 };
 
 struct adxl313_chip_info {
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 1be4e867f4b2..04ca8491bb5c 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -8,11 +8,23 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+
 #include "adxl313.h"
 
+#define ADXL313_INT_NONE			U8_MAX
+#define ADXL313_INT1				1
+#define ADXL313_INT2				2
+
+#define ADXL313_REG_XYZ_BASE			ADXL313_REG_DATA_AXIS(0)
+
 static const struct regmap_range adxl312_readable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
 	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
@@ -195,9 +207,10 @@ static const int adxl313_odr_freqs[][2] = {
 	[9] = { 3200, 0 },
 };
 
-#define ADXL313_ACCEL_CHANNEL(index, axis) {				\
+#define ADXL313_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
-	.address = index,						\
+	.scan_index = (index),						\
+	.address = (reg),						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
@@ -207,14 +220,26 @@ static const int adxl313_odr_freqs[][2] = {
 	.info_mask_shared_by_type_available =				\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 	.scan_type = {							\
+		.sign = 's',						\
 		.realbits = 13,						\
+		.storagebits = 16,					\
+		.endianness = IIO_BE,					\
 	},								\
 }
 
+enum adxl313_chans {
+	chan_x, chan_y, chan_z,
+};
+
 static const struct iio_chan_spec adxl313_channels[] = {
-	ADXL313_ACCEL_CHANNEL(0, X),
-	ADXL313_ACCEL_CHANNEL(1, Y),
-	ADXL313_ACCEL_CHANNEL(2, Z),
+	ADXL313_ACCEL_CHANNEL(0, chan_x, X),
+	ADXL313_ACCEL_CHANNEL(1, chan_y, Y),
+	ADXL313_ACCEL_CHANNEL(2, chan_z, Z),
+};
+
+static const unsigned long adxl313_scan_masks[] = {
+	BIT(chan_x) | BIT(chan_y) | BIT(chan_z),
+	0
 };
 
 static int adxl313_set_odr(struct adxl313_data *data,
@@ -345,6 +370,173 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	int ret;
+
+	value = min(value, ADXL313_FIFO_SIZE - 1);
+
+	ret = adxl313_set_measure_en(data, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADXL313_REG_FIFO_CTL,
+				 ADXL313_REG_FIFO_CTL_MODE_MSK, value);
+	if (ret)
+		return ret;
+
+	data->watermark = value;
+
+	ret = regmap_set_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+			      ADXL313_INT_WATERMARK);
+	if (ret)
+		return ret;
+
+	return adxl313_set_measure_en(data, true);
+}
+
+static int adxl313_get_samples(struct adxl313_data *data)
+{
+	unsigned int regval;
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
+				       sizeof(data->fifo_buf[0]) * ADXL313_NUM_AXIS);
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
+	/* Set FIFO modes with measurement turned off, according to datasheet */
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
+static irqreturn_t adxl313_irq_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct adxl313_data *data = iio_priv(indio_dev);
+	int samples, int_stat;
+
+	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
+		return IRQ_NONE;
+
+	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
+		samples = adxl313_get_samples(data);
+		if (samples < 0)
+			goto err;
+
+		if (adxl313_fifo_push(indio_dev, samples))
+			goto err;
+	}
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
@@ -359,6 +551,7 @@ static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
 	.read_avail	= adxl313_read_freq_avail,
+	.hwfifo_set_watermark = adxl313_set_watermark,
 	.debugfs_reg_access = &adxl313_reg_access,
 };
 
@@ -407,6 +600,19 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 	return adxl313_set_measure_en(data, true);
 }
 
+static unsigned int adxl313_get_int_type(struct device *dev, int *irq)
+{
+	*irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (*irq > 0)
+		return ADXL313_INT1;
+
+	*irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+	if (*irq > 0)
+		return ADXL313_INT2;
+
+	return ADXL313_INT_NONE;
+}
+
 /**
  * adxl313_core_probe() - probe and setup for adxl313 accelerometer
  * @dev:	Driver model representation of the device
@@ -424,7 +630,9 @@ int adxl313_core_probe(struct device *dev,
 {
 	struct adxl313_data *data;
 	struct iio_dev *indio_dev;
-	int ret;
+	u8 int_line;
+	u8 int_map_msk;
+	int irq, ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -441,6 +649,7 @@ int adxl313_core_probe(struct device *dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl313_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
+	indio_dev->available_scan_masks = adxl313_scan_masks;
 
 	ret = adxl313_setup(dev, data, setup);
 	if (ret) {
@@ -448,6 +657,49 @@ int adxl313_core_probe(struct device *dev,
 		return ret;
 	}
 
+	int_line = adxl313_get_int_type(dev, &irq);
+	if (int_line == ADXL313_INT_NONE) {
+		/*
+		 * FIFO_BYPASSED mode
+		 *
+		 * When no interrupt lines are specified, the driver falls back
+		 * to use the sensor in FIFO_BYPASS mode. This means turning off
+		 * internal FIFO and interrupt generation (since there is no
+		 * line specified). Unmaskable interrupts such as overrun or
+		 * data ready won't interfere. Even that a FIFO_STREAM mode w/o
+		 * connected interrupt line might allow for obtaining raw
+		 * measurements, a fallback to disable interrupts when no
+		 * interrupt lines are connected seems to be the cleaner
+		 * solution.
+		 */
+		ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
+				   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK,
+					      ADXL313_FIFO_BYPASS));
+		if (ret)
+			return ret;
+	} else {
+		/* FIFO_STREAM mode */
+		int_map_msk = ADXL313_INT_DREADY | ADXL313_INT_ACTIVITY |
+			ADXL313_INT_INACTIVITY | ADXL313_INT_WATERMARK |
+			ADXL313_INT_OVERRUN;
+		ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_MAP,
+					 int_map_msk, int_line == ADXL313_INT2);
+		if (ret)
+			return ret;
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
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(adxl313_core_probe, "IIO_ADXL313");
-- 
2.39.5


