Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF139351863
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 19:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhDARpr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234614AbhDARiZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9495B613CB;
        Thu,  1 Apr 2021 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617297609;
        bh=EshraPHggvWBzitSNOCgch/Nz5TGMwmZb4MjOUvnq78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/CryuzyglWNhXqf/lCuSoCSNdlnMAR4DJQzkA8pETAsmZnZz9xjTVN7IMHhHDUiC
         c/enp9R3/SgmMk7fhPu6OWSR3tHWI+sY48/eFQF4QFasqpnBSeGRgE/Qw8hq9JGzmp
         9QGkk1l0ZCwWc2vscIOu7oiTSznGl5NDeKz70VE18mY3rX8iAAgADV3+KVOOVJkity
         xWQOChNHXCK/C5tCZe+vh3OhMbkBO+Df2P8ZfLMOAiXz6+iNsvboBSeN1h2pWZ0Ozf
         z4J8uDK58Xwkh11BhPryn4zI4uUQucceC+jYT+I/rkAW2Th67171cri4DfhbRXLZzB
         qOnrab7PZ+xSw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/3] iio:adc:ad7476: Handle the different regulators used by various parts.
Date:   Thu,  1 Apr 2021 18:17:58 +0100
Message-Id: <20210401171759.318140-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401171759.318140-1-jic23@kernel.org>
References: <20210401171759.318140-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not all of the parts supported by this driver use single supply.
Hence we add chip_info fields to say what additional supplies exist
and in the case of vref, ensure that is used for the reference voltage
rather than vcc.

Tested using really simple QEMU model and some fixed regulators.

The devm_add_action_or_reset() callback is changed to take the
regulator as it's parameter so we can use one callback for all the
different regulators without having to store pointers to them in
the iio_priv() structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/adc/ad7476.c | 81 +++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 9e9ff07cf972..49f7d252b200 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -32,12 +32,14 @@ struct ad7476_chip_info {
 	/* channels used when convst gpio is defined */
 	struct iio_chan_spec		convst_channel[2];
 	void (*reset)(struct ad7476_state *);
+	bool				has_vref;
+	bool				has_vdrive;
 };
 
 struct ad7476_state {
 	struct spi_device		*spi;
 	const struct ad7476_chip_info	*chip_info;
-	struct regulator		*reg;
+	struct regulator		*ref_reg;
 	struct gpio_desc		*convst_gpio;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
@@ -53,12 +55,15 @@ struct ad7476_state {
 
 enum ad7476_supported_device_ids {
 	ID_AD7091R,
+	ID_AD7273,
+	ID_AD7274,
 	ID_AD7276,
 	ID_AD7277,
 	ID_AD7278,
 	ID_AD7466,
 	ID_AD7467,
 	ID_AD7468,
+	ID_AD7475,
 	ID_AD7495,
 	ID_AD7940,
 	ID_ADC081S,
@@ -146,7 +151,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (!st->chip_info->int_vref_uv) {
-			scale_uv = regulator_get_voltage(st->reg);
+			scale_uv = regulator_get_voltage(st->ref_reg);
 			if (scale_uv < 0)
 				return scale_uv;
 		} else {
@@ -194,6 +199,16 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 		.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 		.reset = ad7091_reset,
 	},
+	[ID_AD7273] = {
+		.channel[0] = AD7940_CHAN(10),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+		.has_vref = true,
+	},
+	[ID_AD7274] = {
+		.channel[0] = AD7940_CHAN(12),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+		.has_vref = true,
+	},
 	[ID_AD7276] = {
 		.channel[0] = AD7940_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
@@ -218,10 +233,17 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 		.channel[0] = AD7476_CHAN(8),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
+	[ID_AD7475] = {
+		.channel[0] = AD7476_CHAN(12),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+		.has_vref = true,
+		.has_vdrive = true,
+	},
 	[ID_AD7495] = {
 		.channel[0] = AD7476_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 		.int_vref_uv = 2500000,
+		.has_vdrive = true,
 	},
 	[ID_AD7940] = {
 		.channel[0] = AD7940_CHAN(14),
@@ -254,6 +276,7 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_LTC2314_14] = {
 		.channel[0] = AD7940_CHAN(14),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+		.has_vref = true,
 	},
 };
 
@@ -263,15 +286,16 @@ static const struct iio_info ad7476_info = {
 
 static void ad7476_reg_disable(void *data)
 {
-	struct ad7476_state *st = data;
+	struct regulator *reg = data;
 
-	regulator_disable(st->reg);
+	regulator_disable(reg);
 }
 
 static int ad7476_probe(struct spi_device *spi)
 {
 	struct ad7476_state *st;
 	struct iio_dev *indio_dev;
+	struct regulator *reg;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -282,19 +306,50 @@ static int ad7476_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	st->reg = devm_regulator_get(&spi->dev, "vcc");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
+	reg = devm_regulator_get(&spi->dev, "vcc");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
-	ret = regulator_enable(st->reg);
+	ret = regulator_enable(reg);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, ad7476_reg_disable,
-				       st);
+	ret = devm_add_action_or_reset(&spi->dev, ad7476_reg_disable, reg);
 	if (ret)
 		return ret;
 
+	if (st->chip_info->has_vref) {
+		reg = devm_regulator_get(&spi->dev, "vref");
+		if (IS_ERR(reg))
+			return PTR_ERR(reg);
+
+		ret = regulator_enable(reg);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7476_reg_disable,
+					       reg);
+		if (ret)
+			return ret;
+	}
+	/* Either vcc or vref as appropriate */
+	st->ref_reg = reg;
+
+	if (st->chip_info->has_vdrive) {
+		reg = devm_regulator_get(&spi->dev, "vdrive");
+		if (IS_ERR(reg))
+			return PTR_ERR(reg);
+
+		ret = regulator_enable(reg);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7476_reg_disable,
+					       reg);
+		if (ret)
+			return ret;
+	}
+
 	st->convst_gpio = devm_gpiod_get_optional(&spi->dev,
 						  "adi,conversion-start",
 						  GPIOD_OUT_LOW);
@@ -335,15 +390,15 @@ static int ad7476_probe(struct spi_device *spi)
 static const struct spi_device_id ad7476_id[] = {
 	{"ad7091", ID_AD7091R},
 	{"ad7091r", ID_AD7091R},
-	{"ad7273", ID_AD7277},
-	{"ad7274", ID_AD7276},
+	{"ad7273", ID_AD7273},
+	{"ad7274", ID_AD7274},
 	{"ad7276", ID_AD7276},
 	{"ad7277", ID_AD7277},
 	{"ad7278", ID_AD7278},
 	{"ad7466", ID_AD7466},
 	{"ad7467", ID_AD7467},
 	{"ad7468", ID_AD7468},
-	{"ad7475", ID_AD7466},
+	{"ad7475", ID_AD7475},
 	{"ad7476", ID_AD7466},
 	{"ad7476a", ID_AD7466},
 	{"ad7477", ID_AD7467},
-- 
2.31.1

