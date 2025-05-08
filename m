Return-Path: <linux-iio+bounces-19327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5AAAB0101
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363504C4918
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC3C2857EA;
	Thu,  8 May 2025 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="B/TuC4Nw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D2283C93;
	Thu,  8 May 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723928; cv=none; b=HoVdpDq6sQH6vuZIDPT/bPkCzJkGDg92UOwlt/KNxV7HiRSyiRJvRxotwDrilyCaoR+ES1glUqMm9/mZDoqXs1KcwPIWgidbi23fK3MZD2XSpQeZ8mFgLwj4xsrbD9Mw5e3lFjCE2N4FH80gmtd+fDlSoXZ+IUBR30GFugi5Q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723928; c=relaxed/simple;
	bh=G90WR2iPUbB/W0xxHWC286PHvT2KYqOZov7+GEl2tCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQErCKvIAFd6m93uOM87xfru+WPy0lcsPZmSQdoh6DGRv4krrHPLNxaCGkxF1Qq/ABHL/uEzz185xs1Y1YZbmhu9bZr64ulrBzIUWMmY50+Mm3EaIiYH0YfKwHSSToodenfTLQvAm/CfNhNPbibU1GJUvnlG/QK2oPQWfU1wlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=B/TuC4Nw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548FSXA8000696;
	Thu, 8 May 2025 13:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kaPzF
	3pSzBLf/mhOa3+GrQFfbAo4BL/PV1KBCk+lUEw=; b=B/TuC4NwOtqM2Ma5d3ayH
	Xi5voPAwaAeEOH84oi1b37lWKze7KrnKYpA4s0azHsWacX6BFKvEp/S2BUbWtbYp
	+ZGp0H74dbu8CW7Tvq7tCXq939MT7wqofCFK2yUS9TxLN9mYH9G/tQ42QaTeJSHn
	ZbpcPYxp1ZmAwSFyCDVWMcvMjSsU2siu6Wriq5P/XtJNVAs35g1R/M4DG33zCePF
	VUJGtgaGVy/g6fO1d2lZ0WhXSfl96BGvdTGAiNI6SEOT1ojo8//I+DJxnpgWFpkS
	zRdcHtidNPYBDY0WsAcbtMtKwiEOdYrjLgGbAs1cbKwGUuTGuxFuLjsF4Qv9EZyA
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46gy9q8ddr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:05:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 548H5I2V052870
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 13:05:18 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 13:05:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 13:05:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 13:05:17 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548H51Lf015902;
	Thu, 8 May 2025 13:05:04 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v7 09/12] iio: adc: ad7768-1: add support for Synchronization over SPI
Date: Thu, 8 May 2025 14:04:59 -0300
Message-ID: <b65b085b29dd08e4f24485f37e7063c463637475.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746662899.git.Jonathan.Santos@analog.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tb4FY0le8AE3yPyCUnsXLgMry3FueU6n
X-Authority-Analysis: v=2.4 cv=f/ZIBPyM c=1 sm=1 tr=0 ts=681ce44f cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=iJ8I5K2Yu_XRBJMqjaQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tb4FY0le8AE3yPyCUnsXLgMry3FueU6n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfX3qEjZXLRZTXY
 aSoIk2LUVrP6KtXAJJg+H+yOkzACmsIElbNxTVPDbVIklbtdfLG6gqSe+nCzBxWsbqvDv5WVaWG
 wL4gqPlivAkvgkI3P+UPfcgszc2jgn6q+3R86hLOXpudbfp7qvYniQDTi5Wl/Lb5bh4f40EW1b7
 fqs2kt/d/acYNPyeQMMWlIwNPehSE2zr8GIFUAMY74TjnYJs3E47UR/Ou2EqMDp99NI3b3fLBJP
 2vc7BDtkg2yx5DPZ/0LKm1py7CV0P3zh3dTm1IlFED4PaLD5CzOjTkJDY6BSip73p4zoFprhVir
 157rcUemOk2Ts41p/PkeaswnmuKDP1X90YJ0siez9cC0wtdAnip7zVQOnWXC9BazYRrlg0qnbo2
 o8XHkGavP7FfNQFZGfW9RWqsvzv21nD3sLqyET1QtlistDkLCQ90dGXsYi+Aul53EMWsW5yL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080149

The synchronization method using GPIO requires the generated pulse to be
truly synchronous with the base MCLK signal. When it is not possible to
do that in hardware, the datasheet recommends using synchronization over
SPI, where the generated pulse is already synchronous with MCLK. This
requires the SYNC_OUT pin to be connected to the SYNC_IN pin.

Use trigger-sources property to enable device synchronization over SPI
and multi-device synchronization while replacing sync-in-gpios property.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v7 Changes:
* Added delay in the synchronization pulse via GPIO.
* replaced device_property_present() for fwnode_property_present().
* Refactored ad7768_trigger_sources_get_sync() to avoid excessive jumps.
* Self triggering is enabled only when the trigger-sources property is
  not defined. Added TODO to support other trigger sources when the subsystem
  is available.

v6 Changes:
* Created macro for the SYNC index from trigger-sources.
* Check trigger source by the compatible string (and the dev node for the
  self triggering).
* Check nargs before accessing the args array.
* Use `trigger-sources` as an alternative to `adi,sync-in-gpios`
  (now optional), instead of replacing it. 

v5 Changes:
* Allow omitting trigger-sources property.
* include gpio-trigger to trigger-sources to replace adi,sync-in-gpios
  property.
* Read trigger-sources cell value to differentiate the trigger type.

v4 Changes:
* None.

v3 Changes:
* Fixed args.fwnode leakage in the trigger-sources parsing.
* Synchronization over spi is enabled when the trigger-sources
  references the own device.
* Synchronization is kept within the device, and return error if the
  gpio is not defined and the trigger-sources reference does not match
  the current device. 

v2 Changes:
* Synchronization via SPI is enabled when the Sync GPIO is not defined.
* now trigger-sources property indicates the synchronization provider or
  main device. The main device will be used to drive the SYNC_IN when
  requested (via GPIO or SPI).
---
 drivers/iio/adc/ad7768-1.c | 111 +++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 19b9744dfd1b..cdcc77ca04fa 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -29,6 +29,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+#include <dt-bindings/iio/adc/adi,ad7768-1.h>
+
 /* AD7768 registers definition */
 #define AD7768_REG_CHIP_TYPE		0x3
 #define AD7768_REG_PROD_ID_L		0x4
@@ -101,6 +103,8 @@
 
 #define AD7768_VCM_OFF			0x07
 
+#define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
+
 enum ad7768_conv_mode {
 	AD7768_CONTINUOUS,
 	AD7768_ONE_SHOT,
@@ -209,6 +213,7 @@ struct ad7768_state {
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
+	bool en_spi_sync;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
 	struct gpio_chip gpiochip;
 	/*
@@ -296,6 +301,27 @@ static const struct regmap_config ad7768_regmap24_config = {
 	.max_register = AD7768_REG24_COEFF_DATA,
 };
 
+static int ad7768_send_sync_pulse(struct ad7768_state *st)
+{
+	if (st->en_spi_sync)
+		return regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x00);
+
+	/*
+	 * The datasheet specifies a minimum SYNC_IN pulse width of 1.5 × Tmclk,
+	 * where Tmclk is the MCLK period. The supported MCLK frequencies range
+	 * from 0.6 MHz to 17 MHz, which corresponds to a minimum SYNC_IN pulse
+	 * width of approximately 2.5 µs in the worst-case scenario (0.6 MHz).
+	 *
+	 * Add a delay to ensure the pulse width is always sufficient to
+	 * trigger synchronization.
+	 */
+	gpiod_set_value_cansleep(st->gpio_sync_in, 1);
+	fsleep(3);
+	gpiod_set_value_cansleep(st->gpio_sync_in, 0);
+
+	return 0;
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -392,10 +418,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 		return ret;
 
 	/* A sync-in pulse is required every time the filter dec rate changes */
-	gpiod_set_value(st->gpio_sync_in, 1);
-	gpiod_set_value(st->gpio_sync_in, 0);
-
-	return 0;
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
@@ -672,6 +695,71 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
+static struct gpio_desc *ad7768_trigger_source_get_gpio(struct device *dev,
+							struct fwnode_handle *fwnode)
+{
+	if (!fwnode_device_is_compatible(fwnode, "gpio-trigger"))
+		return ERR_PTR(-EINVAL);
+
+	return devm_fwnode_gpiod_get_index(dev, fwnode, NULL, 0,
+					   GPIOD_OUT_LOW, "sync-in");
+}
+
+static int ad7768_trigger_sources_get_sync(struct device *dev,
+					   struct ad7768_state *st)
+{
+	struct fwnode_reference_args args;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	int ret;
+
+	/*
+	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
+	 * to synchronize one or more devices:
+	 * 1. Using an external GPIO.
+	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
+	 *    synchronization pulse that drives the SYNC_IN pin.
+	 */
+	if (!fwnode_property_present(fwnode, "trigger-sources")) {
+		/*
+		 * In the absence of trigger-sources property, enable self
+		 * synchronization over SPI (SYNC_OUT).
+		 */
+		st->en_spi_sync = true;
+		return 0;
+	}
+
+	ret = fwnode_property_get_reference_args(fwnode,
+						 "trigger-sources",
+						 "#trigger-source-cells",
+						 0,
+						 AD7768_TRIGGER_SOURCE_SYNC_IDX,
+						 &args);
+	if (ret)
+		return ret;
+
+	fwnode = args.fwnode;
+	/*
+	 * First, try getting the GPIO trigger source and fallback to
+	 * synchronization over SPI in case of failure.
+	 */
+	st->gpio_sync_in = ad7768_trigger_source_get_gpio(dev, fwnode);
+	if (!IS_ERR(st->gpio_sync_in))
+		goto out_put_node;
+
+	/*
+	 * TODO: Support the other cases when we have a trigger subsystem to
+	 * reliably handle other types of devices as trigger sources.
+	 *
+	 * For now, return an error message. For self triggering, omit the
+	 * trigger-sources property.
+	 */
+	ret = dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
+
+out_put_node:
+	fwnode_handle_put(args.fwnode);
+	return ret;
+}
+
 static int ad7768_setup(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
@@ -702,11 +790,22 @@ static int ad7768_setup(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
-					  GPIOD_OUT_LOW);
+	/* For backwards compatibility, try the adi,sync-in-gpios property */
+	st->gpio_sync_in = devm_gpiod_get_optional(&st->spi->dev, "adi,sync-in",
+						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_sync_in))
 		return PTR_ERR(st->gpio_sync_in);
 
+	/*
+	 * If the synchronization is not defined by adi,sync-in-gpios, try the
+	 * trigger-sources.
+	 */
+	if (!st->gpio_sync_in) {
+		ret = ad7768_trigger_sources_get_sync(&st->spi->dev, st);
+		if (ret)
+			return ret;
+	}
+
 	/* Only create a Chip GPIO if flagged for it */
 	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
 		ret = ad7768_gpio_init(indio_dev);
-- 
2.34.1


