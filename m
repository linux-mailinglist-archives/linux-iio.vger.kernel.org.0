Return-Path: <linux-iio+bounces-20223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF5ACE504
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 21:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1E81708F3
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 19:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DDB212B28;
	Wed,  4 Jun 2025 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="a2X0WxIW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB520CCE3;
	Wed,  4 Jun 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065857; cv=none; b=bhKUD8ELwS42c9Jh4DXot6RiJt6i/RX0u9lee5aQtwCKWoihtiGMhi1MKf6glX0bDlVsjTW+Z/La21PSZ94XOINbCQISBxOCQ1GY2IRX+rHEE+jdLM8p/eosFEc+24JEkwMYmaljnJFFTdc3iNS6pG4SjDTSAnZvR32J8xX86tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065857; c=relaxed/simple;
	bh=D0boc1R0ggcwJqx5O2fULBJhyQp9LBJF8BG/7qOaJuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G83jzskiZgEeJKvujfuOhHyrtymE4MEa+mT9IkKV2dW7cSnx1fkQjPv6UBS7aXyzgZrmMD82YZYAMGzBYip3fX9IMewKOw21XQaR+ifn20c9UgwJY0uQJ7mgyUVbV4iKU4R0jqzXSzPr6GEI0s4CeGocRiOszCncaZTtmDxxWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=a2X0WxIW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554G804v029643;
	Wed, 4 Jun 2025 15:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=l1+Z+
	9xcJnRmVNHNgfgd8VtKpmovx08bQXHWO4wYu8I=; b=a2X0WxIWuClucbwT9QQ2d
	XzJW8Sic4E0uWiPQgY+CJxErfnE+YUSdH2jWAzfY6I6wXxLAVznJ5jgh3jgpXIsV
	uuSw/PU8rgmRTc+bhp5Mw+A7tqxvbTH3X9rAjbak0YxXIcjlzXd9e1WV3d3eL6Ck
	d4+DDHYk1UzDBgkhqGZhopqSBPCWnhmUuPeIVCsZYLKOLjjY+F0f7iLIy7zJtIq1
	2HpF7S9O0rstJXtWqmhTTyxgbWvb1xBUXdxMpa6Kju8q6SYxSRhOku6zpW08uC3y
	uJzSKIw1xVrlABd+2LDTlOaeFE6S7GGEwcgMxyZhrBxSJ/JzN8pxLYdQLD46MDKy
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 472p2vhvyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:37:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 554JbSHW044077
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 15:37:28 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 15:37:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 15:37:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 15:37:28 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554JbBLV014357;
	Wed, 4 Jun 2025 15:37:13 -0400
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
Subject: [PATCH v10 09/12] iio: adc: ad7768-1: add support for Synchronization over SPI
Date: Wed, 4 Jun 2025 16:37:09 -0300
Message-ID: <4c8cce58c3f5d84423dffee23c260b94c4cb6c36.1749063024.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749063024.git.Jonathan.Santos@analog.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE1NSBTYWx0ZWRfX6GfI9ggSHbj/
 EgKksvRuvFhjildSepwv9vMyuG4KLZiUzNEYzdjF2HQVWEOK6VS9s/q2+m7gO3JAzSrZts6b28E
 3J4OrRGM7ueM8d1cFnmezBhseYfVkGgpTnHfRwKcHfLvQ7ZNECDOTlLcOEoqyaY6Vi220v2Z4h2
 grRykfOiY2+1Q2OPXK5+YEOXxORDIsDdRS538abYVyeBgrqeAV4AFQU0pPb66f5+1oqdiv6dD4b
 cigOi5IB54ug5zltp3KF9MkWf7EEo6gGUErZjI1/7mdfHiHrE5jJwS4R8hB0uopv0HE7/oIXzYZ
 Hn2MyksU9yV/+u5CXqhfPaKq7aqoY/zGKatbFGBqbIV04l4gqvAneZH6zcsTVOXs3wP6XdcsR85
 bmPQwWeTLwT4iGkeAfqZiwfuoE/6kydRMdHW+xPuyhzVf+UEbVge1221CrB0Aa0lgwOm9eFQ
X-Proofpoint-GUID: kRSrnwqFwYIoDPOkUxNitsrf4qh_PfXT
X-Proofpoint-ORIG-GUID: kRSrnwqFwYIoDPOkUxNitsrf4qh_PfXT
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=6840a079 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=tEw6iXDsky8Zqm_opfkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040155

The synchronization method using GPIO requires the generated pulse to be
truly synchronous with the base MCLK signal. When it is not possible to
do that in hardware, the datasheet recommends using synchronization over
SPI, where the generated pulse is already synchronous with MCLK. This
requires the SYNC_OUT pin to be connected to the SYNC_IN pin.

Use trigger-sources property to enable device synchronization over SPI
and multi-device synchronization while replacing sync-in-gpios property.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v10 Changes:
* Moved gpio delay related changes to the first patch.
* Replaced fwnode_find_reference_args() for  
  fwnode_property_get_reference_args() as discussed in the last version.
  This allows us to discard the new wrapper patch.

v9 Changes:
* Refactored ad7768_trigger_sources_get_sync() again to split the
  trigger-sources setup and to remove the labels/jumps.
* used new fwnode_find_reference_args() to get the trigger-sources
  property with proper cleanup, as recommended.

v8 Changes:
* Putted ad7768_trigger_source_get_gpio() code inline to fix the compatible
  issue.

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
 drivers/iio/adc/ad7768-1.c | 81 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 55913763313d..b2f69bb8195f 100644
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
@@ -211,6 +215,7 @@ struct ad7768_state {
 	struct gpio_desc *gpio_reset;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
 	struct gpio_chip gpiochip;
+	bool en_spi_sync;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -298,6 +303,9 @@ static const struct regmap_config ad7768_regmap24_config = {
 
 static int ad7768_send_sync_pulse(struct ad7768_state *st)
 {
+	if (st->en_spi_sync)
+		return regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x00);
+
 	/*
 	 * The datasheet specifies a minimum SYNC_IN pulse width of 1.5 × Tmclk,
 	 * where Tmclk is the MCLK period. The supported MCLK frequencies range
@@ -687,6 +695,64 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
+static int ad7768_trigger_sources_sync_setup(struct device *dev,
+					     struct fwnode_handle *fwnode,
+					     struct ad7768_state *st)
+{
+	struct fwnode_reference_args args;
+	struct fwnode_handle *ref __free(fwnode_handle) = NULL;
+	int ret;
+
+	ret = fwnode_property_get_reference_args(fwnode, "trigger-sources",
+						 "#trigger-source-cells", 0,
+						 AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);
+	if (ret)
+		return ret;
+
+	ref = args.fwnode;
+	/* First, try getting the GPIO trigger source */
+	if (fwnode_device_is_compatible(ref, "gpio-trigger")) {
+		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, ref, NULL,
+							       0,
+							       GPIOD_OUT_LOW,
+							       "sync-in");
+		return PTR_ERR_OR_ZERO(st->gpio_sync_in);
+	}
+
+	/*
+	 * TODO: Support the other cases when we have a trigger subsystem
+	 * to reliably handle other types of devices as trigger sources.
+	 *
+	 * For now, return an error message. For self triggering, omit the
+	 * trigger-sources property.
+	 */
+	return dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
+}
+
+static int ad7768_trigger_sources_get_sync(struct device *dev,
+					   struct ad7768_state *st)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+
+	/*
+	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
+	 * to synchronize one or more devices:
+	 * 1. Using an external GPIO.
+	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
+	 *    synchronization pulse that drives the SYNC_IN pin.
+	 */
+	if (fwnode_property_present(fwnode, "trigger-sources"))
+		return ad7768_trigger_sources_sync_setup(dev, fwnode, st);
+
+	/*
+	 * In the absence of trigger-sources property, enable self
+	 * synchronization over SPI (SYNC_OUT).
+	 */
+	st->en_spi_sync = true;
+
+	return 0;
+}
+
 static int ad7768_setup(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
@@ -717,11 +783,22 @@ static int ad7768_setup(struct iio_dev *indio_dev)
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


