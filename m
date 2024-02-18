Return-Path: <linux-iio+bounces-2732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF82859827
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4102B20C2A
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D06EB6A;
	Sun, 18 Feb 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEd5dv+/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC11E86B
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277279; cv=none; b=Pfj6SJP6V+gHB7s/dMv+CQM7FnzfllQJe1J81KDT1vULqKa0pRHUZYn0mhFTYoUdu4F5CndPpZYTLZvZLyAjHSDtWryin3r9HHg6rZS0HOAMOUBdg6ffhOqus3ImETOIdMk042zvgjjMN2hl2R3XVRQeB62l5ipF6opOrkvtfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277279; c=relaxed/simple;
	bh=XeCS07l4BIxmyFSal6vNGmC2/PZ9hnxuZ+EuravMu8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2+XQ9Uk/y6TwICFxf8jBgUTnvUtkXzMaWVsbsG/OOOHi2UGXEASOBM0WO9v4q3sOPpyq2b8HCKgf18F2jFw6UlNgGTcrWi1ma59Rm9n/tswnD0xm+xKfmXkh3c6ey+VAC0uLafSvb+5BoifvRsmoqdrjwJ4bQm2P3zi15fxyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEd5dv+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A2AC43390;
	Sun, 18 Feb 2024 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277279;
	bh=XeCS07l4BIxmyFSal6vNGmC2/PZ9hnxuZ+EuravMu8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEd5dv+/ZlL+bn3DyDYuiSp+0+7EsZ4PCC9bSnKab+yygzyFkYDWRlzY/PcbsnL1k
	 pp41lWaHSWbIjjeT6q0KfTIylXQJqgyjJOIxdQuTDiFzSwFmysUnilfqS4E9jM5V+6
	 NlLfL/VVvyLauQ5k9YIPiW2cbkdYrikAIs/+Z05nUyFrB/ymgwjOA35YhsmNeiaqmf
	 7YNc6qpfxyNQRK+59RKcQSSWHxCqo+0alpOp8Tzp6TKJlGGqnNluWV6+AQCO4g2GcR
	 Hdb9PWlk97uTQst7eB0ByREKS25/Rstr5LbkeBRlX9XuLE0vJVmgmcraHrZPGyNqWz
	 aBLYrezuD+yyw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/8] iio: adc: ad7192: Convert from of specific to fwnode property handling
Date: Sun, 18 Feb 2024 17:27:28 +0000
Message-ID: <20240218172731.1023367-6-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218172731.1023367-1-jic23@kernel.org>
References: <20240218172731.1023367-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Enables use of with other firmwware types.
Removes a case of device tree specific handlers that might get copied
into new drivers.

Cc: Alisa-Dariana Roman <alisa.roman@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7192.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index adc3cbe92d6e..7bcc7e2aa2a2 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -17,7 +17,9 @@
 #include <linux/err.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -364,19 +366,19 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
 		freq <= AD7192_EXT_FREQ_MHZ_MAX);
 }
 
-static int ad7192_of_clock_select(struct ad7192_state *st)
+static int ad7192_clock_select(struct ad7192_state *st)
 {
-	struct device_node *np = st->sd.spi->dev.of_node;
+	struct device *dev = &st->sd.spi->dev;
 	unsigned int clock_sel;
 
 	clock_sel = AD7192_CLK_INT;
 
 	/* use internal clock */
 	if (!st->mclk) {
-		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
+		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
 			clock_sel = AD7192_CLK_INT_CO;
 	} else {
-		if (of_property_read_bool(np, "adi,clock-xtal"))
+		if (device_property_read_bool(dev, "adi,clock-xtal"))
 			clock_sel = AD7192_CLK_EXT_MCLK1_2;
 		else
 			clock_sel = AD7192_CLK_EXT_MCLK2;
@@ -385,7 +387,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	return clock_sel;
 }
 
-static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
+static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
 	bool rej60_en, refin2_en;
@@ -407,7 +409,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 	id = FIELD_GET(AD7192_ID_MASK, id);
 
 	if (id != st->chip_info->chip_id)
-		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X != 0x%X)\n",
+		dev_warn(dev, "device ID query failed (0x%X != 0x%X)\n",
 			 id, st->chip_info->chip_id);
 
 	st->mode = FIELD_PREP(AD7192_MODE_SEL_MASK, AD7192_MODE_IDLE) |
@@ -416,30 +418,30 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 
 	st->conf = FIELD_PREP(AD7192_CONF_GAIN_MASK, 0);
 
-	rej60_en = of_property_read_bool(np, "adi,rejection-60-Hz-enable");
+	rej60_en = device_property_read_bool(dev, "adi,rejection-60-Hz-enable");
 	if (rej60_en)
 		st->mode |= AD7192_MODE_REJ60;
 
-	refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
+	refin2_en = device_property_read_bool(dev, "adi,refin2-pins-enable");
 	if (refin2_en && st->chip_info->chip_id != CHIPID_AD7195)
 		st->conf |= AD7192_CONF_REFSEL;
 
 	st->conf &= ~AD7192_CONF_CHOP;
 
-	buf_en = of_property_read_bool(np, "adi,buffer-enable");
+	buf_en = device_property_read_bool(dev, "adi,buffer-enable");
 	if (buf_en)
 		st->conf |= AD7192_CONF_BUF;
 
-	bipolar = of_property_read_bool(np, "bipolar");
+	bipolar = device_property_read_bool(dev, "bipolar");
 	if (!bipolar)
 		st->conf |= AD7192_CONF_UNIPOLAR;
 
-	burnout_curr_en = of_property_read_bool(np,
-						"adi,burnout-currents-enable");
+	burnout_curr_en = device_property_read_bool(dev,
+						    "adi,burnout-currents-enable");
 	if (burnout_curr_en && buf_en) {
 		st->conf |= AD7192_CONF_BURN;
 	} else if (burnout_curr_en) {
-		dev_warn(&st->sd.spi->dev,
+		dev_warn(dev,
 			 "Can't enable burnout currents: see CHOP or buffer\n");
 	}
 
@@ -1117,9 +1119,7 @@ static int ad7192_probe(struct spi_device *spi)
 	}
 	st->int_vref_mv = ret / 1000;
 
-	st->chip_info = of_device_get_match_data(&spi->dev);
-	if (!st->chip_info)
-		st->chip_info = (void *)spi_get_device_id(spi)->driver_data;
+	st->chip_info = spi_get_device_match_data(spi);
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
@@ -1140,7 +1140,7 @@ static int ad7192_probe(struct spi_device *spi)
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
 
-	st->clock_sel = ad7192_of_clock_select(st);
+	st->clock_sel = ad7192_clock_select(st);
 
 	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
 	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
@@ -1152,7 +1152,7 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = ad7192_setup(indio_dev, spi->dev.of_node);
+	ret = ad7192_setup(indio_dev, &spi->dev);
 	if (ret)
 		return ret;
 
-- 
2.43.2


