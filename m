Return-Path: <linux-iio+bounces-18744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46758A9E56A
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 02:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC94F3B9DE7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 00:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAA632C85;
	Mon, 28 Apr 2025 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T5MLodrE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A528691;
	Mon, 28 Apr 2025 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799255; cv=none; b=FcQVKbwN1fBPvbe+cvFUJPROvTa2mLLkOsFoMcnS8p94y1vH8FyfXf286wZJVvMsVxWQJzQBWgZSKZR2pRVWU92ooGvljtfXi3PPB/iQh2SOGQSFAW5+2s0G9dcPN3cFTuzW1pxM8zGnzgNfCufzEc3vezOK+9GqHoOHR7e+J4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799255; c=relaxed/simple;
	bh=vzI7vpYqxK3LKZa3/0Z8HgHTHYhkGuNU9zDq8UqRgpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYYCcH/f56jgy+TXWwHzdaRBnG0IHARQHEET8+bToVAhelnEIw1BPTAqovNpYcBBZQ7WUzi8oeywVBmUKN6ptQNl2EAuzi7KhEERRrYS0K460VYLIV3qBTYbGRRljxUhx0Q0uLGSOElovupNwoTZX7/5R3QEDwGh4fmROk4reOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T5MLodrE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RLOLqA027381;
	Sun, 27 Apr 2025 20:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=42ynx
	of3ILbZoKVu2tHv+K11BEgwaKkOdva48yADnnI=; b=T5MLodrEucdS32Stj8OJG
	RfABSHlf1tVJHi+C4ENaQJWkpd7C5IuUq+7G8/NH5u6oyGSVL6gjWpT6+ZdeYKZB
	vviu2HAuaAXgLGm9b7sYKt0tJ9OMfZeGQM9FbscMgz1ctFuY7VfrDULIK/ktteYS
	nIIvUNrwhqQmu7cstpY7uMjFztPH8W6/B3A3qaPqiV98XluRlHf7/SCaZ0ryLsVt
	Gn/Pfv9WH79RQayAzRXQvvjMMG/IZCO/pk3DU2i+e5VoZ7vmgkzNCJNTsxhGxq2J
	IkuQY3V33o/Xcxk+YJD7Yr13cplNXqEUd58OuGxrZ2UmyubYSUBb/2nzjjqush4o
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 469dtgcmkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Apr 2025 20:14:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53S0E5pd029008
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Apr 2025 20:14:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sun, 27 Apr
 2025 20:14:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Apr 2025 20:14:05 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53S0Dmi8014643;
	Sun, 27 Apr 2025 20:13:50 -0400
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
Subject: [PATCH v6 08/11] iio: adc: ad7768-1: add support for Synchronization over SPI
Date: Sun, 27 Apr 2025 21:13:47 -0300
Message-ID: <c5a5376a6ffbb571d7874218494b04fd20015ee9.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDIwMiBTYWx0ZWRfX40JZ1DxS7TLv DHPhjkQGr98yH/ZJfpW9axp5Lhz6y8PrCP/7guiqz2645rjQdZRW8bJyVIE5xHaGT+tevae5kDD qTJTtIcFzRyC0osKHPe2vZuk/nrG7KyCpMnWwIu6XmYhTEmVm6WmB7ge5qnOPlFrqlAwg3flcxY
 2Uk4QPTr037jii+diY/3RkShUeN3JfeLPktrEUIGCWD9c49kvL/7E8sHT53i01E0yQa3GYKqPae M9UMHEvF1fq6d3ZQNDU65ZDrf2eKCn6Iq0GsYubpir1MND3RuLIJ0J1J9Ym9srekfUpgqPQeGQ9 x/8i0pa35ldKtWjf2r07KzgYMKfg31qYeJy7XlEIPXJGpiPZZ2xjUyRDvnNqIqM5VDjnF8gwLB7
 BHDbKOQBX/n5ORyiFhwzH09ihUKKpstcRaRFcmmnl4nz0Wc6Cr5BOoSP52BNpJhyhTc+MaQY
X-Proofpoint-ORIG-GUID: 206u-n-SiwTHUh3jN6KT-xMylSr2EmTw
X-Proofpoint-GUID: 206u-n-SiwTHUh3jN6KT-xMylSr2EmTw
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=680ec84f cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=tEw6iXDsky8Zqm_opfkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504270202

The synchronization method using GPIO requires the generated pulse to be
truly synchronous with the base MCLK signal. When it is not possible to
do that in hardware, the datasheet recommends using synchronization over
SPI, where the generated pulse is already synchronous with MCLK. This
requires the SYNC_OUT pin to be connected to SYNC_IN pin.

Use trigger-sources property to enable device synchronization over SPI
and multi-device synchronization, as an alternative to adi,sync-in-gpios
property.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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
 drivers/iio/adc/ad7768-1.c | 126 +++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 087478afb5bf..c00571f17254 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -28,6 +28,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+#include <dt-bindings/iio/adc/adi,ad7768-1.h>
+
 /* AD7768 registers definition */
 #define AD7768_REG_CHIP_TYPE		0x3
 #define AD7768_REG_PROD_ID_L		0x4
@@ -100,6 +102,8 @@
 
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
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -295,6 +300,19 @@ static const struct regmap_config ad7768_regmap24_config = {
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
@@ -391,10 +409,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 		return ret;
 
 	/* A sync-in pulse is required every time the filter dec rate changes */
-	gpiod_set_value(st->gpio_sync_in, 1);
-	gpiod_set_value(st->gpio_sync_in, 0);
-
-	return 0;
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
@@ -671,6 +686,94 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
+static struct gpio_desc *ad7768_trigger_source_get_gpio(struct device *dev,
+							struct fwnode_handle *fwnode)
+{
+	const char *value;
+	int ret;
+
+	ret = fwnode_property_read_string(fwnode, "compatible", &value);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (strcmp("gpio-trigger", value))
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
+	struct fwnode_handle *fwnode = NULL;
+	int ret;
+
+	/*
+	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
+	 * to synchronize one or more devices:
+	 * 1. Using an external GPIO.
+	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
+	 *    synchronization pulse that drives the SYNC_IN pin.
+	 */
+	if (!device_property_present(dev, "trigger-sources")) {
+		/*
+		 * In the absence of trigger-sources property, enable self
+		 * synchronization over SPI (SYNC_OUT).
+		 */
+		st->en_spi_sync = true;
+		return 0;
+	}
+
+	ret = fwnode_property_get_reference_args(dev_fwnode(dev),
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
+	if (IS_ERR(st->gpio_sync_in)) {
+		/*
+		 * For this case, it requires one argument, which indicates the
+		 * output pin referenced.
+		 */
+		if (args.nargs < 1)
+			goto err_not_supp;
+
+		if (args.args[0] != AD7768_TRIGGER_SOURCE_SYNC_OUT)
+			goto err_not_supp;
+
+		/*
+		 * Only self trigger is supported for now, i.e.,
+		 * external SYNC_OUT is not allowed.
+		 */
+		if (fwnode->dev == dev) {
+			st->en_spi_sync = true;
+			goto out_put_node;
+		}
+
+		goto err_not_supp;
+	}
+
+	goto out_put_node;
+
+err_not_supp:
+	ret = dev_err_probe(dev, -EOPNOTSUPP,
+			    "Invalid synchronization trigger source");
+out_put_node:
+	fwnode_handle_put(args.fwnode);
+	return ret;
+}
+
 static int ad7768_setup(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
@@ -701,11 +804,22 @@ static int ad7768_setup(struct iio_dev *indio_dev)
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


