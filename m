Return-Path: <linux-iio+bounces-17968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C2DA86293
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61544C0EC3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740A21CA0A;
	Fri, 11 Apr 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="X/g4ZTvN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06C21B196;
	Fri, 11 Apr 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387140; cv=none; b=VdVm9GtoKbvSFR8husNjm3A/r5T9+kgWDiv41EvJh3l42raS/LmqAFRnGTRfiQANd4HrSKCL5kUX0VehrDpR7L9eCcGtVw52pRd1pF2LoO9ktdUAay+2O/ftEJ1iIhH7xqSpRLpS1YGiDpXXNgdh7sZYqSiKoiKfvu4XRedXPRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387140; c=relaxed/simple;
	bh=xf7TEY0YJgeOp2PxjNdimlnP2Y+amy8MzvZpF7qCas4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLJRAmelSzCj8YpSOsZVxJ8XJfHXDeM+ImqLaCHgBXANWaXitTIuz6hiWmbhCCY/1gbO7AYKRvwUPn/K4oS0Dv9V4JrF4YHE2fVeVkQ5dQ+g+JDygbIuYCU9CLhYJXZpUBXW8PQIomJ6wXNXPTQxHVMi61V0dCep+KOzV2/Dfhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=X/g4ZTvN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BDaUuv015166;
	Fri, 11 Apr 2025 11:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=20qjE
	9WDLgISeYV+PNa386vT14xi/5JEj4fjTDcVxOY=; b=X/g4ZTvN7tOqWBTiZ+orf
	SoKmQykAzbqeaNzXVjiKjUZaY2+APK/oSw/3LRif8okI0DxNEPPB61HJvwcA9Nv7
	htvL20luUAvPREksn8ZXuTmYZTRq4B191Dj5nG/ZnBWc2RtCAaK3zCUILq8zelIO
	1LPFDaqlqs1hCSrbwS98rFcDDfjmWwZg9nR8PKRccFHumV8Rv9yMgsDC9Q8PgxNd
	zM9hyEOxAqP8wQkjST27Xd+GyFaor/2eB2BmOZdH8NL01aYdduU4JoEd1t0z9qcO
	yoJhKXvYVydCJ4PBe9bWWfJNOaE5vBqRYVyG6zoH3yX/0t0JD3wmQOtCdx6OXaHK
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6uyqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 11:58:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BFweAU022373
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 11:58:40 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:58:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:58:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 11:58:40 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BFwOjU015645;
	Fri, 11 Apr 2025 11:58:26 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v5 11/14] iio: adc: ad7768-1: add support for Synchronization over SPI
Date: Fri, 11 Apr 2025 12:58:23 -0300
Message-ID: <a4d0951fccade0f8e086416e94c4a38e1a21eb81.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ZnlSepiWOGPZztt4anBrtd7uXiDKjz9h
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f93c31 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=ORBp73c2rqWZOhjnOk4A:9
X-Proofpoint-GUID: ZnlSepiWOGPZztt4anBrtd7uXiDKjz9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110101

The synchronization method using GPIO requires the generated pulse to be
truly synchronous with the base MCLK signal. When it is not possible to
do that in hardware, the datasheet recommends using synchronization over
SPI, where the generated pulse is already synchronous with MCLK. This
requires the SYNC_OUT pin to be connected to SYNC_IN pin.

Use trigger-sources property to enable device synchronization over SPI
and to replace sync-in-gpios property for a gpio-trigger node.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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
 drivers/iio/adc/ad7768-1.c | 100 ++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 179806f821be..aa60c55afd24 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -100,6 +100,11 @@
 
 #define AD7768_VCM_OFF			0x07
 
+enum ad7768_trigger_type {
+	AD7768_TRIGGER_TYPE_GPIO,
+	AD7768_TRIGGER_TYPE_DEV
+};
+
 enum ad7768_conv_mode {
 	AD7768_CONTINUOUS,
 	AD7768_ONE_SHOT,
@@ -209,6 +214,7 @@ struct ad7768_state {
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
+	bool en_spi_sync;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -295,6 +301,19 @@ static const struct regmap_config ad7768_regmap24_config = {
 	.max_register = AD7768_REG24_COEFF_DATA,
 };
 
+static int ad7768_send_sync_pulse(struct ad7768_state *st)
+{
+	if (st->en_spi_sync)
+		return regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x00);
+
+	if (st->gpio_sync_in) {
+		gpiod_set_value_cansleep(st->gpio_sync_in, 1);
+		gpiod_set_value_cansleep(st->gpio_sync_in, 0);
+	}
+
+	return 0;
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -391,10 +410,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 		return ret;
 
 	/* A sync-in pulse is required every time the filter dec rate changes */
-	gpiod_set_value(st->gpio_sync_in, 1);
-	gpiod_set_value(st->gpio_sync_in, 0);
-
-	return 0;
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
@@ -669,6 +685,75 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
+static int ad7768_set_sync_source(struct device *dev, struct ad7768_state *st)
+{
+	struct fwnode_reference_args args;
+	struct fwnode_handle *fwnode = NULL;
+	const char *value;
+	int trigger_type, ret;
+
+	/*
+	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
+	 * to synchronize one or more devices:
+	 * 1. Using a GPIO to directly drive the SYNC_IN pin.
+	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
+	 *    synchronization pulse that loops back to the SYNC_IN pin.
+	 */
+	ret = fwnode_property_get_reference_args(dev_fwnode(dev),
+						 "trigger-sources",
+						 "#trigger-source-cells",
+						 0, 0, &args);
+	if (ret) {
+		/*
+		 * In the absence of trigger-sources property, enable self
+		 * synchronziation via SPI command.
+		 */
+		st->en_spi_sync = true;
+		return 0;
+	}
+
+	trigger_type = args.args[0];
+	fwnode = args.fwnode;
+	if (!fwnode)
+		return dev_err_probe(dev, -ENOENT,
+				     "Invalid or missing fwnode in 'trigger-sources'\n");
+
+	switch (trigger_type) {
+	case AD7768_TRIGGER_TYPE_GPIO:
+		ret = fwnode_property_read_string(fwnode, "compatible", &value);
+		if (ret)
+			goto out_put_node;
+
+		if (strcmp("gpio-trigger", value))
+			goto err_not_supp;
+
+		st->gpio_sync_in = fwnode_gpiod_get_index(fwnode, NULL, 0,
+							  GPIOD_OUT_LOW,
+							  "sync-in");
+		if (IS_ERR(st->gpio_sync_in))
+			ret = PTR_ERR(st->gpio_sync_in);
+
+		goto out_put_node;
+	case AD7768_TRIGGER_TYPE_DEV:
+		/* Only self synchronization is supported for now */
+		if (fwnode->dev == dev) {
+			st->en_spi_sync = true;
+			goto out_put_node;
+		}
+
+		goto err_not_supp;
+	default:
+		goto err_not_supp;
+	}
+
+err_not_supp:
+	ret = -EOPNOTSUPP;
+	dev_err(dev, "Trigger-sources type not supported\n");
+out_put_node:
+	fwnode_handle_put(args.fwnode);
+	return ret;
+}
+
 static int ad7768_setup(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
@@ -699,10 +784,9 @@ static int ad7768_setup(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
-					  GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_sync_in))
-		return PTR_ERR(st->gpio_sync_in);
+	ret = ad7768_set_sync_source(&st->spi->dev, st);
+	if (ret)
+		return ret;
 
 	/* Only create a Chip GPIO if flagged for it */
 	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
-- 
2.34.1


