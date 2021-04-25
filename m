Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817F336A863
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhDYQeP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 12:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230359AbhDYQeO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Apr 2021 12:34:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AAA661284;
        Sun, 25 Apr 2021 16:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619368414;
        bh=cJP2j/et9mnYMsRKtw7VBAxmDc1dBAqRlgNuoVrduyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FT52rWsHvm/G4U5anxtPTLQmHWYG2/o5PxAmckJ8RESMduZWvxotoFthhpQr4Nr/p
         go3XL35JHIEWMZI7pOA+K1s78nz168ouFLF7SyeWFRxFxnIEKWa91yW9ZCRfZTIb30
         +q6yf43TTZxWvicMbzmKQHWC9UEqYyvm6eaZhfO/QU7pJSax3N1PzHW99REAlCtBU0
         e38IvhH81r9PFu+/cGsvlyG0cHF4oXjghueaGm6Wg/d/Z9dhsU+gojnGoD/8LWpTee
         23MyWBrVIr90KudCbNuNoX89znqEIFmzM/hYYi2qEzb4cgZyjy/lnMrQVGz3yjPMHZ
         8YR1h+wfbYvTQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 1/2] iio:adc:ad7476: Handle the different regulators used by various parts.
Date:   Sun, 25 Apr 2021 17:31:53 +0100
Message-Id: <20210425163154.73209-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210425163154.73209-1-jic23@kernel.org>
References: <20210425163154.73209-1-jic23@kernel.org>
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

One corner case is the ad7091r which has an internal reference that
can be over-driven by an external reference connected on the vref pin.
To handle that force_ext_vref is introduced and set if an optional
vref regulator is present.

Tested using really simple QEMU model and some fixed regulators.

The devm_add_action_or_reset() callback is changed to take the
regulator as it's parameter so we can use one callback for all the
different regulators without having to store pointers to them in
the iio_priv() structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Reported-by: kernel test robot <lkp@intel.com>
---
v4: Added check that the optional regulator is indeed not there rather
    than some other error case (deferred for example).
    That code is a little convoluted but having tried a few options this
    is the cleanest I could come up with.

drivers/iio/adc/ad7476.c | 118 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 9e9ff07cf972..9d5a71df02b0 100644
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
@@ -52,13 +54,17 @@ struct ad7476_state {
 };
 
 enum ad7476_supported_device_ids {
+	ID_AD7091,
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
@@ -145,8 +151,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (!st->chip_info->int_vref_uv) {
-			scale_uv = regulator_get_voltage(st->reg);
+		if (st->ref_reg) {
+			scale_uv = regulator_get_voltage(st->ref_reg);
 			if (scale_uv < 0)
 				return scale_uv;
 		} else {
@@ -187,13 +193,32 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 		BIT(IIO_CHAN_INFO_RAW))
 
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
+	[ID_AD7091] = {
+		.channel[0] = AD7091R_CHAN(12),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+		.convst_channel[0] = AD7091R_CONVST_CHAN(12),
+		.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+		.reset = ad7091_reset,
+	},
 	[ID_AD7091R] = {
 		.channel[0] = AD7091R_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 		.convst_channel[0] = AD7091R_CONVST_CHAN(12),
 		.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+		.int_vref_uv = 2500000,
+		.has_vref = true,
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
@@ -218,10 +243,17 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
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
@@ -254,6 +286,7 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_LTC2314_14] = {
 		.channel[0] = AD7940_CHAN(14),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+		.has_vref = true,
 	},
 };
 
@@ -263,15 +296,16 @@ static const struct iio_info ad7476_info = {
 
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
@@ -282,19 +316,73 @@ static int ad7476_probe(struct spi_device *spi)
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
 
+	/* Either vcc or vref (below) as appropriate */
+	if (!st->chip_info->int_vref_uv)
+		st->ref_reg = reg;
+
+	if (st->chip_info->has_vref) {
+
+		/* If a device has an internal reference vref is optional */
+		if (st->chip_info->int_vref_uv) {
+			reg = devm_regulator_get_optional(&spi->dev, "vref");
+			if (IS_ERR(reg) && (PTR_ERR(reg) != -ENODEV))
+				return PTR_ERR(reg);
+		} else {
+			reg = devm_regulator_get(&spi->dev, "vref");
+			if (IS_ERR(reg))
+				return PTR_ERR(reg);
+		}
+
+		if (!IS_ERR(reg)) {
+			ret = regulator_enable(reg);
+			if (ret)
+				return ret;
+
+			ret = devm_add_action_or_reset(&spi->dev,
+						       ad7476_reg_disable,
+						       reg);
+			if (ret)
+				return ret;
+			st->ref_reg = reg;
+		} else {
+			/*
+			 * Can only get here if device supports both internal
+			 * and external reference, but the regulator connected
+			 * to the external reference is not connected.
+			 * Set the reference regulator pointer to NULL to
+			 * indicate this.
+			 */
+			st->ref_reg = NULL;
+		}
+	}
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
@@ -333,17 +421,17 @@ static int ad7476_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7476_id[] = {
-	{"ad7091", ID_AD7091R},
+	{"ad7091", ID_AD7091},
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

